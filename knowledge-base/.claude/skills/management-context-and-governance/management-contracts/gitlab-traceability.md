# GitLab Traceability Contract v1

## Mandatory context

- `project_id`: provided by the user.
- `GITLAB_PAT`: read only from the environment; never persist or log it.
- `repository`: `collaboration`.

## Entity rules

| Entity | GitLab relation | Required identifiers | Labels |
|---|---|---|---|
| DSP / Project | Project Issue | `issue_id`, `issue_iid`, `issue_url` | `Proyecto` |
| SSP / Sprint | Milestone only | `milestone_id`, `milestone_url` | None |
| HU-* / User Story | Canonical Issue 1:1 | `issue_id`, `issue_iid`, `issue_url` | `User Story`, `AI Cowork` |

The DSP ↔ Project Issue and HU-* ↔ User Story Issue relations are bidirectional. The SSP stores only the SSP ↔ Milestone relation; it does not have a Sprint Issue.

## References to artifacts

Every reference to a project artifact (DSP, SSP, US-*, RCP, packs) has two forms of access:

- **Repository:** an absolute URL, `{web_url}/-/blob/{ref}/{path}`. The repository is the workspace's (`remote "origin"` in `.git/config`, converted to its web URL without credentials); if the workspace has no `.git`, the repository the owner declared for the product. It can differ from `project_id`, where the Project Issue, the Issues and the Milestones live. Default `ref`: `main`.
- **Local:** the path from the workspace root. In a file inside the workspace it is a relative markdown link, which makes local navigation easy. In GitLab text (Issues, Milestones) it is the path in code, because a relative link does not resolve there.

Before publishing a URL, check that the file exists in that branch (`GET /projects/{id}/repository/files/{path}?ref={ref}`). If it does not, do not publish a broken link: publish only the `Local` form and mark the URL as pending.

Any GitLab mutation requires `PENDING_APPROVAL` followed by an explicit human `APPROVED` decision. A rejected or missing decision means `BLOCKED`.

