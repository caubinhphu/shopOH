let idOrderTarget = "";
document.querySelectorAll(".del-order-btn").forEach((btn) => {
  btn.addEventListener("click", function () {
    idOrderTarget = this.dataset.order;
  });
});

document.getElementById("OK-del-btn").addEventListener("click", function () {
  axios
    .delete(`/admin/order/${idOrderTarget}`)
    .then((res) => {
      if (res.status === 200) {
        alert("Xóa order thành công");
        location.reload();
      }
    })
    .catch((err) => {
      alert("Không thể xóa order này");
      location.reload();
    });
});
