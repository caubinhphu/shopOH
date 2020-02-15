let deleteCartBtn = document.getElementsByClassName('delete-product-cart-btn');
const cartBadge = document.getElementById('numProductIncart');
const mainCart = document.getElementById('main-cart');

function addEventDeleteCartBtn() {
  for (let i = 0; i < deleteCartBtn.length; i++) {
    deleteCartBtn[i].addEventListener('click', handleDeleteCart);
  }
}

function handleDeleteCart() {
  axios.delete(`/cart/${this.dataset.product}`)
    .then(res => {
      let dataRes = res.data;
      if (dataRes[0][0].slsp >= 1) {
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
        console.log(textHtml);
        mainCart.innerHTML = textHtml;

        // add  event
        deleteProductCartBtn = document.getElementsByClassName('delete-product-cart-btn');
        addEventDeleteCartBtn();
      } else {
        mainCart.innerHTML = '<div class="popover__content__cart text-center py-5 d-none d-md-inline">\
                                <img class="w-25 d-block mx-auto" src="/images/nocart.png") />\
                                <span> Chưa có sản phẩm </span>'
      }
      cartBadge.innerHTML = dataRes[0][0].slsp;
    });
}

addEventDeleteCartBtn();

const productList = document.getElementsByClassName('product_content');
for (let i = 0; i < productList.length; i++) {
  productList[i].addEventListener('click', function(event) {
    if (event.target.localName !== 'button') {
      let url = event.currentTarget.dataset.target;
      location.href = url;
    }
  });
}