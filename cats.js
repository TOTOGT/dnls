/* DNLS cat boxes — every 📦 hides an unobserved cat. Click to collapse. */
(function () {
  var TOTAL = 16; // total boxes across the site
  var KEY = 'dnls-cats-observed';
  var states = [
    'mostly living',
    'mostly living',
    'extremely alive',
    'alive & judging',
    'alive, mildly annoyed',
    'delocalized but purring',
    'self-trapped in the box',
    'norm conserved to <10⁻⁵',
  ];

  function observed() {
    try { return JSON.parse(localStorage.getItem(KEY) || '[]'); } catch (e) { return []; }
  }
  function save(list) {
    try { localStorage.setItem(KEY, JSON.stringify(list)); } catch (e) {}
  }

  // modal
  var modal = document.createElement('div');
  modal.className = 'cat-modal';
  modal.innerHTML =
    '<div class="inner">' +
    '<img alt="A recently observed cat">' +
    '<div class="state"></div>' +
    '<div class="hint">wavefunction collapsed — click anywhere to reseal</div>' +
    '</div>';
  document.body.appendChild(modal);
  modal.addEventListener('click', function () { modal.classList.remove('show'); });

  function updateCounters() {
    var n = observed().length;
    document.querySelectorAll('.cat-counter').forEach(function (el) {
      el.innerHTML = 'cats observed: <b>' + n + ' / ' + TOTAL + '</b>' +
        (n >= TOTAL ? ' — full decoherence achieved 🏆' : '');
    });
  }

  function openBox(box) {
    var id = box.dataset.cat;
    var isErwin = box.dataset.erwin === '1';
    var img = modal.querySelector('img');
    var state = modal.querySelector('.state');
    if (isErwin) {
      img.src = 'https://cataas.com/cat/says/ERWIN%3F!?width=500&height=500&fontSize=48&fontColor=%23ffcf3f&r=' + id;
      state.textContent = 'it’s… schrödinger?!';
    } else {
      img.src = 'https://cataas.com/cat?width=500&height=500&r=dnls-' + id;
      state.textContent = states[Math.floor(Math.random() * states.length)];
    }
    modal.classList.add('show');
    box.classList.add('opened');
    box.textContent = '🐱';
    var list = observed();
    if (list.indexOf(id) === -1) { list.push(id); save(list); updateCounters(); }
  }

  document.querySelectorAll('.catbox').forEach(function (box) {
    if (observed().indexOf(box.dataset.cat) !== -1) {
      box.classList.add('opened');
      box.textContent = '🐱';
    }
    box.title = 'one unobserved cat, superposed';
    box.addEventListener('click', function (e) {
      e.preventDefault(); e.stopPropagation();
      openBox(box);
    });
  });

  updateCounters();

  // animate IPR bars if present
  var bars = document.querySelectorAll('.bar-fill');
  if (bars.length && 'IntersectionObserver' in window) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (e.isIntersecting) { e.target.style.width = e.target.dataset.w + '%'; io.unobserve(e.target); }
      });
    }, { threshold: 0.4 });
    bars.forEach(function (b) { io.observe(b); });
  }

  // citation copy if present
  window.copyCite = function () {
    var t = document.getElementById('citetext');
    if (!t) return;
    navigator.clipboard.writeText(t.textContent.trim());
    var btn = document.querySelector('#citebox button');
    if (btn) { btn.textContent = 'Copied'; setTimeout(function () { btn.textContent = 'Copy'; }, 1500); }
  };
})();
