# GITHUB_SETUP — Mise en place initiale

Étapes pour activer ce squelette sur un vrai repo GitHub.

## 1. Créer le repo
```bash
cd VORALYS
git init
git add .
git commit -m "chore: scaffold initial VORALYS (architecture, agents, CI, templates)"
git branch -M main
git remote add origin https://github.com/<org>/voralys.git
git push -u origin main
```

## 2. Créer les branches persistantes
```bash
git checkout -b develop && git push -u origin develop
git checkout -b staging && git push -u origin staging
git checkout main
```

## 3. Protéger les branches
Sur GitHub → Settings → Branches → Add rule, pour `main`, `staging`, `develop` :
- Require a pull request before merging (2 approbations sur `main`, 1 ailleurs)
- Require status checks to pass (CI) before merging
- Require review from Code Owners
- Interdire le force-push et la suppression de branche

## 4. Activer CODEOWNERS
Remplacer dans `.github/CODEOWNERS` les placeholders `@dosso`, `@kevin`, `@david`, `@ahiko`,
`@patrick`, `@dev-team`, `@cyber-team`, `@qa-team` par les vrais handles GitHub (utilisateurs
ou teams de l'organisation).

## 5. Créer les labels
```bash
gh label create "agent-task" --color "1D76DB"
gh label create "audit-finding" --color "D93F0B"
gh label create "role:dosso" --color "5319E7"
gh label create "role:kevin" --color "5319E7"
gh label create "role:david" --color "5319E7"
gh label create "role:ahiko" --color "5319E7"
gh label create "role:patrick" --color "5319E7"
gh label create "role:audit" --color "0E8A16"
gh label create "role:qa" --color "0E8A16"
for i in $(seq -w 1 20); do gh label create "agent:AG$i" --color "C2E0C6" 2>/dev/null; done
```

## 6. Créer un GitHub Project (vue Kanban partagée)
GitHub → Projects → New Project → Board. Colonnes recommandées :
`Cadrage → Conception → Master Spec → Revue interne → Flow → Tests → PR ouverte → Audit → Correction → Approuvé → En prod`

Cela donne à Dev/Data/Cyber/QA et aux 5 membres de l'équipe agentique une vue unique de
l'avancement de chaque agent, sans dépendre de canaux séparés.

## 7. Scaffolder un agent et ses issues
```bash
bash scripts/new_agent.sh AG02 "Regulatory Watch"
bash scripts/create_agent_issues.sh AG02 "Regulatory Watch"
```

## 8. Répéter pour AG02 à AG20
Décliner à partir du template validé lors du POC (voir `docs/architecture/SYSTEM_ARCHITECTURE.md`
Phase 1 : AG01, AG03, AG05, AG07, AG09, AG17 en priorité).
