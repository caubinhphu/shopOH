const filterCheckbox = document.querySelectorAll('input[type="checkbox"]');
const btnPriceRange = document.getElementById('btn-submit-pricetange');
const btnClear = document.getElementById('btn-clear-filter');
const typeDiv = document.querySelectorAll('.category');
const btnSorts = [...document.querySelectorAll('.sort')];
const inputSort = document.querySelector('input[name="sortBy"]');

btnSorts
  .find(btn => btn.dataset.sort === inputSort.value)
  .classList.add('sort-active');

function submitFormFilter() {
  let form = document.filterForm;
  form.action = location.href + '/search';
  form.submit();
}

filterCheckbox.forEach(function(checkbox) {
  checkbox.addEventListener('change', async function() {
    submitFormFilter();
  });
});

btnPriceRange.addEventListener('click', function() {
  submitFormFilter();
});

btnClear.addEventListener('click', function() {
  let backHref = `${location.origin}${location.pathname}`.replace(
    '/search',
    ''
  );
  location.href = backHref;
});

typeDiv.forEach(type => {
  type.addEventListener('click', function() {
    let url = location.href + '/search?filterType1=' + this.dataset.type;
    location.href = url;
  });
});

btnSorts.forEach(btn => {
  btn.addEventListener('click', function() {
    inputSort.value = this.dataset.sort;
    submitFormFilter();
  });
});
