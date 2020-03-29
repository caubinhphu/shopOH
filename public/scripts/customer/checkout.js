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

document
  .getElementById('address-complete-btn')
  .addEventListener('click', function() {
    document.getElementById('address').innerHTML = document.querySelector(
      'input[name="address"]:checked'
    ).nextSibling.innerHTML;
    document.getElementById('address-choose').style.display = 'block';
    document.getElementById('address-select').style.display = 'none';
  });

document.getElementById('checkout-btn').addEventListener('click', function() {
  axios
    .post('http://localhost:3000/checkout', {
      token: location.search.replace('?token=', ''),
      address: document.querySelector('input[name="address"]:checked').value
    })
    .then(res => {
      if (res.status === 200) {
        location.href = 'http://localhost:3000/account/purchase';
      }
    })
    .catch(err => location.reload());
});
