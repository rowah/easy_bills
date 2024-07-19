let darkModeHooks = {}

darkModeHooks.DarkModeToggle = {
  mounted() {
    this.handleIconVisibility()

    this.el.addEventListener('click', () => {
      document.documentElement.classList.toggle('dark')
      localStorage.setItem(
        'theme',
        document.documentElement.classList.contains('dark') ? 'dark' : 'light'
      )
      this.handleIconVisibility()
    })

    // Initial icon visibility setting based on already applied theme
    this.handleIconVisibility()
  },
  handleIconVisibility() {
    const darkModeOn = document.documentElement.classList.contains('dark')
    document
      .getElementById('theme-toggle-dark-icon')
      .classList.toggle('hidden', !darkModeOn)
    document
      .getElementById('theme-toggle-light-icon')
      .classList.toggle('hidden', darkModeOn)
  },
}

export default darkModeHooks
