const colorRadio = document.getElementsByName('color');
const sizeRadio = document.getElementsByName('size');
const textSoLuongTon = document.getElementById('text-sanphamton');
const inputTextAmount = document.getElementById('input-amount');

function getAmountProduct() {
  let colorChecked = document.querySelector('input[name="color"]:checked');
  let sizeChecked = document.querySelector('input[name="size"]:checked');

  if (colorChecked && sizeChecked) {
    let queryString = new URLSearchParams(new FormData(document.classifyForm));
    let url = `${location.origin}/product/amount?${queryString}`;
    axios.get(url).then(res => {
      textSoLuongTon.innerHTML = res.data.soluongton + ' sản phẩm có sẵn';
      inputTextAmount.setAttribute('max', res.data.soluongton);
      inputTextAmount.value = 1;
    });
  }
}

colorRadio.forEach(color => {
  color.addEventListener('change', () => {
    getAmountProduct();
  });
});

sizeRadio.forEach(size => {
  size.addEventListener('change', () => {
    getAmountProduct();
  });
});

const likeButton = document.getElementById('product-like');
const likeIcon = document.getElementById('product-like-icon');
const textLike = document.getElementById('product-like-text');

likeButton.addEventListener('click', () => {
  axios.post(`${location.href}/like`).then(res => {
    if (/application\/json/.test(res.headers['content-type'])) {
      // đổi icon
      if (likeIcon.classList.contains('far')) {
        likeIcon.classList.replace('far', 'fas');
      } else if (likeIcon.classList.contains('fas')) {
        likeIcon.classList.replace('fas', 'far');
      }

      textLike.innerHTML = ` Đã thích (${res.data.like})`;
    } else if (/text\/html/.test(res.headers['content-type'])) {
      location.href = 'http://localhost:3000/login';
    }
  });
});

inputTextAmount.addEventListener('input', function() {
  if (+this.value > +this.getAttribute('max')) {
    this.value = this.getAttribute('max');
  } else if (+this.value < +this.getAttribute('min')) {
    this.value = this.getAttribute('min');
  }
});

const imgProduct = document.getElementsByClassName('img-product')[0];
const imgSubProduct = document.getElementsByClassName('img__sub');

for (let i = 0; i < imgSubProduct.length; i++) {
  imgSubProduct[i].addEventListener('mouseover', function() {
    imgProduct.style.backgroundImage = this.style.backgroundImage;
  });
}

const addToCartBtn = document.getElementById('add-to-cart-btn');
const textErrorCart = document.getElementById('error-cart');
const areaSelect = document.getElementById('selection-style-product');

addToCartBtn.addEventListener('click', function() {
  // check form
  let colorInput = document.querySelectorAll('input[name="color"]:checked');
  let sizeInput = document.querySelectorAll('input[name="size"]:checked');
  let quantityInput = document.getElementsByName('soluong')[0];
  let idProductInput = document.getElementsByName('idPro')[0];

  if (
    colorInput.length < 1 ||
    sizeInput.length < 1 ||
    +quantityInput.value < 1 ||
    +quantityInput.value > +quantityInput.getAttribute('max')
  ) {
    textErrorCart.innerHTML = 'Vui lòng chọn phân loại sản phẩm';
    areaSelect.style.backgroundColor = '#fff5f5';
  } else {
    textErrorCart.innerHTML = '';
    areaSelect.style.backgroundColor = 'white';

    axios
      .post('/cart', {
        idPro: idProductInput.value,
        color: colorInput[0].value,
        size: sizeInput[0].value,
        quantity: quantityInput.value
      })
      .then(res => {
        if (/application\/json/.test(res.headers['content-type'])) {
          renderMiniCart(res.data);
          $('#alert-add-cart-success')
            .fadeIn(1000)
            .fadeOut(1000);
        } else if (/text\/html/.test(res.headers['content-type'])) {
          location.href = 'http://localhost:3000/login';
        }
      });
  }
});

$('#alert-add-cart-success').hide();
