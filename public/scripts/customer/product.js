const colorRadio = document.getElementsByName('color');
const sizeRadio = document.getElementsByName('size');
const textSoLuongTon = document.getElementById('text-sanphamton');
const inputTextAmount = document.getElementById('input-amount');

colorRadio.forEach(color => {
  color.addEventListener('focus', () => {
    sizeRadio.forEach(size => {
      if (size.checked) {
        // console.log(`color: ${color.value}, size: ${size.value}`);
        axios.get(`${location.href}/${color.value}/${size.value}`).then(res => {
          // console.log(res.data);
          textSoLuongTon.innerHTML = res.data.soluongton + ' sản phẩm có sẵn';
          inputTextAmount.setAttribute('max', res.data.soluongton);
          inputTextAmount.value = 1;
        })
        return false;
      }
    })
  });
});

sizeRadio.forEach(size => {
  size.addEventListener('focus', () => {
    colorRadio.forEach(color => {
      if (color.checked) {
        // console.log(`color: ${color.value}, size: ${size.value}`);
        axios.get(`${location.href}/${color.value}/${size.value}`).then(res => {
          // console.log(res.data);
          textSoLuongTon.innerHTML = res.data.soluongton + ' sản phẩm có sẵn';
          inputTextAmount.setAttribute('max', res.data.soluongton);
          inputTextAmount.value = 1;
        })
        return false;
      }
    })
  });
});


const likeButton = document.getElementById('product-like');
const likeIcon = document.getElementById('product-like-icon');
const textLike = document.getElementById('product-like-text');

likeButton.addEventListener('click', () => {
  if (likeIcon.classList.item(2) === 'far') { // chưa like -> like
    // cập nhật csdl = thêm like
    axios.post(`${location.href}/like`)
          .then(res => {
            // đổi icon
            likeIcon.classList.replace('far', 'fas');
            textLike.innerHTML = ` Đã thích (${res.data.like})`;
          });
  } else if (likeIcon.classList.item(2) === 'fas') { // đã like -> bỏ like
    // cập nhật csdl = xóa like
    axios.delete(`${location.href}/like`)
          .then(res => {
            // đổi icon
            likeIcon.classList.replace('fas', 'far');
            textLike.innerHTML = ` Đã thích (${res.data.like})`;
          });
  }
});

inputTextAmount.addEventListener('input', function() {
  if (parseInt(this.value) > parseInt(this.getAttribute('max'))) {
    this.value = this.getAttribute('max');
  } else if (parseInt(this.value) < parseInt(this.getAttribute('min'))) {
    this.value = this.getAttribute('min');
  } 
});

const imgProduct = document.getElementsByClassName('img-product')[0];
const imgSubProduct = document.getElementsByClassName('img__sub');

for (let i = 0; i < imgSubProduct.length; i++) {
  imgSubProduct[i].addEventListener('mouseover', function() {
    imgProduct.style.backgroundImage = this.style.backgroundImage
  });
}

const addToCartBtn = document.getElementById('add-to-cart-btn');
const textErrorCart = document.getElementById('error-cart');
const selectionStyleProduct = document.getElementById('selection-style-product');

addToCartBtn.addEventListener('click', function() {
  // check form
  let colorInput = document.querySelectorAll('input[name="color"]:checked');
  let sizeInput = document.querySelectorAll('input[name="size"]:checked');
  let quantityInput = document.getElementsByName('soluong')[0];
  let idProductInput = document.getElementsByName('idPro')[0];

  if (colorInput.length < 1
      || sizeInput.length < 1
      || parseInt(quantityInput.value) < 1
      || parseInt(quantityInput.value) > parseInt(quantityInput.getAttribute('max'))) {
    textErrorCart.innerHTML = 'Vui lòng chọn phân loại sản phẩm';
    selectionStyleProduct.style.backgroundColor = '#fff5f5';
  } else {
    textErrorCart.innerHTML = '';
    selectionStyleProduct.style.backgroundColor = 'white';
    
    axios.post('/cart/add', {
      idPro: idProductInput.value,
      color: colorInput[0].value,
      size: sizeInput[0].value,
      quantity: quantityInput.value
    }).then(res => {
      let dataRes = res.data;
      let textHtml = `<div class="popover__content__cart d-none d-md-inline">
                        <p class="popover__message">Sản phẩm mới thêm</p>
                        <div class="popover__content__main" id="product_cart_list">`;
      textHtml += dataRes[1].map((product, index) => {
        if (index < 5) {
          return `<div class="product_content p-2 d-flex" data-target="/product/${product.ma_sanpham}">
                  <div class="popover__content__image">
                    <div class="popover__content__img" style="background-image: url('${product.hinhanh.split(',')[0]}');"></div>
                  </div>
                <div class="popover__content__main__cart flex-fill ml-1 d-flex">
                  <div class="popover__content__main__cart__content__left">
                    <div class="popover__content__cart__title">
                      <small>${product.ten_sanpham}</small>
                    </div>
                    <div class="popover__content__cart__content">
                      <small>Loại: màu ${product.mausac}, size: ${product.size}</small>
                    </div>
                  </div>
                  <div class="popover__content__main__cart__content__right">
                    <div class="popover__content__cart__price text-right">
                      <span class="text-danger">
                        ₫${Math.round(product.giaban * (1 - product.khuyenmai / 100)).toLocaleString('de-DE')}
                      </span>`
                      + 
                        (product.soluong !== 1 ? `<small>&nbsp;x&nbsp;</small><span>${product.soluong}</span>` : '')
                      +
                    `</div>
                    <div class="popover__content__cart__delete text-right">
                      <button class="btn btn-link delete-product-cart-btn" type="button"
                              data-product="${product.ma_sanpham}$${product.ma_khachhang}$${product.mausac}$${product.size}">
                        Xóa
                      </button>
                    </div>
                  </div>
                </div>
              </div>`;
        } else {
          return '';
        }
      }).join('');
      textHtml += `</div>
                <div class="text-right p-2 d-flex justify-content-between align-items-center">
                  <small>${dataRes[0][0].sl} loại sản phẩm trong giỏ</small>
                  <a class="btn btn-danger" href="#">Xem giỏ hàng</a>
                </div>
              </div>`;
      mainCart.innerHTML = textHtml;

      // add  event
      deleteProductCartBtn = document.getElementsByClassName('delete-product-cart-btn');
      addEventDeleteCartBtn();
      cartBadge.innerHTML = dataRes[0][0].slsp;
      $("#alert-add-cart-success").fadeIn(1000).fadeOut(1000);
    });
  }
});

$("#alert-add-cart-success").hide();