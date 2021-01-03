let danhMuc = [];
let imgPro = {
  image1: null,
  image2: null,
  image3: null,
  image4: null,
  image5: null
};

if (!sessionStorage.getItem('danhmuc')) {
  axios
    .get('http://localhost:3000/admin/danhmuc')
    .then(res => {
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
    .catch(err => (location.href = 'http://localhost:3000/adminAuth'));
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
    danhMuc.map(l0 => `<option value="${l0.id}">${l0.name}</option>`).join('');

  selectL0.addEventListener('change', function() {
    if (this.value !== '') {
      let l1s = danhMuc.find(l0 => l0.id === +this.value).l1;
      selectL1.innerHTML =
        '<option value="">Loại 1</option>' +
        l1s.map(l1 => `<option value="${l1.id}">${l1.name}</option>`).join('');
    } else {
      selectL1.innerHTML = '';
    }
    selectL2.innerHTML = '';
  });

  selectL1.addEventListener('change', function() {
    if (this.value !== '') {
      let l1s = danhMuc.find(l0 => l0.id === +selectL0.value).l1 || '';
      let l2s = l1s.find(l1 => l1.id === +this.value).l2 || '';
      selectL2.innerHTML =
        '<option value="">Loại 2</option>' +
        l2s.map(l2 => `<option value="${l2.id}">${l2.name}</option>`).join('');
    } else {
      selectL2.innerHTML = '';
    }
  });

  const typePro = document.getElementById('type-pro');
  document
    .querySelector('#add-typepro-btn')
    .addEventListener('click', function() {
      let typeDiv = document.createElement('div');
      typeDiv.className = 'd-flex mb-2';
      typeDiv.innerHTML = `<input class="form-control form-control-sm col ml-2" type="text" name="color" placeholder="Màu" required="required" />
    <input class="form-control form-control-sm col ml-2" type="text" name="size" placeholder="Size" required="required" />
    <input class="form-control form-control-sm col ml-2" type="number" name="amount" placeholder="Số lượng nhập" required="required" />`;
      let btnDel = document.createElement('button');
      btnDel.className = 'btn btn-primary-v2 ml-2 btn-sm';
      btnDel.innerHTML = 'X';
      btnDel.addEventListener('click', function() {
        this.parentElement.remove();
      });
      typeDiv.appendChild(btnDel);
      typePro.appendChild(typeDiv);
    });

  // crop images
  const modalCropImg = document.querySelector('#modal-crop-img'); // modal crop img
  const inputImgs = document.querySelectorAll('input[name="image"]');
  const imgCrop = document.querySelector('#crop-img'); // area crop
  const cropBtn = document.querySelector('#crop-btn');

  modalCropImg.style.display = 'none';
  // init croppie image
  const croppie = new Croppie(imgCrop, {
    enableExif: true,
    viewport: {
      width: 420,
      height: 420
    },
    boundary: {
      width: 580,
      height: 580
    }
  });

  inputImgs.forEach(input => {
    input.addEventListener('change', function() {
      // show modal crop image
      modalCropImg.style.display = 'block';
      cropBtn.dataset.targetId = this.id;
      let reader = new FileReader();
      reader.onload = async function(e) {
        await croppie.bind({
          url: e.target.result
        });
      };
      reader.readAsDataURL(this.files[0]);
    });
  });

  cropBtn.addEventListener('click', async function(e) {
    let dataCrop = await croppie.result({
      type: 'base64',
      size: 'viewport'
    });
    let inputTarget = document.getElementById(`${this.dataset.targetId}`);
    let previewImg = inputTarget.parentElement.firstElementChild;
    previewImg.style.backgroundImage = `url('${dataCrop}')`;
    let blob = dataURLtoFile(dataCrop, 'image.png');

    imgPro[this.dataset.targetId] = blob;

    // hide modal crop image
    modalCropImg.style.display = 'none';
  });
}

// create file from data base64
function dataURLtoFile(dataurl, filename) {
  let arr = dataurl.split(','),
    mime = arr[0].match(/:(.*?);/)[1],
    bstr = atob(arr[1]),
    n = bstr.length,
    u8arr = new Uint8Array(n);

  while (n--) {
    u8arr[n] = bstr.charCodeAt(n);
  }
  return new File([u8arr], filename, { type: mime });
}

function submitForm(status) {
  if (!document.addProForm.checkValidity()) {
    alert('Validate form false kìa cu');
  } else {
    let form = new FormData(document.addProForm);
    form.delete('image');
    form.append('image', imgPro.image1);
    form.append('image', imgPro.image2);
    form.append('image', imgPro.image3);
    form.append('image', imgPro.image4);
    form.append('image', imgPro.image5);
    form.append('status', status);

    let xhr = new XMLHttpRequest();
    xhr.open('POST', 'http://localhost:3000/admin/product/add', true);
    xhr.onload = function() {
      if (xhr.status === 200) {
        alert('Thêm sản phẩm mới thành công');
        location.href = 'http://localhost:3000/admin/product';
      } else {
        alert('Thêm sản phẩm mới thất bại');
        location.reload();
      }
    };
    xhr.send(form);
  }
}

document
  .getElementById('save-and-hide-btn')
  .addEventListener('click', function() {
    submitForm('2');
  });
document
  .getElementById('save-and-show-btn')
  .addEventListener('click', function() {
    submitForm('1');
  });
