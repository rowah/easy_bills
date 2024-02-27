let ProfileFormHooks = {}

// import generateImageThumbnail from '../utils/generateImageThumbnail'

ProfileFormHooks.UserAvatar = {
  mounted() {
    console.log('MOUNTED')
    let hook = this
    let container = hook.el
    // let avatar = container.querySelector('#user-avatar')
    // let hiddenField = container.querySelector('#avatar-update-form_avatar_url')
    let fileInput = container.querySelector('.live-file-input')
    let button = container.querySelector('#avatar-upload-button')

    button.addEventListener('click', () => {
      fileInput.click()
    })
  },
}

export default ProfileFormHooks
