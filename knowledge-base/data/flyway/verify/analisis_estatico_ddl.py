import glob, os, re, sys, json
import sqlglot
from sqlglot import exp

ROOT = sys.argv[1]
schemas = sorted(d for d in os.listdir(ROOT) if d.startswith("p3m_"))
report = {}
errors = []
tables_by_schema = {}

for sch in schemas:
    files = sorted(glob.glob(os.path.join(ROOT, sch, "V*.sql")))
    created = {}   # tabla -> {"pk": [...], "uniques": [[...]], "cols": {...}}
    fk_count = ck_count = 0
    for f in files:
        sql = open(f, encoding="utf-8").read()
        # sqlglot (dialecto mysql): sintaxis
        try:
            stmts = sqlglot.parse(re.sub(r"\)\s+(VIRTUAL|STORED)\s*,", "),", sql), read="mysql")
        except Exception as e:
            errors.append(f"{f}: no parsea: {e}")
            continue
        raw_tables = re.findall(r"CREATE TABLE (\w+) \((.*?)\)\s*ENGINE=(\w+) DEFAULT CHARSET=(\w+) COLLATE=(\w+);", sql, re.S)
        for name, body, eng, cs, co in raw_tables:
            if eng != "InnoDB" or cs != "utf8mb4" or co != "utf8mb4_0900_ai_ci":
                errors.append(f"{sch}.{name}: motor/charset/collation inesperado {eng}/{cs}/{co}")
            cols = {}
            for line in body.split("\n"):
                m = re.match(r"\s+(\w+)\s+((?:BIGINT|SMALLINT|TINYINT|VARCHAR|CHAR|DECIMAL|DATETIME|DATE|TEXT|JSON|BINARY)[^,]*?)(?:,|$)", line)
                if m and m.group(1).upper() not in ("CONSTRAINT", "KEY", "PRIMARY", "UNIQUE"):
                    cols[m.group(1)] = m.group(2)
            pk = re.search(r"PRIMARY KEY \(([^)]*)\)", body)
            uniques = [ [c.strip() for c in u.split(",")] for u in re.findall(r"UNIQUE \(([^)]*)\)", body)]
            created[name] = {"pk": [c.strip() for c in pk.group(1).split(",")] if pk else [], "uniques": uniques, "cols": cols}
            # FKs
            for fkcols, parent, pcols in re.findall(r"FOREIGN KEY \(([^)]*)\) REFERENCES (\w+(?:\.\w+)?) \(([^)]*)\)", re.sub(r"\s+", " ", body)):
                fk_count += 1
                if "." in parent:
                    errors.append(f"{sch}.{name}: FK entre esquemas hacia {parent}")
                    continue
                if parent not in created:
                    errors.append(f"{sch}.{name}: FK hacia {parent} no creado antes en el mismo esquema")
                    continue
                pc = [c.strip() for c in pcols.split(",")]
                keys = [created[parent]["pk"]] + created[parent]["uniques"]
                if pc not in keys:
                    errors.append(f"{sch}.{name}: FK ({fkcols}) -> {parent}({pcols}) no coincide con PK/UNIQUE del padre")
                fc = [c.strip() for c in fkcols.split(",")]
                for a, b in zip(fc, pc):
                    ta = created[name]["cols"].get(a); tb = created[parent]["cols"].get(b)
                    if ta is None or tb is None:
                        errors.append(f"{sch}.{name}: no se pudo leer el tipo de {a} o {parent}.{b}")
                    else:
                        ta = re.sub(r'\s+',' ',ta); tb = re.sub(r'\s+',' ',tb)
                        na = re.sub(r"\s+(NOT NULL|NULL|DEFAULT.*|GENERATED.*)$", "", ta).strip().upper()
                        nb = re.sub(r"\s+(NOT NULL|NULL|DEFAULT.*|AUTO_INCREMENT|GENERATED.*)$", "", tb).strip().upper()
                        if na.split(" NOT")[0] != nb.split(" NOT")[0]:
                            errors.append(f"{sch}.{name}: tipo de {a} ({na}) distinto de {parent}.{b} ({nb})")
            ck_count += len(re.findall(r"CHECK \(", body))
            if re.search(r"REFERENCES\s+p3m_", body):
                errors.append(f"{sch}.{name}: referencia a otro esquema")
    tables_by_schema[sch] = list(created.keys())
    report[sch] = {"tablas": len(created), "fk": fk_count, "check": ck_count, "migraciones": [os.path.basename(f) for f in files]}

print(json.dumps(report, indent=1, ensure_ascii=False))
print("tablas:", sum(len(v) for v in tables_by_schema.values()))
json.dump(tables_by_schema, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), "tablas_detectadas.json"), "w"))
print("ERRORES:" if errors else "sin errores")
for e in errors:
    print(" -", e)
