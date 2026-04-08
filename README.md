# ScanQuebec GitHub Pages aggressive edition

- thème unifié ScanQuebec
- menu latéral type centre de contrôle
- shell principal à panneaux
- page Live SDR visuellement plus proche de DSD-FME
- montage statique BrowSDR via `/live_sdr_vendor/`

## Déploiement
1. Déposer tout le contenu du ZIP à la racine du repo.
2. Remplacer `mtq_ops_center_v5.html` par ta vraie page.
3. Lancer `scripts/import-browsdr.ps1` ou `scripts/import-browsdr.sh`.
4. Vérifier que le build final est bien copié dans `live_sdr_vendor/`.
5. Commit + push sur `main`.
6. Activer GitHub Pages avec GitHub Actions.
