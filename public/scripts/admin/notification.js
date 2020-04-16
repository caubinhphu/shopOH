let idNotification = '';

document.querySelectorAll('.del-noti-btn').forEach((btn) => {
  btn.addEventListener('click', function () {
    idNotification = this.dataset.noti;
  });
});

document.querySelector('#OK-del-btn').addEventListener('click', function () {
  axios
    .delete(`/admin/notification/${idNotification}`)
    .then((res) => {
      if (res.status === 200) {
        alert('Xóa thông báo thành công');
      }
      location.reload();
    })
    .catch((er) => {
      alert('Xóa thông báo thất bại');
      location.reload();
    });
});
