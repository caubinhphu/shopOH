const filterCheckbox = document.querySelectorAll('input[type="checkbox"]');
const btnPriceRange = document.getElementById('btn-submit-pricetange');
const btnClear = document.getElementById('btn-clear-filter');
const typeDiv = document.querySelectorAll('.category');
const btnSorts = [...document.querySelectorAll('.sort')];
const inputSort = document.querySelector('input[name="sortBy"]');

const urlPage = location.origin + location.pathname;

const sortByBtn = btnSorts.find(btn => btn.dataset.sort === inputSort.value);

if (sortByBtn) {
  sortByBtn.classList.add('sort-active');
}

function submitFormFilter() {
  let form = document.filterForm;
  form.action = `${urlPage}`.replace('/search', '') + '/search';
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
  let backHref = `${urlPage}`.replace('/search', '');
  location.href = backHref;
});

typeDiv.forEach(type => {
  type.addEventListener('click', function() {
    let url = urlPage + '/search?filterType1=' + this.dataset.type;
    location.href = url;
  });
});

btnSorts.forEach(btn => {
  btn.addEventListener('click', function() {
    inputSort.value = this.dataset.sort;
    submitFormFilter();
  });
});

function createUrlPage(page) {
  let stringQuery = new URLSearchParams(location.search);
  stringQuery.set('page', page);
  return stringQuery.toString();
}

const pageInput = document.querySelector('input[name="page"]');

document.querySelector('#page-prev').href =
  urlPage + '?' + createUrlPage(+pageInput.value - 1);

document.querySelector('#page-next').href =
  urlPage + '?' + createUrlPage(+pageInput.value + 1);

document.querySelectorAll('.page-main').forEach(item => {
  item.href = urlPage + '?' + createUrlPage(+item.innerHTML);
});
