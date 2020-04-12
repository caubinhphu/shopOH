let imgNoti = null;

// crop images
const modalCropImg = document.querySelector("#modal-crop-img"); // modal crop img
const inputImg = document.getElementById("img");
const imgCrop = document.querySelector("#crop-img"); // area crop
const cropBtn = document.querySelector("#crop-btn");

modalCropImg.style.display = "none";
// init croppie image
const croppie = new Croppie(imgCrop, {
  enableExif: true,
  viewport: {
    width: 100,
    height: 100,
  },
  boundary: {
    width: 300,
    height: 300,
  },
});

inputImg.addEventListener("change", function () {
  // show modal crop image
  modalCropImg.style.display = "block";

  let reader = new FileReader();
  reader.onload = async function (e) {
    await croppie.bind({
      url: e.target.result,
    });
  };
  reader.readAsDataURL(this.files[0]);
});

cropBtn.addEventListener("click", async function (e) {
  let dataCrop = await croppie.result({
    type: "base64",
    size: "viewport",
  });
  document.querySelector(
    ".review-img"
  ).style.backgroundImage = `url('${dataCrop}')`;
  let blob = dataURLtoFile(dataCrop, "image.png");

  imgNoti = blob;

  // hide modal crop image
  modalCropImg.style.display = "none";
});

// create file from data base64
function dataURLtoFile(dataurl, filename) {
  let arr = dataurl.split(","),
    mime = arr[0].match(/:(.*?);/)[1],
    bstr = atob(arr[1]),
    n = bstr.length,
    u8arr = new Uint8Array(n);

  while (n--) {
    u8arr[n] = bstr.charCodeAt(n);
  }
  return new File([u8arr], filename, { type: mime });
}

document.querySelector("#save-btn").addEventListener("click", function () {
  if (!document.addNotiForm.checkValidity()) {
    alert("Validate form false kìa cu");
  } else {
    let form = new FormData(document.addNotiForm);
    form.delete("img");
    form.append("image", imgNoti);

    let xhr = new XMLHttpRequest();
    xhr.open("POST", "http://localhost:3000/admin/notification/add", true);
    xhr.onload = function () {
      if (xhr.status === 200) {
        alert("Thêm thông báo mới thành công");
        location.href = "http://localhost:3000/admin/notification";
      } else {
        alert("Thêm thông báo mới thất bại");
        location.reload();
      }
    };
    xhr.send(form);
  }
});
