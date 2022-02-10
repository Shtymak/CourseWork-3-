document.addEventListener("turbolinks:request-start", saveFacebookRoot);
document.addEventListener('turbolinks:load', restoreFacebookRoot);

let fbRoot;

function saveFacebookRoot() {
  const temp = document.querySelector("#fb-root");
  if (temp) {
    temp.querySelector("[data-turbolinks-no-cache]")?.remove();
    fbRoot = temp;
    temp.remove();
  }
}

function restoreFacebookRoot() {
  if (fbRoot != null) {
    const temp = document.querySelector("#fb-root");
    if (temp) {
      temp.replaceWith(fbRoot);
    } else {
      document.querySelector("body").append(fbRoot)
    }
  }
}
