-- p3m_curricula: datos fijos por BR-011 (Junior, Semisenior y Senior, cada uno con L1 a L4).
-- No se siembran roles (BR-001) ni competencias.

INSERT INTO seniority (nombre) VALUES ('JUNIOR'), ('SEMISENIOR'), ('SENIOR');

INSERT INTO nivel_de_desarrollo (seniority_id, nivel)
SELECT s.id, n.nivel
FROM seniority s
CROSS JOIN (SELECT 'L1' AS nivel UNION ALL SELECT 'L2' UNION ALL SELECT 'L3' UNION ALL SELECT 'L4') n;
