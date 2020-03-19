const profileForm = document.profileForm;

let isChangeForm = false;

profileForm.addEventListener('change', () => (isChangeForm = true));

profileForm.addEventListener('submit', e => {
  if (!isChangeForm) {
    e.preventDefault();
  }
});
