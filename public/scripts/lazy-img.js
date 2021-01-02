lazyLoadImage();
$(window).on('resize orientationchange', () => {
  lazyLoadImage();
});

function lazyLoadImage() {
  if ($('.lazy:visible').length) {
    hasSlider()
    lazyloadimageCustom()
    $(window).on('scroll', () => {
      lazyloadimageCustom()
    })
  }
}

function hasSlider(element) {
  const sliderLazy = $(element).parents('.slider-lazy')
  const prevActive = sliderLazy.find('.slick-current').prev().find('.lazy')
  const nextActive = sliderLazy.find('.slick-current').next().find('.lazy')
  const srcprev = prevActive.attr('data-src')
  const srcnext = nextActive.attr('data-src')
  if (prevActive.length) {
    if (prevActive[0].nodeName === 'IMG') {
      prevActive.attr('src', srcprev)
    } else {
      prevActive.css({ 'background-image': `url('${srcprev}')` })
    }
  }
  if (nextActive.length) {
    if (nextActive[0].nodeName === 'IMG') {
      nextActive.attr('src', srcnext)
    } else {
      nextActive.css({ 'background-image': `url('${srcnext}')` })
    }
  }
  prevActive.removeClass('lazy').addClass('b-loaded')
  nextActive.removeClass('lazy').addClass('b-loaded')
}

function lazyloadimageCustom() {
  $('.lazy:visible').each((index, element) => {
    const elementScroll = $(element).offset().top - window.innerHeight
    const scrollBody = $(window).scrollTop()
    // console.log(element, elementScroll, scrollBody)
    if (elementScroll < scrollBody) {
      // console.log(element, $(element).offset().width)
      const elementTmp = element.tagName
      lazyCallback(elementTmp, element)
      if ($(element).parents('.fix-height').length) {
        $(element).on('load', () => {
          setTimeout(() => {
            window.callFixHeight()
          }, 200)
        })
      }
      if ($(element).parents('.slider-lazy').hasClass('slick-initialized')) {
        hasSlider(element)
      }
    }
  })
}

function lazyCallback(elementTmp, element) {
  const datasrc = element.getAttribute('data-src')
  if (elementTmp === 'IMG') {
    element.setAttribute('src', datasrc)
  } else {
    $(element).css({ 'background-image': `url('${datasrc}')` })
  }
  $(element).addClass('b-loaded').removeClass('lazy').removeAttr('data-src')
}