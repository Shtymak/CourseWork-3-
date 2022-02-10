// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import IMask from "imask";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "bootstrap"
import "../stylesheets/application"
import "./order"
import "./cart"
import "./facebook"

document.addEventListener('turbolinks:load', () => {
    const links = document.querySelectorAll(".category_item");
    for (const link of links) {
        link.addEventListener("click", clickHandler);
    }

    const inp = document.querySelector(".phone")
    if (inp) {
        inp.addEventListener('input', () => {
            const phoneMask = IMask(
                event.target, {
                    mask: '+{00} (000) 000-00-00'
                });
        });
    }
    document.querySelectorAll("form").forEach((item, i) => {
        item.addEventListener("keydown", disableSubmitByEnter)
    });
    const hourBookingSelector = document.getElementsByName("booking[select_time(4i)]")[0]
    const hourOrderSelector = document.getElementsByName("order[delivery_time(4i)]")[0]
    const bookingDateSelector = document.getElementById("booking_select_date")
    const orderDateSelector = document.getElementById("order_delivery_date")


    if (hourBookingSelector != null) {
        const minute = document.getElementById("booking_minute")
        bookingDateSelector.addEventListener('change', () => {
            minute.innerHTML = null;
            for (let i = 0; i <= 50; i += 10) {
                minute.add(buildOption(i, i), null);
            }
        })
        hourBookingSelector.addEventListener('change', () => {
            let bookingSelectDate = new Date(bookingDateSelector.value)
            minute.innerHTML = null
            let hour = new Date()
            hour.setMinutes(hour.getMinutes() + 30)
            if (hourBookingSelector.value == hour.getHours()) {
                let defaultMinute = new Date()
                if(hour.getDate() == bookingSelectDate.getDate())
                    defaultMinute.setMinutes(defaultMinute.getMinutes() + 30 + (10 - defaultMinute.getMinutes() % 10))
                else
                    defaultMinute.setMinutes(0)
                for (let i = defaultMinute.getMinutes(); i <= 50; i += 10) {
                    minute.add(buildOption(i, i), null);
                }
            } else {
                let startMinute = new Date()
                if (startMinute.getMinutes() > 30 && startMinute.getHours() > hourBookingSelector.value + 1) {
                    startMinute.setMinutes(startMinute.getMinutes() + 30 + (10 - startMinute.getMinutes() % 10))
                } else {
                    startMinute.setMinutes(0)
                }

                console.log(startMinute.getDate())
                console.log(bookingSelectDate.getDate())
                for (let i = startMinute.getMinutes(); i <= 50; i += 10) {
                    minute.add(buildOption(i, i), null);
                }
            }
        })
    }
    if (hourOrderSelector != null) {
        const minute = document.getElementById("order_minute")
        orderDateSelector.addEventListener('change', () => {
            minute.innerHTML = null;
            for (let i = 0; i <= 50; i += 10) {
                minute.add(buildOption(i, i), null);
            }
        })
        hourOrderSelector.addEventListener('change', () => {
            let orderSelectDate = new Date(orderDateSelector.value)

            minute.innerHTML = null


            let time = new Date()
            if (hourOrderSelector.value == time.getHours() + 1 && time.getDate() == orderSelectDate.getDate()) {
                time.setMinutes(time.getMinutes() + 60 + (10 - time.getMinutes() % 10))
                for (let i = time.getMinutes(); i <= 50; i += 10)
                    minute.add(buildOption(i, i), null)
            } else {
                for (let i = 0; i <= 50; i += 10)
                    minute.add(buildOption(i, i), null)
            }
        })
    }
});

function buildOption(text, value) {
    let htmlOptionElement = document.createElement('option');
    htmlOptionElement.text = text;
    htmlOptionElement.value = value;
    return htmlOptionElement
}

function disableSubmitByEnter(e) {
    if (e.keyCode === 13) {
        e.preventDefault();
        return false;
    }
}

function clickHandler(e) {
    e.preventDefault();
    const href = this.getAttribute("href");

    document.querySelector(href).scrollIntoView({
        behavior: "smooth"
    });
}
