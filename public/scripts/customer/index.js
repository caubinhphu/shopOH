function addSlick() {
  $('.slider').slick({
    dots: true,
    rows: 0,
    adaptiveHeight: true,
    autoplay: true,
    autoplaySpeed: 5000,
    prevArrow: '<button type="button" class="slick-prev arrows"><i class="fas fa-chevron-left"></i></span></button>',
    nextArrow: '<button type="button" class="slick-next arrows"><i class="fas fa-chevron-right"></i></span></button>',
  })
}

addSlick()