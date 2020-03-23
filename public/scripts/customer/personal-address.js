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
}