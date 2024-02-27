/*
 * Creates an image thumbnail to be used as an asset cover.
 * See: https://stackoverflow.com/a/61754764/920303
 */
export default (file, boundBox) => {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()

    reader.onload = (event) => {
      const image = new Image()

      image.onload = () => {
        const scaleRatio =
          typeof boundBox != 'undefined'
            ? Math.min(...boundBox) / Math.max(image.width, image.height)
            : 1
        const width = image.width * scaleRatio
        const height = image.height * scaleRatio

        const canvas = document.createElement('canvas')
        canvas.width = width
        canvas.height = height

        const ctx = canvas.getContext('2d')
        ctx.drawImage(image, 0, 0, width, height)

        return resolve(canvas.toDataURL(file.type))
      }

      image.src = event.target.result
    }

    reader.readAsDataURL(file)
  })
}
