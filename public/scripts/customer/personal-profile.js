const profileForm = document.profileForm; // form edit profile
const modalCropImg = document.querySelector('#modal-crop-avatar'); // modal crop avatar
const modalProgress = document.querySelector('#modal-progress'); // modal progress
const chooseImgBtn = document.querySelector('#choose-img'); // choose avatar button
const inputAvatar = document.querySelector('#input-avatar'); // input file avatar
const imgCrop = document.querySelector('#crop-img'); // area crop avatar
const cropBtn = document.querySelector('#crop-btn'); // crop and save button avatar

// is change form edit profile
let isChangeForm = false;

// init croppie avatar
const croppie = new Croppie(imgCrop, {
  enableExif: true,
  viewport: {
    width: 100,
    height: 100,
    type: 'circle'
  },
  boundary: {
    width: 300,
    height: 300
  }
});

// hide modal crop avatar and modal progress
modalCropImg.style.display = 'none';
modalProgress.style.display = 'none';

// add event
profileForm.addEventListener('change', () => (isChangeForm = true));

chooseImgBtn.addEventListener('click', function() {
  inputAvatar.click();
});

profileForm.addEventListener('submit', e => {
  e.preventDefault();
  if (isChangeForm) {
    inputAvatar.setAttribute('disabled', true);
    profileForm.submit();
  }
});

inputAvatar.addEventListener('change', function() {
  const extTypes = /jpeg|jpg|png|gif/;

  let extFile = this.files[0].name
    .split('.')
    .pop()
    .toLowerCase();
  // check extname
  const extname = extTypes.test(extFile);

  // check type file
  const type = extTypes.test(this.files[0].type);

  if (extname && type) {
    // show modal crop avatar
    modalCropImg.style.display = 'block';

    // create reader read file from input file avatar
    let reader = new FileReader();
    reader.onload = async function(e) {
      await croppie.bind({
        url: e.target.result
      });
    };
    reader.readAsDataURL(this.files[0]);
  } else {
    afterCropAvatar({ mgs: 'File ảnh không đúng định dạng' });
  }
});

cropBtn.addEventListener('click', async function() {
  let dataCrop = await croppie.result({
    type: 'base64',
    size: 'viewport'
  });

  let blob = dataURLtoFile(dataCrop, 'avatar.png');
  let formData = new FormData();
  formData.append('avatar', blob);

  var xhr = new XMLHttpRequest();
  xhr.open('put', 'http://localhost:3000/account/profile/avatar', true);

  xhr.onreadystatechange = function() {
    if (this.readyState === 3) {
      console.log('progress');
      // progress
      progess();
    } else if (this.readyState === 4) {
      console.log('finish');
      modalProgress.style.display = 'none';
      // finish
      // check status
      if (this.status === 200) {
        // OK
        afterCropAvatar(null, JSON.parse(this.responseText));
      } else if (this.status >= 400) {
        // error
        afterCropAvatar(JSON.parse(this.responseText));
      }
    }
  };

  xhr.send(formData);
});

function progess() {
  // hide modal crop image
  modalCropImg.style.display = 'none';

  modalProgress.style.display = 'block';
}

// handle after crop and save avatar
function afterCropAvatar(error, response) {
  // check error upload avatar
  if (error) {
    // has error
    // create error alert message
    createAleartMgs(true, error.mgs);
  } else {
    // no error
    // create success alert message
    createAleartMgs(false, response.mgs);

    // chang avatar
    changAvatar(response.src);
  }
}

// create alert message
function createAleartMgs(err, mgs) {
  let typeAlert = 'alert-success';
  if (err) {
    typeAlert = 'alert-danger';
  }
  let alertHtml = `<div class="alert ${typeAlert} alert-dismissible fade show mx-auto" role="alert">
      <span>${mgs}</span>
      <button class="close" type="button" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
    </div>`;

  document.querySelector('#message').innerHTML = alertHtml;
}

// chang avatar
function changAvatar(src) {
  document.querySelector('#img-avatar-right').src = src;
  document.querySelector('#img-avatar-left').src = src;
  document.querySelector('#img-avatar-mini').src = src;
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
