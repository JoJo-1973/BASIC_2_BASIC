// Filters of the Actions page: dialect and category (action group).
(function () {
  "use strict";
  var selD = document.getElementById("filter-dialect");
  var selG = document.getElementById("filter-group");
  var table = document.getElementById("matrix");
  var count = document.getElementById("count");
  var KEY = "b2b-action-filters";

  function apply() {
    var d = selD.value, g = selG.value, visible = 0;
    table.querySelectorAll("tbody").forEach(function (tb) {
      var rows = 0;
      var groupOk = !g || tb.dataset.group === g;
      tb.querySelectorAll("tr.action-row").forEach(function (tr) {
        var ok = groupOk && (!d || tr.dataset.dialects.indexOf(" " + d + " ") >= 0);
        tr.hidden = !ok;
        if (ok) rows++;
      });
      tb.hidden = !rows;
      visible += rows;
    });
    // with a dialect selected only its column is shown
    table.querySelectorAll("[data-dialect]").forEach(function (c) {
      c.hidden = !!d && c.dataset.dialect !== d;
    });
    table.querySelectorAll("tr.group th").forEach(function (th) {
      th.colSpan = d ? 2 : table.tHead.rows[0].cells.length;
    });
    count.textContent = visible + (visible === 1 ? " action" : " actions");
    try { sessionStorage.setItem(KEY, JSON.stringify({ d: d, g: g })); } catch (e) {}
  }

  // restore the filters, unless arriving to see a specific action
  try {
    var s = JSON.parse(sessionStorage.getItem(KEY) || "null");
    if (s && !location.hash) {
      if (selD.querySelector('option[value="' + s.d + '"]')) selD.value = s.d;
      if (selG.querySelector('option[value="' + s.g + '"]')) selG.value = s.g;
    }
  } catch (e) {}

  selD.addEventListener("change", apply);
  selG.addEventListener("change", apply);
  apply();
})();
