const hcvn = {};

if (!sessionStorage.getItem('hcvn')) {
  console.log('get hcvn');
  axios
    .get('http://localhost:3000/account/address/hcvn')
    .then(res => {
      if (res.status === 200) {
        sessionStorage.setItem('hcvn', JSON.stringify(res.data));
      } else {
        location.href = 'http://localhost:3000/login';
      }
    })
    .then(() => {
      hcvn.data = JSON.parse(sessionStorage.getItem('hcvn')).data;
      afterLoadHCVN();
    });
} else {
  hcvn.data = JSON.parse(sessionStorage.getItem('hcvn')).data;
  afterLoadHCVN();
}

function afterLoadHCVN() {
  const tinhSelect = document.getElementById('address-tinh');
  const huyenSelect = document.getElementById('address-huyen');
  const xaSelect = document.getElementById('address-xa');
  const formAddress = document.addressForm;
  const defaultBtns = document.querySelectorAll('.default-btn');
  const defaultBadge = [
    ...document.querySelectorAll('.personal-address-default')
  ];
  const delBtn = document.querySelectorAll('.del-addr-btn');
  const OKbtn = document.querySelector('#OK-del-addr-btn');
  const editBtn = document.querySelectorAll('.edit-addr-btn');
  const editOK = document.querySelector('#edit-addr-btn');

  tinhSelect.innerHTML =
    '<option selected="" value="">Tỉnh/Thành Phố</option>' +
    hcvn.data
      .map(tinh => `<option value="${tinh.name}">${tinh.name}</option>`)
      .join('');

  tinhSelect.addEventListener('change', () => {
    if (tinhSelect.value !== '') {
      let huyenData = hcvn.data.find(tinh => tinh.name === tinhSelect.value).c2;
      huyenSelect.innerHTML =
        '<option selected="" value="">Quận/Huyện</option>' +
        huyenData
          .map(huyen => `<option value="${huyen.name}">${huyen.name}</option>`)
          .join('');
    } else {
      huyenSelect.innerHTML = '';
    }

    xaSelect.innerHTML = '';
  });

  huyenSelect.addEventListener('change', () => {
    if (huyenSelect.value !== '') {
      let huyenData =
        hcvn.data.find(tinh => tinh.name === tinhSelect.value).c2 || '';
      let xaData =
        huyenData.find(huyen => huyen.name === huyenSelect.value).c3 || '';
      xaSelect.innerHTML =
        '<option selected="" value="">Xã/Phường</option>' +
        xaData
          .map(xa => `<option value="${xa.name}">${xa.name}</option>`)
          .join('');
    } else {
      xaSelect.innerHTML = '';
    }
  });

  // event change default address
  defaultBtns.forEach(btn => {
    btn.addEventListener('click', function() {
      // put to server
      axios
        .put('http://localhost:3000/account/address/default', {
          data: this.dataset.address
        })
        .then(res => {
          // check status res
          if (res.status === 200) {
            // allow all btn press
            defaultBtns.forEach(b => {
              b.removeAttribute('disabled');
              b.classList.remove('not-allowed');
            });

            // disabled this btn
            this.setAttribute('disabled', 'disabled');
            this.classList.add('not-allowed');

            // change default badge
            defaultBadge.forEach(badge => {
              if (badge.dataset.address === this.dataset.address) {
                badge.style.display = 'block';
              } else {
                badge.style.display = 'none';
              }
            });
          }
        })
        .catch(err => {
          let alertHtml = `<div class="alert alert-danger alert-dismissible fade show mx-auto" role="alert">
                              <span>Thiết lập địa chỉ mặc định thất bại</span>
                              <button class="close" type="button" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                              </button>
                            </div>`;
          document.querySelector('#message').innerHTML = alertHtml;
        });
    });
  });

  // delele address
  delBtn.forEach(btn => {
    btn.addEventListener('click', function() {
      OKbtn.dataset.address = this.dataset.address;
    });
  });

  // OK delete
  OKbtn.addEventListener('click', function() {
    if (delBtn.length <= 1) {
      // delete
      deleteAddress(this.dataset.address);
    } else {
      let defBadgeCurrent = defaultBadge.find(badge => {
        return badge.style.display === 'block';
      });
      if (this.dataset.address === defBadgeCurrent.dataset.address) {
        // show modal warning
        $('#delete-address').modal('hide');
        $('#warning-address').modal('show');
      } else {
        // delete
        deleteAddress(this.dataset.address);
      }
    }
  });

  // edit address
  editBtn.forEach(btn => {
    btn.addEventListener('click', function() {
      // get data address decode
      axios
        .get(
          `http://localhost:3000/account/address/decode?encode=${this.dataset.address}`
        )
        .then(res => {
          // get address decode to server
          let { addr } = res.data;

          // change value in from address
          formAddress.name.value = addr.ten;
          formAddress.phone.value = addr.dienthoai;
          formAddress.tinh.value = addr.tinh;

          let huyenData = hcvn.data.find(tinh => tinh.name === tinhSelect.value)
            .c2;
          huyenSelect.innerHTML =
            '<option selected="" value="">Quận/Huyện</option>' +
            huyenData
              .map(
                huyen => `<option value="${huyen.name}">${huyen.name}</option>`
              )
              .join('');
          formAddress.huyen.value = addr.huyen;
          let xaData =
            huyenData.find(huyen => huyen.name === huyenSelect.value).c3 || '';
          xaSelect.innerHTML =
            '<option selected="" value="">Xã/Phường</option>' +
            xaData
              .map(xa => `<option value="${xa.name}">${xa.name}</option>`)
              .join('');

          formAddress.xa.value = addr.xa;
          formAddress.homenum.value = addr.nha;

          if (!('_method' in formAddress)) {
            let putMethod = document.createElement('input');
            putMethod.type = 'hidden';
            putMethod.name = '_method';
            putMethod.value = 'PUT';
            formAddress.appendChild(putMethod);

            let addrIdInput = document.createElement('input');
            addrIdInput.type = 'hidden';
            addrIdInput.name = 'addrId';
            addrIdInput.value = addr.ma_diachi;

            formAddress.appendChild(addrIdInput);
          }
        })
        .catch(err => {
          location.reload();
        });
    });
  });

  document.querySelector('#add-new-addr').addEventListener('click', function() {
    if ('_method' in formAddress) {
      formAddress.name.value = '';
      formAddress.phone.value = '';
      formAddress.tinh.value = '';
      formAddress.huyen.value = '';
      formAddress.xa.value = '';
      formAddress.homenum.value = '';
      huyenSelect.innerHTML = '';
      xaSelect.innerHTML = '';
      formAddress._method.remove();
      formAddress.addrId.remove();
    }
    $('#add-address').modal('show');
  });
}

function deleteAddress(data) {
  axios
    .delete('http://localhost:3000/account/address', { data: { data } })
    .then(res => {
      if (res.status === 200) {
        location.href = 'http://localhost:3000/account/address';
      }
    })
    .catch(err => {
      $('#delete-address').modal('hide');
      document.querySelector('#message').innerHTML = createMessage(
        'alert-danger',
        'Xóa địa chỉ thất bại'
      );
    });
}

function createMessage(type, mgs) {
  return `<div class="alert ${type} alert-dismissible fade show mx-auto" role="alert">
            <span>${mgs}</span>
            <button class="close" type="button" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>`;
}
