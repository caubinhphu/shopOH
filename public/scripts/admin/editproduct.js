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
  // danh muc
  let selectL0 = document.querySelector('select[name="loai0"]');
  let selectL1 = document.querySelector('select[name="loai1"]');
  let selectL2 = document.querySelector('select[name="loai2"]');

  selectL0.innerHTML =
    '<option value="">Loại 0</option>' +
    danhMuc
      .map(
        (l0) =>
          `<option value="${l0.id}" ${
            l0.id === +selectL0.dataset.value ? 'selected' : ''
          }>${l0.name}</option>`
      )
      .join('');

  let l1s = danhMuc.find((l0) => l0.id === +selectL0.dataset.value).l1;
  selectL1.innerHTML =
    '<option value="">Loại 1</option>' +
    l1s
      .map(
        (l1) =>
          `<option value="${l1.id}" ${
            l1.id === +selectL1.dataset.value ? 'selected' : ''
          }>${l1.name}</option>`
      )
      .join('');

  let l2s = l1s.find((l1) => l1.id === +selectL1.dataset.value).l2 || '';
  selectL2.innerHTML =
    '<option value="">Loại 2</option>' +
    l2s
      .map(
        (l2) =>
          `<option value="${l2.id}" ${
            l2.id === +selectL2.dataset.value ? 'selected' : ''
          }>${l2.name}</option>`
      )
      .join('');

  selectL0.addEventListener('change', function () {
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

  const typePro = document.getElementById('type-pro');
  document
    .querySelector('#add-typepro-btn')
    .addEventListener('click', function () {
      let typeDiv = document.createElement('div');
      typeDiv.className = 'd-flex mb-2';
      typeDiv.innerHTML = `<input class="form-control form-control-sm col ml-2" type="text" name="color" placeholder="Màu" required="required" />
    <input class="form-control form-control-sm col ml-2" type="text" name="size" placeholder="Size" required="required" />
    <input class="form-control form-control-sm col ml-2" type="number" name="amount" placeholder="Số lượng nhập" required="required" />`;
      let btnDel = document.createElement('button');
      btnDel.className = 'btn btn-primary-v2 ml-2 btn-sm';
      btnDel.innerHTML = 'X';
      btnDel.addEventListener('click', function () {
        this.parentElement.remove();
        afterRemoveOrAddTypePro(typePro);
      });
      typeDiv.appendChild(btnDel);
      typePro.appendChild(typeDiv);
      afterRemoveOrAddTypePro(typePro);
    });
  typePro.querySelectorAll('button').forEach((btn) => {
    btn.addEventListener('click', function () {
      this.parentElement.remove();
      afterRemoveOrAddTypePro(typePro);
    });
  });
}

function submitForm(status) {
  let form = document.editProForm;
  if (!form.checkValidity()) {
    alert('Validate form false kìa cu');
  } else {
    let inputStatus = document.createElement('input');
    inputStatus.setAttribute('type', 'hidden');
    inputStatus.name = 'status';
    inputStatus.value = status;

    form.appendChild(inputStatus);
    form.submit();
  }
}

document
  .getElementById('save-and-hide-btn')
  .addEventListener('click', function () {
    submitForm('2');
  });
document
  .getElementById('save-and-show-btn')
  .addEventListener('click', function () {
    submitForm('1');
  });

function afterRemoveOrAddTypePro(typePro) {
  if (typePro.childElementCount <= 1) {
    typePro.querySelector('button').hidden = true;
  } else {
    typePro.querySelectorAll('button').forEach((btn) => (btn.hidden = false));
  }
}
