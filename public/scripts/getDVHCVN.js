const url = 'http://localhost:3001/data';

let data = [];

axios.get(url)
     .then(res => data = res.data)
     .then(() => {
       const tinhSelect = document.getElementById('address-tinh');
       const huyenSelect = document.getElementById('address-huyen');
       const xaSelect = document.getElementById('address-xa');
      
       tinhSelect.innerHTML = '<option selected="" value="">Tỉnh/Thành Phố</option>'
                            + data.map(tinh => `<option value="${tinh['name']}">${tinh['name']}</option>`).join('');

       tinhSelect.addEventListener('change', () => {
        if (tinhSelect.value !== '') {
          let huyenData = data.find(tinh => tinh['name'] === tinhSelect.value)['level2s'];
          huyenSelect.innerHTML = '<option selected="" value="">Quận/Huyện</option>'
                                + huyenData.map(huyen => `<option value="${huyen['name']}">${huyen['name']}</option>`).join('');
        } else {
          huyenSelect.innerHTML = '';
        }

        xaSelect.innerHTML = '';
      });

       huyenSelect.addEventListener('change', () => {
        if (huyenSelect.value !== '') {
          let huyenData = data.find(tinh => tinh['name'] === tinhSelect.value)['level2s'] || '';
          let xaData = huyenData.find(huyen => huyen['name'] === huyenSelect.value)['level3s'] || '';
          xaSelect.innerHTML = '<option selected="" value="">Xã/Phường</option>'
                             + xaData.map(xa => `<option value="${xa['name']}">${xa['name']}</option>`).join('');
        } else {
          xaSelect.innerHTML = '';
        }
       });

     });