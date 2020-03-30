const delProBtns = document.querySelectorAll('.del-pro-btn');
const delOkBtn = document.getElementById('OK-del-btn');

delProBtns.forEach(btn => {
  btn.addEventListener('click', function() {
    delOkBtn.dataset.idpro = this.dataset.idpro;
  });
});

delOkBtn.addEventListener('click', function() {
  axios
    .delete(`/admin/product/${this.dataset.idpro}`)
    .then(res => {
      if (res.status === 200) {
        location.reload();
      }
    })
    .catch(err => location.reload());
});
