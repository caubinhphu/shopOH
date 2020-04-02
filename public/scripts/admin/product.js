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
        // location.reload();
        document
          .querySelector(`.del-pro-btn[idpro=${this.dataset.idpro}]`)
          .parentElement.parentElement.remove();
      }
    })
    .catch(err => location.reload());
});

document.formFilterSort.addEventListener('submit', function(e) {
  e.preventDefault();
  [...this.elements].forEach(item => {
    if (item.value === '') {
      item.setAttribute('disabled', 'disabled');
    }
  });
  this.submit();
});

function resetForm(form) {
  // clearing inputs
  let inputs = form.getElementsByTagName('input');
  for (let i = 0; i < inputs.length; i++) {
    switch (inputs[i].type) {
      case 'hidden':
        break;
      case 'text':
      case 'number':
        inputs[i].value = '';
        break;
      case 'radio':
      case 'checkbox':
        inputs[i].checked = false;
    }
  }

  // clearing selects
  let selects = form.getElementsByTagName('select');
  for (let i = 0; i < selects.length; i++) selects[i].selectedIndex = 0;

  // clearing textarea
  // let text= form.getElementsByTagName('textarea');
  // for (let i = 0; i<text.length; i++)
  //     text[i].innerHTML= '';

  // return false;
}

document.getElementById('re-enter-btn').addEventListener('click', function() {
  resetForm(document.formFilterSort);
});
