export function create(blob) {
  return function () {
    return globalThis.createImageBitmap(blob);
  };
}

export function rasterize(size) {
  return function (blob) {
    return async function () {
      if (typeof document === "undefined") {
        throw new Error("SVG rasterization requires a document-owned image decoder");
      }

      const objectUrl = URL.createObjectURL(blob);
      try {
        const image = new Image();
        await new Promise((resolve, reject) => {
          image.addEventListener("load", resolve, { once: true });
          image.addEventListener(
            "error",
            () => reject(new Error("SVG image could not be decoded")),
            { once: true },
          );
          image.src = objectUrl;
        });
        const naturalWidth = image.naturalWidth;
        const naturalHeight = image.naturalHeight;
        if (!(naturalWidth > 0 && naturalHeight > 0)) {
          throw new Error("SVG image has no intrinsic dimensions");
        }
        const maximum = size.maximum;
        if (!(maximum > 0)) {
          throw new Error("SVG rasterization maximum must be positive");
        }
        const scale = maximum / Math.max(naturalWidth, naturalHeight);
        const width = Math.max(1, Math.round(naturalWidth * scale));
        const height = Math.max(1, Math.round(naturalHeight * scale));
        const canvas = document.createElement("canvas");
        canvas.width = width;
        canvas.height = height;
        const context = canvas.getContext("2d");
        if (context === null) {
          throw new Error("Could not create an SVG rasterization context");
        }
        context.drawImage(image, 0, 0, width, height);
        return { source: canvas.toDataURL("image/png"), width, height };
      } finally {
        URL.revokeObjectURL(objectUrl);
      }
    };
  };
}

export function width(bitmap) {
  return function () {
    return bitmap.width;
  };
}

export function height(bitmap) {
  return function () {
    return bitmap.height;
  };
}

export function close(bitmap) {
  return function () {
    bitmap.close();
  };
}

export function toCanvasImageSource(bitmap) {
  return bitmap;
}
