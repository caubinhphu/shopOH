const urlPage = location.origin + location.pathname;

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
