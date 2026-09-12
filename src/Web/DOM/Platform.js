export const devicePixelRatio = () => window.devicePixelRatio;

export const observeResize = element => changed => () => {
  if (typeof ResizeObserver !== "function") return () => {};
  const observer = new ResizeObserver(() => changed());
  try {
    observer.observe(element);
  } catch (error) {
    observer.disconnect();
    throw error;
  }
  return () => observer.disconnect();
};

export const getStyleProperty = element => property => () => element.style.getPropertyValue(property);
export const setStyleProperty = element => property => value => () => element.style.setProperty(property, value);
export const innerHTML = element => () => element.innerHTML;
export const setInnerHTML = html => element => () => { element.innerHTML = html; };
export const isConnected = node => () => node.isConnected;
export const matchMedia = query => () => window.matchMedia(query);
