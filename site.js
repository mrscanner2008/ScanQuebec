/* ScanQuebec optional shell navigation.
 * Safe no-op when page-dashboard / nav-btn elements are absent
 * (main public site uses standalone index.html pages).
 */
(function () {
  const pageIds = {
    dashboard: document.getElementById('page-dashboard'),
    mtq: document.getElementById('page-mtq'),
    livesdr: document.getElementById('page-livesdr'),
    deploy: document.getElementById('page-deploy')
  };

  const hasShell = Object.values(pageIds).some(Boolean) && document.querySelector('.nav-btn');
  if (!hasShell) return;

  const titles = {
    dashboard: ['Tableau de bord', 'Hub unifié pour ScanQuebec, MTQ Ops Center et Live SDR.'],
    mtq: ['MTQ Ops Center', 'Page locale montée dans le shell principal.'],
    livesdr: ['Live SDR', 'Console radio visuelle inspirée de DSD-FME.'],
    deploy: ['Déploiement', 'Checklist GitHub Pages et structure de repo finale.']
  };

  const titleEl = document.getElementById('topbarTitle');
  const subtitleEl = document.getElementById('topbarSubtitle');

  document.querySelectorAll('.nav-btn').forEach(function (btn) {
    btn.addEventListener('click', function () {
      document.querySelectorAll('.nav-btn').forEach(function (b) { b.classList.remove('active'); });
      Object.keys(pageIds).forEach(function (key) {
        if (pageIds[key]) pageIds[key].classList.remove('active');
      });
      btn.classList.add('active');
      const key = btn.dataset.page;
      if (pageIds[key]) pageIds[key].classList.add('active');
      if (titles[key]) {
        if (titleEl) titleEl.textContent = titles[key][0];
        if (subtitleEl) subtitleEl.textContent = titles[key][1];
      }
    });
  });
})();
