document
  .getElementById('change-address-btn')
  .addEventListener('click', function() {
    document.getElementById('address-choose').style.display = 'none';
    document.getElementById('address-select').style.display = 'block';
  });

document.getElementById('address-cancel').addEventListener('click', function() {
  document.getElementById('address-choose').style.display = 'block';
  document.getElementById('address-select').style.display = 'none';
});
