const filterCheckbox = document.querySelectorAll('input[type="checkbox"]');
const btnPriceRange = document.getElementById('btn-submit-pricetange');
const btnClear = document.getElementById('btn-clear-filter');

filterCheckbox.forEach(function(checkbox) {
  checkbox.addEventListener('change', async function() {
    let form = document.filterForm;
    form.action = location.href + '/search';
    form.submit();
  });
});

btnPriceRange.addEventListener('click', function() {
  let form = document.filterForm;
  form.action = location.href + '/search';
  form.submit();
});

btnClear.addEventListener('click', function() {
  let backHref = `${location.origin}${location.pathname}`.replace(
    '/search',
    ''
  );
  location.href = backHref;
});
