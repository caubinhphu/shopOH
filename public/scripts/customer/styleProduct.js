const filterCheckbox = document.querySelectorAll('input[type="checkbox"]');

filterCheckbox.forEach(function(checkbox) {
  checkbox.addEventListener('change', async function() {
    let form = document.filterForm;
    form.action = location.href + '/search';
    form.submit();
  });
});
