document.addEventListener("turbolinks:load", () => {
  const delivery = document.getElementById("order_self_pickup_delivery")
  const self_pickup = document.getElementById("order_self_pickup_self_pickup")
  const cash = document.getElementById("order_payment_type_cash")
  const card = document.getElementById("order_payment_type_card")

  if (delivery !== null){
    delivery.addEventListener('click', () => {
      cash.disabled = true
      cash.checked = false
      card.checked = true
    });
  }
  if (self_pickup !== null){
    cash.disabled = true
    self_pickup.addEventListener('click', () => {
      cash.disabled = false
    });
  }
});
document.addEventListener("turbolinks:load", () => {
  const delivery = document.getElementById("order_self_pickup_delivery")
  const self_pickup = document.getElementById("order_self_pickup_self_pickup")
  const cash = document.getElementById("order_payment_type_cash")
  const card = document.getElementById("order_payment_type_card")

  if (delivery !== null){
    delivery.addEventListener('click', () => {
      cash.disabled = true
      cash.checked = false
      card.checked = true
      deliverySum.style.display = 'block';
    });
  }
  if (self_pickup !== null){
    cash.disabled = true
    self_pickup.addEventListener('click', () => {
      cash.disabled = false
      deliverySum.style.display = 'none';
    });
  }
});

function dateChange(date) {
  let timeField = document.getElementById("time")
  let filedDate = new Date(date).getDate();
  const endDayHour = 21
  const currentDate = new Date()
  if (filedDate !== currentDate.getDate()) {
    while (timeField.options.length > 0) {
      timeField.remove(0);
    }
    for (let hour = 11; hour <= endDayHour; hour++) {
      let option = document.createElement('option');
      option.value = hour;
      option.innerHTML = hour;
      timeField.appendChild(option);
    }
  }
  else{
    while (timeField.options.length > 0) {
      timeField.remove(0);
    }
    let nowHour = currentDate.getHours() + 1 >= 11 ? currentDate.getHours() + 1  : 11
    for (let hour = nowHour; hour <= endDayHour; hour++) {
      let option = document.createElement('option');
      option.value = hour;
      option.innerHTML = hour;
      timeField.appendChild(option);
    }
  }
}
window.dateChange = dateChange

