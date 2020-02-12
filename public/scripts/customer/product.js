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

const minusBtn = document.getElementById('minus-amount-btn');
const plusBtn = document.getElementById('plus-amount-btn');

const arr = [48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105];
