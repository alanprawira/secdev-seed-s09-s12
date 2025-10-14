# secdev-seed-s09-s12

Учебный seed под S09-S12. Даёт:

- минимальный сервис (FastAPI),
- конфиги Syft/Grype/Trivy, Semgrep/Gitleaks, ZAP, Hadolint/Checkov,
- 4 workflow: S09 SBOM/SCA, S10 SAST/Secrets, S11 DAST, S12 IaC/Container.

> ⚠️ Это учебный репозиторий с намеренно упрощённой безопасностью. Не деплойте в публичный прод.

## Быстрый старт (локально)

```bash
python -m venv .venv && . .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --port 8080 --reload
# откройте http://localhost:8080
```

Docker:

```bash
docker build -t s09s12-app:local .
docker run --rm -p 8080:8080 s09s12-app:local
# или docker compose up -d
```

## Что делать на S09-S12

- **S09 - SBOM & SCA:** сгенерировать SBOM (Syft), просканировать зависимости (Grype/Trivy).
- **S10 - SAST & Secrets:** Semgrep (SARIF), Gitleaks (JSON).
- **S11 - DAST:** поднять локально сервис и прогнать ZAP Baseline (и Full при желании).
- **S12 - IaC & Containers:** Hadolint (Dockerfile), Checkov (iac/), Trivy (image+config).

Каждый семинар запускается своим workflow в **GitHub Actions**:
`ci-s09-sbom-sca.yml`, `ci-s10-sast-secrets.yml`, `ci-s11-dast.yml`, `ci-s12-iac-container.yml`.
Все складывают отчёты в `EVIDENCE/S09…S12/` и как artifacts job.

### Самопроверка (прозрачно и быстро)

1) Вкладка **Actions** → соответствующий workflow зелёный.  
2) В artifacts job есть ожидаемые файлы (см. ниже `EVIDENCE`).  
3) В `GRADING/DS.md` у вас есть короткая запись + ссылка на job.

### Папки с артефактами

- `EVIDENCE/S09/`: `sbom.json`, `sca_report.json`, `sca_summary.md`
- `EVIDENCE/S10/`: `semgrep.sarif`, `gitleaks.json`
- `EVIDENCE/S11/`: `zap_baseline.html`, `zap_baseline.json` (опц. `zap_full.*`)
- `EVIDENCE/S12/`: `hadolint.json`, `checkov.json`, `trivy.json` (опц. `attestation.json`)

> По умолчанию workflow не «валят» билд. Хотите пороги - включите переменные ENV `FAIL_ON_SEVERITY=high` и т.п. в секции «Inputs».

### Важно

- Репозиторий предназначен для обучения. Не публикуйте реальные секреты, не деплойте наружу.
- Если работаем в Docker/Actions: инструменты запускаются через готовые образы, версии закреплять не требуется.
