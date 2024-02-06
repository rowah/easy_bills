let ProfileFormHooks = {}

import generateImageThumbnail from '../utils/generateImageThumbnail'

ProfileFormHooks.UserAvatar = {
  mounted() {
    console.log('MOUNTED')
    let hook = this
    let container = hook.el
    let avatar = container.querySelector('#user-avatar')
    let hiddenField = container.querySelector('#avatar-update-form_image')
    let fileInput = container.querySelector('#avatar-file')
    let button = container.querySelector('#avatar-upload-button')

    button.addEventListener('click', () => {
      fileInput.click()
    })

    fileInput.addEventListener('change', () => {
      generateImageThumbnail(fileInput.files[0], [120, 120]).then(
        (thumbnail) => {
          avatar.setAttribute('src', thumbnail)
          hiddenField.value = thumbnail
        }
      )
    })
  },
}

// export default ProfileFormHooks
