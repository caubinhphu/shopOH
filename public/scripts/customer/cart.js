// ẩn icon gio hàng
document.getElementById('cart').hidden = true;

// select product
// const selectAllCheckbox = document.getElementsByName('allProduct');
const selectAllCheckbox = document.getElementById('select-all-product'); // checkbox select all product in cart
const selectProduct = document.getElementsByName('product'); // checkbox select product list
const priceProduct = [...document.getElementsByClassName('cart-price-item')]; // text thành tiền mỗi product
const totalPrice = document.getElementById('cart-price'); // text tổng tiền các product được check
const totalProCheck = document.getElementById('cart-total-pro-check'); // text số product được check
const soluongInput = [...document.getElementsByName('soluong')]; // list input số lượng mỗi product
const deleteBtn = [...document.getElementsByClassName('cart-delete-btn')]; // list button xóa product
const selectAllLabel = document.getElementById('select-all-label'); // label check all product

selectAllCheckbox.addEventListener('change', function() {
  selectProduct.forEach(checkbox => {
    checkbox.checked = this.checked;
  });

  if (this.checked) {
    totalPrice.innerHTML = getSumPrice();
    totalProCheck.innerHTML = `Tổng tiền hàng (${getSumProduct()} sản phẩm):`;
  } else {
    totalPrice.innerHTML = '0';
    totalProCheck.innerHTML = 'Tổng tiền hàng (0 sản phẩm):';
  }
});

selectProduct.forEach(checkbox => {
  checkbox.addEventListener('change', function() {
    if (!this.checked) {
      selectAllCheckbox.checked = false;
    } else {
      let checked = document.querySelectorAll('input[name="product"]:checked');
      if (checked.length === selectProduct.length) {
        selectAllCheckbox.checked = true;
      }
    }

    totalProCheck.innerHTML = `Tổng tiền hàng (${getSumProduct()} sản phẩm):`;
    totalPrice.innerHTML = getSumPrice();
  });
});

function getSumProduct() {
  let checked = [...document.querySelectorAll('input[name="product"]:checked')];
  if (checked.length === 0) {
    return 0;
  }
  let dataProduct = checked.map(item => item.dataset.product);
  return soluongInput.reduce((acc, cur) => {
    if (dataProduct.includes(cur.dataset.product)) {
      return acc + +cur.value;
    }
    return acc;
  }, 0);
}

function getSumPrice() {
  let checked = [...document.querySelectorAll('input[name="product"]:checked')];
  if (checked.length === 0) {
    return 0;
  }
  let dataProduct = checked.map(item => item.dataset.product);
  return priceProduct.reduce((acc, cur) => {
    if (dataProduct.includes(cur.dataset.product)) {
      return acc + +cur.innerHTML;
    }
    return acc;
  }, 0);
}

soluongInput.forEach(input => {
  input.addEventListener('input', function() {
    if (+this.value < 1) {
      this.value = 1;
    } else if (+this.value > +this.getAttribute('max')) {
      this.value = this.getAttribute('max');
    }
  });
});

soluongInput.forEach(input => {
  input.addEventListener('change', function() {
    axios
      .put('/cart', {
        info: this.dataset.product,
        sl: +this.value
      })
      .then(res => {
        if (res.status === 200) {
          let priceText = this.parentElement.nextElementSibling
            .lastElementChild;
          let donGia = this.parentElement.previousSibling.lastElementChild
            .lastElementChild;
          priceText.innerHTML = +donGia.innerHTML * +this.value;
          totalPrice.innerHTML = getSumPrice();
          let sumPro = getSumProduct();
          totalProCheck.innerHTML = `Tổng tiền hàng (${sumPro} sản phẩm):`;
          let numAll = soluongInput.reduce((acc, cur) => acc + +cur.value, 0);
          selectAllLabel.innerHTML = `Chọn tất cả (${numAll})`;
        }
      })
      .catch(err => location.reload());
  });
});

deleteBtn.forEach(btn => {
  btn.addEventListener('click', function() {
    axios
      .delete('/cart', { data: { info: this.dataset.product } })
      .then(res => {
        if (res.status === 200) {
          location.reload();
        }
      })
      .catch(err => location.reload());
  });
});

document.getElementById('sell-btn').addEventListener('click', function() {
  let checked = [...document.querySelectorAll('input[name="product"]:checked')];
  if (checked.length === 0) {
    alert('Chưa chọn sản phẩm nào!');
  } else {
    let querySring = new URLSearchParams();
    checked.forEach(check => {
      let qs = check.dataset.checkout;
      // get sl
      qs +=
        '$' +
        check.parentElement.parentElement.children[3].firstElementChild.value;
      querySring.append('item', qs);
    });
    axios
      .get(`/checkout/gettoken?${querySring.toString()}`)
      .then(res => {
        if (res.status === 200) {
          location.href = `/checkout?token=${res.data.token}`;
        }
      })
      .catch(err => {
        location.reload();
      });
  }
});
