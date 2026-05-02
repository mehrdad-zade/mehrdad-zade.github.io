(function () {
  'use strict';

  /* ── Scroll-progress bar ── */
  var progressBar = document.getElementById('scroll-progress');
  function updateProgress() {
    var max = document.documentElement.scrollHeight - window.innerHeight;
    if (max <= 0) return;
    progressBar.style.width = ((window.scrollY / max) * 100) + '%';
  }

  /* ── Nav: frosted glass on scroll ── */
  var nav = document.getElementById('topnav');
  function updateNav() {
    nav.classList.toggle('scrolled', window.scrollY > 30);
  }

  /* ── Active nav link ── */
  var sections   = Array.from(document.querySelectorAll('section[id]'));
  var navLinks   = Array.from(document.querySelectorAll('.nav-link[data-s]'));
  function updateActive() {
    var current = '';
    sections.forEach(function (s) {
      if (window.scrollY >= s.offsetTop - 100) current = s.id;
    });
    navLinks.forEach(function (a) {
      a.classList.toggle('active', a.dataset.s === current);
    });
  }

  window.addEventListener('scroll', function () {
    updateProgress();
    updateNav();
    updateActive();
  }, { passive: true });

  /* ── Mobile nav toggle ── */
  var toggle   = document.querySelector('.nav-toggle');
  var linkMenu = document.getElementById('nav-links');
  toggle.addEventListener('click', function () {
    var open = linkMenu.classList.toggle('open');
    toggle.classList.toggle('open', open);
    toggle.setAttribute('aria-expanded', String(open));
  });
  linkMenu.querySelectorAll('.nav-link').forEach(function (a) {
    a.addEventListener('click', function () {
      linkMenu.classList.remove('open');
      toggle.classList.remove('open');
      toggle.setAttribute('aria-expanded', 'false');
    });
  });

  /* ── Reveal on scroll ── */
  var reveals = Array.from(document.querySelectorAll('.reveal'));
  var io = new IntersectionObserver(function (entries) {
    entries.forEach(function (e) {
      if (e.isIntersecting) {
        e.target.classList.add('visible');
        io.unobserve(e.target);
      }
    });
  }, { threshold: 0.07, rootMargin: '0px 0px -36px 0px' });
  reveals.forEach(function (el) { io.observe(el); });

  /* ── Initial state ── */
  updateNav();
  updateActive();
  updateProgress();
})();
