# ScanQuebec — GitHub Pages

Site statique ScanQC : hub scanners / radio, caméras MTQ, centre ops réseau routier, Live SDR.

## Structure réelle (racine du repo)

| Fichier / dossier | Rôle |
| --- | --- |
| `index.html` | Page publique principale (thème ScanQC, FR/EN) |
| `cameras.html` | Mur de caméras Québec 511 |
| `mtq_ops_center_v6.html` | Centre opérationnel MTQ (carte Leaflet) |
| `live_sdr.html` | Console Live SDR (thème ScanQC + iframe BrowSDR) |
| `live_sdr_vendor/` | Build local optionnel de BrowSDR (généré) |
| `site.css` / `site.js` | Shell multi-panneaux optionnel (no-op si non utilisé) |
| `import-browsdr.sh` / `.ps1` | Import / build BrowSDR → `live_sdr_vendor/` |
| `.github/workflows/deploy-pages.yml` | Déploiement GitHub Pages (unique) |
| `404.html` / `robots.txt` | Pages auxiliaires |

## Contenu live vs local

- **Live (réseau)** : flux caméras Québec 511, LiveATC CYQB, iframe BrowSDR distant.
- **Local / statique** : pages HTML, thème, ops center, éventuellement `live_sdr_vendor/`.

## Déploiement

1. Contenu à la racine du repo (voir tableau ci-dessus).
2. Ops center canonique : **`mtq_ops_center_v6.html`** (référencé depuis `index.html`).
3. Optionnel : `./import-browsdr.sh` ou `.\import-browsdr.ps1` pour publier BrowSDR dans `live_sdr_vendor/`.
4. Commit + push sur `main`.
5. GitHub Pages via le workflow **Deploy GitHub Pages** uniquement.

## Licence tierce

Voir `AGPL_NOTICE.txt` avant de distribuer un build bundlé de BrowSDR.
