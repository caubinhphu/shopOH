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
				});
				return false;
			}
		});
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
				});
				return false;
			}
		});
	});
});

const likeButton = document.getElementById('product-like');
const likeIcon = document.getElementById('product-like-icon');
const textLike = document.getElementById('product-like-text');

likeButton.addEventListener('click', () => {
	if (likeIcon.classList.item(2) === 'far') {
		// chưa like -> like
		// requset post add like int csdl
		axios.post(`${location.href}/like`).then(res => {
			// đổi icon
			likeIcon.classList.replace('far', 'fas');
			textLike.innerHTML = ` Đã thích (${res.data.like})`;
		});
	} else if (likeIcon.classList.item(2) === 'fas') {
		// đã like -> bỏ like
		// request remove like in csdl
		axios.delete(`${location.href}/like`).then(res => {
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
		imgProduct.style.backgroundImage = this.style.backgroundImage;
	});
}

const addToCartBtn = document.getElementById('add-to-cart-btn');
const textErrorCart = document.getElementById('error-cart');
const selectionStyleProduct = document.getElementById(
	'selection-style-product'
);

addToCartBtn.addEventListener('click', function() {
	// check form
	let colorInput = document.querySelectorAll('input[name="color"]:checked');
	let sizeInput = document.querySelectorAll('input[name="size"]:checked');
	let quantityInput = document.getElementsByName('soluong')[0];
	let idProductInput = document.getElementsByName('idPro')[0];

	if (
		colorInput.length < 1 ||
		sizeInput.length < 1 ||
		parseInt(quantityInput.value) < 1 ||
		parseInt(quantityInput.value) > parseInt(quantityInput.getAttribute('max'))
	) {
		textErrorCart.innerHTML = 'Vui lòng chọn phân loại sản phẩm';
		selectionStyleProduct.style.backgroundColor = '#fff5f5';
	} else {
		textErrorCart.innerHTML = '';
		selectionStyleProduct.style.backgroundColor = 'white';

		axios
			.post('/cart', {
				idPro: idProductInput.value,
				color: colorInput[0].value,
				size: sizeInput[0].value,
				quantity: quantityInput.value
			})
			.then(res => {
				sessionStorage.setItem('cartInfo', JSON.stringify(res.data));
				renderMiniCart();
				$('#alert-add-cart-success')
					.fadeIn(1000)
					.fadeOut(1000);
			});
	}
});

$('#alert-add-cart-success').hide();
