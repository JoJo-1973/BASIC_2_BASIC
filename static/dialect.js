// Dialect page: entry filters, table panels, glyph drawing.
(function () {
  "use strict";

  function norm(s) {
    return (s || "").toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g, "");
  }

  // ---------------------------------------------------------------- entries
  var selCat = document.getElementById("filter-category");
  var text = document.getElementById("filter-text");
  var count = document.getElementById("count");
  var KEY = "b2b-entry-category";

  // menu value: "CATEGORY" or "CATEGORY:CLASS" (operator classes)
  function filter() {
    var parts = selCat.value.split(":"), c = parts[0], cl = parts[1] || "";
    var q = norm(text.value.trim()), seen = {};
    document.querySelectorAll("section.category-entries").forEach(function (sec) {
      var rows = 0;
      var catOk = !c || sec.dataset.category === c;
      sec.querySelectorAll("table.entries").forEach(function (t) {
        var n = 0;
        var clOk = catOk && (!cl || t.dataset.class === cl);
        t.querySelectorAll("tr[data-text]").forEach(function (tr) {
          var ok = clOk && (!q || norm(tr.dataset.text).indexOf(q) >= 0);
          tr.hidden = !ok;
          if (ok) { n++; seen[tr.dataset.entry] = 1; }
        });
        t.hidden = !n;
        var sg = t.closest(".subgroup");
        if (sg) sg.hidden = !n;
        rows += n;
      });
      sec.hidden = !rows;
    });
    var total = Object.keys(seen).length;
    count.textContent = total + (total === 1 ? " entry" : " entries");
    try { sessionStorage.setItem(KEY, selCat.value); } catch (e) {}
  }
  if (selCat) {
    try {
      var saved = sessionStorage.getItem(KEY);
      if (saved && selCat.querySelector('option[value="' + saved + '"]')) selCat.value = saved;
    } catch (e) {}
    selCat.addEventListener("change", filter);
    text.addEventListener("input", filter);
    filter();
  }

  // ---------------------------------------------------------------- panels
  function open(id, updateAddress) {
    var d = document.getElementById(id);
    if (!d || d.tagName !== "DIALOG") return false;
    document.querySelectorAll("dialog[open]").forEach(function (x) { x.close(); });
    d.showModal();
    if (updateAddress) history.replaceState(null, "", "#" + id);
    return true;
  }
  document.querySelectorAll("a[data-panel]").forEach(function (a) {
    a.addEventListener("click", function (e) {
      if (open(a.getAttribute("href").slice(1), true)) e.preventDefault();
    });
  });
  document.querySelectorAll("dialog.panel").forEach(function (d) {
    d.querySelector(".close").addEventListener("click", function () { d.close(); });
    d.addEventListener("click", function (e) { if (e.target === d) d.close(); });   // click outside
    d.addEventListener("close", function () {
      if (location.hash === "#" + d.id) history.replaceState(null, "", location.pathname + location.search);
    });
  });
  // arriving from another link (e.g. "precedence table" or the token search)
  if (location.hash) open(location.hash.slice(1), false);
  window.addEventListener("hashchange", function () { open(location.hash.slice(1), false); });

  // ---------------------------------------------------------------- glyphs
  document.querySelectorAll("table.glyphs").forEach(function (t) {
    // one scale for both axes, so the glyph keeps its shape (8x8 -> 3, 5x7 -> 3, 8x16 -> 2)
    var w = +t.dataset.width, h = +t.dataset.height;
    var scale = Math.max(1, Math.round(24 / Math.max(w, h)));
    var rowBytes = Math.ceil(w / 8);
    t.querySelectorAll("canvas[data-b]").forEach(function (cv) {
      var hex = cv.dataset.b, inv = cv.dataset.inverse === "1";   // inverted by the hardware
      cv.width = w * scale; cv.height = h * scale;
      cv.style.width = cv.width + "px"; cv.style.height = cv.height + "px";
      var ctx = cv.getContext("2d");
      ctx.fillStyle = getComputedStyle(cv).color;
      for (var y = 0; y < h; y++) {
        for (var k = 0; k < rowBytes; k++) {
          var b = parseInt(hex.substr((y * rowBytes + k) * 2, 2), 16);
          for (var x = 0; x < 8 && k * 8 + x < w; x++) {
            if (!!(b & (0x80 >> x)) !== inv) ctx.fillRect((k * 8 + x) * scale, y * scale, scale, scale);
          }
        }
      }
    });
  });
})();
