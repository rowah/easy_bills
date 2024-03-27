let ProfileFormHooks = {}
ProfileFormHooks.UserAvatar = {
  mounted() {
    console.log('MOUNTED')
    let hook = this
    let container = hook.el
    let fileInput = container.querySelector('.live-file-input')
    let button = container.querySelector('#avatar-upload-button')

    button.addEventListener('click', () => {
      fileInput.click()
    })
  },
}

export default ProfileFormHooks
