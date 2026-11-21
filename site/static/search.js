// Search in the top bar (index in search_index.js) and table filters.
(function () {
  "use strict";
  var root = document.body.dataset.root || "";
  var field = document.getElementById("search");
  var list = document.getElementById("results");
  var index = window.SEARCH_INDEX || [];
  var selected = -1;

  function norm(s) {
    return (s || "").toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g, "");
  }
  index.forEach(function (x) { x._t = norm(x.t); x._d = norm(x.d); });

  function search(q) {
    q = norm(q.trim());
    if (!q) return [];
    var exact = [], prefix = [], inside = [], descr = [];
    index.forEach(function (x) {
      if (x._t === q) exact.push(x);
      else if (x._t.indexOf(q) === 0) prefix.push(x);
      else if (x._t.indexOf(q) > 0) inside.push(x);
      else if (q.length > 2 && x._d.indexOf(q) >= 0) descr.push(x);
    });
    return exact.concat(prefix, inside, descr).slice(0, 40);
  }

  function show() {
    var found = search(field.value);
    list.innerHTML = "";
    selected = -1;
    if (!field.value.trim()) { list.hidden = true; return; }
    if (!found.length) {
      list.innerHTML = '<li class="empty">No results</li>';
    }
    found.forEach(function (x) {
      var li = document.createElement("li");
      var a = document.createElement("a");
      a.href = root + x.u;
      a.innerHTML = '<span class="kind"></span><strong></strong><small></small>';
      a.children[0].textContent = x.k;
      a.children[1].textContent = x.t;
      a.children[2].textContent = x.d;
      li.appendChild(a);
      list.appendChild(li);
    });
    list.hidden = false;
  }

  function highlight(n) {
    var links = list.querySelectorAll("a");
    if (!links.length) return;
    selected = (n + links.length) % links.length;
    links.forEach(function (a, i) { a.classList.toggle("active", i === selected); });
    links[selected].scrollIntoView({ block: "nearest" });
  }

  if (field) {
    field.addEventListener("input", show);
    field.addEventListener("keydown", function (e) {
      if (e.key === "ArrowDown") { highlight(selected + 1); e.preventDefault(); }
      else if (e.key === "ArrowUp") { highlight(selected - 1); e.preventDefault(); }
      else if (e.key === "Enter") {
        var links = list.querySelectorAll("a");
        var a = links[selected >= 0 ? selected : 0];
        if (a) location.href = a.href;
      } else if (e.key === "Escape") { field.value = ""; show(); }
    });
    document.addEventListener("click", function (e) {
      if (!e.target.closest(".search")) list.hidden = true;
    });
    field.addEventListener("focus", function () { if (field.value.trim()) show(); });
    document.addEventListener("keydown", function (e) {
      if (e.key === "/" && document.activeElement.tagName !== "INPUT" && document.activeElement.tagName !== "SELECT") {
        field.focus(); e.preventDefault();
      }
    });
  }

  // Row filter: <input data-filter="#container"> on the rows with data-text
  document.querySelectorAll("input[data-filter]").forEach(function (f) {
    var box = document.querySelector(f.dataset.filter);
    f.addEventListener("input", function () {
      var q = norm(f.value.trim());
      box.querySelectorAll("tr[data-text]").forEach(function (tr) {
        tr.hidden = q && norm(tr.dataset.text).indexOf(q) < 0;
      });
      box.querySelectorAll("table").forEach(function (t) {
        var visible = t.querySelectorAll("tr[data-text]:not([hidden])").length;
        t.hidden = !visible;
        var h = t.previousElementSibling;
        if (h && h.tagName === "H3") h.hidden = !visible;
      });
    });
  });
})();
