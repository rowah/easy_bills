let darkModeHooks = {}

darkModeHooks.DarkModeToggle = {
  /**
   * Mounts the DarkModeToggle hook, sets the initial state based on the
   * previously applied theme, and adds a click event listener to toggle
   * the dark mode.
   */
  mounted() {
    // Set the initial state based on the previously applied theme
    this.handleIconVisibility()

    // Add a click event listener to toggle the dark mode
    this.el.addEventListener('click', () => {
      // Toggle the 'dark' class on the root element
      document.documentElement.classList.toggle('dark')

      // Store the currently applied theme in the local storage
      const theme = document.documentElement.classList.contains('dark')
        ? 'dark'
        : 'light'
      localStorage.setItem('theme', theme)

      // Update the visibility of the icons based on the current state
      this.handleIconVisibility()
    })

    // Set the initial visibility of the icons based on the currently applied theme
    this.handleIconVisibility()
  },

  /**
   * Handles the visibility of the light and dark icons.
   * @private
   */
  handleIconVisibility() {
    // Determine if the dark mode is currently enabled
    const darkModeOn = document.documentElement.classList.contains('dark')

    // Show the dark mode icon if the dark mode is enabled, or hide it if it's not
    document
      .getElementById('theme-toggle-dark-icon')
      .classList.toggle('hidden', !darkModeOn)

    // Show the light mode icon if the dark mode is disabled, or hide it if it's not
    document
      .getElementById('theme-toggle-light-icon')
      .classList.toggle('hidden', darkModeOn)
  },
}

export default darkModeHooks
