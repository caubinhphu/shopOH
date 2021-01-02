window.onload = function() {
  const id = setTimeout(() => {
    $('.loadding-page').addClass('hide-loader')
    clearTimeout(id)
  }, 300)
}