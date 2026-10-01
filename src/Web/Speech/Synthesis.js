export const getSynthesis = () =>
  typeof window !== "undefined" &&
  typeof window.SpeechSynthesisUtterance === "function" &&
  window.speechSynthesis != null
    ? window.speechSynthesis
    : null;

export const getVoices = synthesis => () => synthesis.getVoices();

export const voiceInfo = voice => ({
  name: voice.name,
  lang: voice.lang,
  localService: voice.localService,
  isDefault: voice.default,
});

export const newUtterance = text => () =>
  new window.SpeechSynthesisUtterance(text);

export const configureUtterance = utterance => settings => () => {
  utterance.voice = settings.voice;
  utterance.lang = settings.lang;
  utterance.rate = settings.rate;
  utterance.pitch = settings.pitch;
};

export const onStartNative = utterance => callback => () => {
  const listener = () => callback();
  utterance.addEventListener("start", listener);
  return () => utterance.removeEventListener("start", listener);
};

export const onBoundaryNative = utterance => callback => () => {
  const listener = event => callback({
    charIndex: event.charIndex,
    charLength: event.charLength,
    name: event.name,
  })();
  utterance.addEventListener("boundary", listener);
  return () => utterance.removeEventListener("boundary", listener);
};

export const onEndNative = utterance => callback => () => {
  const listener = () => callback();
  utterance.addEventListener("end", listener);
  return () => utterance.removeEventListener("end", listener);
};

export const onErrorNative = utterance => callback => () => {
  const listener = event => callback(event.error)();
  utterance.addEventListener("error", listener);
  return () => utterance.removeEventListener("error", listener);
};

export const speakNative = synthesis => utterance => () =>
  synthesis.speak(utterance);

export const cancelNative = synthesis => () => synthesis.cancel();
