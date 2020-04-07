let danhMuc = [];

if (!sessionStorage.getItem('danhmuc')) {
  axios
    .get('http://localhost:3000/admin/danhmuc')
    .then((res) => {
      if (
        res.status === 200 &&
        /application\/json/.test(res.headers['content-type'])
      ) {
        sessionStorage.setItem('danhmuc', JSON.stringify(res.data));
      } else {
        location.href = 'http://localhost:3000/adminAuth';
      }
    })
    .then(() => {
      danhMuc = JSON.parse(sessionStorage.getItem('danhmuc'));
      afterLoadDanhMuc();
    })
    .catch((err) => (location.href = 'http://localhost:3000/adminAuth'));
} else {
  danhMuc = JSON.parse(sessionStorage.getItem('danhmuc'));
  afterLoadDanhMuc();
}

function afterLoadDanhMuc() {
  const delProBtns = document.querySelectorAll('.del-pro-btn');
  const delOkBtn = document.getElementById('OK-del-btn');

  delProBtns.forEach((btn) => {
    btn.addEventListener('click', function () {
      delOkBtn.dataset.idpro = this.dataset.idpro;
    });
  });

  delOkBtn.addEventListener('click', function () {
    axios
      .delete(`/admin/product/${this.dataset.idpro}`)
      .then((res) => {
        if (res.status === 200) {
          // location.reload();
          document
            .querySelector(`.del-pro-btn[idpro=${this.dataset.idpro}]`)
            .parentElement.parentElement.remove();
        }
      })
      .catch((err) => location.reload());
  });

  document.formFilterSort.addEventListener('submit', function (e) {
    e.preventDefault();
    [...this.elements].forEach((item) => {
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

  document
    .getElementById('re-enter-btn')
    .addEventListener('click', function () {
      resetForm(document.formFilterSort);
    });

  // danh muc
  let selectL0 = document.querySelector('select[name="loai0"]');
  let selectL1 = document.querySelector('select[name="loai1"]');
  let selectL2 = document.querySelector('select[name="loai2"]');

  selectL0.innerHTML =
    '<option value="">Loại 0</option>' +
    danhMuc
      .map((l0) => `<option value="${l0.id}">${l0.name}</option>`)
      .join('');

  selectL0.addEventListener('change', function () {
    console.log(this);
    if (this.value !== '') {
      let l1s = danhMuc.find((l0) => l0.id === +this.value).l1;
      selectL1.innerHTML =
        '<option value="">Loại 1</option>' +
        l1s
          .map((l1) => `<option value="${l1.id}">${l1.name}</option>`)
          .join('');
    } else {
      selectL1.innerHTML = '';
    }
    selectL2.innerHTML = '';
  });

  selectL1.addEventListener('change', function () {
    if (this.value !== '') {
      let l1s = danhMuc.find((l0) => l0.id === +selectL0.value).l1 || '';
      let l2s = l1s.find((l1) => l1.id === +this.value).l2 || '';
      selectL2.innerHTML =
        '<option value="">Loại 2</option>' +
        l2s
          .map((l2) => `<option value="${l2.id}">${l2.name}</option>`)
          .join('');
    } else {
      selectL2.innerHTML = '';
    }
  });

  let search = new URLSearchParams(location.search);
  if (search.has('loai0')) {
    // loai 0
    selectL0.querySelector(
      `option[value="${search.get('loai0')}"]`
    ).selected = true;

    // get l1s
    let l1s = danhMuc.find((l0) => l0.id === +selectL0.value).l1;
    selectL1.innerHTML =
      '<option value="">Loại 1</option>' +
      l1s.map((l1) => `<option value="${l1.id}">${l1.name}</option>`).join('');

    // has l1 in search string
    if (search.has('loai1')) {
      selectL1.querySelector(
        `option[value="${search.get('loai1')}"]`
      ).selected = true;

      // get l2s
      let l1s = danhMuc.find((l0) => l0.id === +selectL0.value).l1 || '';
      let l2s = l1s.find((l1) => l1.id === +selectL1.value).l2 || '';
      selectL2.innerHTML =
        '<option value="">Loại 2</option>' +
        l2s
          .map((l2) => `<option value="${l2.id}">${l2.name}</option>`)
          .join('');

      // has l2 in search tring
      if (search.has('loai2')) {
        selectL2.querySelector(
          `option[value="${search.get('loai2')}"]`
        ).selected = true;
      }
    }
  }
}
