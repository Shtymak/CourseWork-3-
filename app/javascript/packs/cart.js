import Rails from "@rails/ujs"
import {
    Modal
} from "bootstrap"
import toastr from "toastr"
import "./maps"

toastr.options = {
    "closeButton": false,
    "debug": false,
    "positionClass": "toast-top-right",
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
}
window.toastr = toastr

document.addEventListener("turbolinks:load", () => {
    document.querySelectorAll(".buy").forEach((item) => {
        item.addEventListener("click", addToCart)
    });

    if (!location.href.includes('cart')) return
    document.getElementById('show_order').addEventListener("click", showCart)
    document.getElementById('hidden_order').addEventListener("click", hiddenCart)
    document.getElementById('clear_cart').addEventListener("click", clearCart)
    document.querySelectorAll(".card_close").forEach((item) => {
        item.addEventListener("click", removeFromCart)
    });
    document.querySelectorAll(".plus").forEach((item) => {
        item.addEventListener("click", plusDishCount)
    });
    document.querySelectorAll(".minus").forEach((item) => {
        item.addEventListener("click", minusDishCount)
    });
})

function addToCart() {
    const cart = event.target.closest(".product_cart")
    const dishId = cart.dataset.id
    Rails.ajax({
        type: "POST",
        url: `/dishes/${dishId}/add_to_cart`,
        success: function (response) {
            toastr.success("Страву додано")
            const cartCount = document.getElementById("cart_count");
            cartCount.innerText = response.count;
            recountOrderSum()
        },
        error: function (response) {
            toastr.danger("Щось пішло не так :(")
        }
    })

}

function removeFromCart() {

    event.preventDefault();
    const cart = event.target.closest(".dish_cart")
    const dishId = cart.dataset.dishId
    Rails.ajax({
        type: "DELETE",
        url: `/dishes/${dishId}/remove_from_cart`,
        success: function (response) {

            toastr.warning("Страву видалено")
            const cartCount = document.getElementById("cart_count");
            cartCount.innerText = response.count;

            if (cartCount === 0) {
                const dishes = document.getElementById("dishes")
                if (dishes) {
                    dishes.style.display = "none"
                }
            } else {
                const price = parseFloat(cart.querySelector(".dish-price").innerText)
                const count = parseInt(cart.querySelector("input[type='number']").value)
                const dishSum = document.querySelectorAll(".order_sum")
                let sum = dishSum[0].innerText;
                dishSum.forEach(x => x.innerText = parseFloat(sum) - (price * count).toFixed(2));
            }
            cart.remove();
            recountOrderSum();
        },
        error: function (response) {
            toastr.danger("Щось пішло не так :(")
        }
    })

}

function clearCart() {
    if (confirm("Очистити Кошик?")) {
        Rails.ajax({
            type: "DELETE",
            url: `/cart/clear_cart`,
            success: function (response) {
                toastr.warning("Кошик очищено")
                const dishes = document.getElementById("dishes")
                if (dishes) {
                    dishes.style.display = "none"
                }
            },
            error: function (response) {
                toastr.danger("Щось пішло не так :(")
            }
        })
    }
}


function showCart() {
    const dishes = document.getElementById("dishes")
    const form = document.getElementById("order_form")
    dishes.style.display = "none"
    form.style.display = "block"
    recountOrderSum()
}

function hiddenCart() {
    const dishes = document.getElementById("dishes")
    const form = document.getElementById("order_form")
    dishes.style.display = "block"
    form.style.display = "none  "
    recountOrderSum()
}

function changeDishCount() {
    const cart = event.target.closest(".dish_cart")
    const price = parseFloat(cart.querySelector(".dish-price").innerText)
    const count = parseInt(cart.querySelector("input[type='number']").value)
    const dishSum = cart.querySelector(".card_price")
    dishSum.innerText = (price * count).toFixed(0)
    recountOrderSum()
}

function plusDishCount() {
    const cart = event.target.closest(".dish_cart")
    const price = parseFloat(cart.querySelector(".dish-price").innerText)
    const counter = cart.querySelector("input[type='number']")
    counter.stepUp();
    const count = parseInt(counter.value)
    const dishSum = cart.querySelector(".dish_sum")
    dishSum.innerText = (price * count).toFixed(0)
    recountOrderSum();
}

function minusDishCount() {
    const cart = event.target.closest(".dish_cart")
    const price = parseFloat(cart.querySelector(".dish-price").innerText)
    const counter = cart.querySelector("input[type='number']")
    counter.stepDown();
    const count = parseInt(counter.value)
    const dishSum = cart.querySelector(".dish_sum")
    dishSum.innerText = (price * count).toFixed(0)
    recountOrderSum();
}


function recountOrderSum() {
    const deliverySum = document.getElementById("order_delivery_sum")
    let sum = 0
    document.querySelectorAll(".dish_sum").forEach(item => {
        sum += parseFloat(item.innerText)
    });
    document.querySelectorAll(".order_sum").forEach(item => {
        item.innerText = sum.toFixed(0)
    });
    const needSum = document.querySelector(".free_delivery_need_sum")
    const needSumBlock = needSum.closest(".card_price")
    if (sum > 800) {
        deliverySum.style.display = "none"
        needSumBlock.style.display = "none"
    } else if (sum > 500 && sum < 800) {
        deliverySum.style.display = "block"
        needSumBlock.style.display = "block"
        needSum.innerText = 800 - sum
    } else {
        deliverySum.style.display = "none"
        needSumBlock.style.display = "block"
        needSum.innerText = 800 - sum
    }
}
