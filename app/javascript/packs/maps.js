document.addEventListener("turbolinks:load", () => {
    if (!location.href.includes('cart')) return
    initMap();
})

let location1 = null;

function initMap() {
    const mapOptions = {
        center: {
            lat: 48.613184,
            lng: 22.292591
        },
        zoom: 6
    };
    const map = new google.maps.Map(document.getElementById('map'), mapOptions);
    const marker = new google.maps.Marker({
        map: map,
    });

    const input = document.getElementById("order_address")
    const circle = new google.maps.Circle({center: new google.maps.LatLng(48.613184, 22.292591), radius: 15000})
    const options = {
        componentRestrictions: {country: "ua"},
        strictBounds: true,
        bounds: circle.getBounds(),
        fields: ["address_components", "geometry"],
        types: ["geocode"]
    }
    const autocomplete = new google.maps.places.Autocomplete(input, options);

    autocomplete.addListener("place_changed", () => {
        const place = autocomplete.getPlace();
        if (place) {
            if (place.address_components.length > 6) {
                input.value = place.address_components[1].long_name + ", " + place.address_components[0].long_name
                location1 = place.geometry.location
                marker.setPosition(location1);
                map.setCenter(location1);
                map.setZoom(17);
                calcDistance(location1);
            } else {
                toastr.warning("Виберіть адресу з номером будину")
            }
        }
    })
}

export function calcDistance(target) {
    const deliverySum = document.getElementById("order_delivery_sum_block")
    const deliverySumInput = document.getElementById("order_delivery_sum")
    const sum = parseFloat(document.querySelector(".order_sum").innerText)

    if (sum < 500 || sum > 800) {
        deliverySumInput.value = 0
        deliverySum.innerText = "(Уточніть вартість доставки)"
        return
    }

    const directionsService = new google.maps.DirectionsService();
    const base_address = "вулиця Велика Житомирська, 27 Київ 02000"

    directionsService.route(
        {
            origin: base_address,
            destination: target,
            travelMode: "DRIVING"
        },
        (response, status) => {
            const distance = response.routes[0].legs[0].distance.value
            console.log(distance);
            if (distance < 5000) {
                deliverySum.innerText = " + 50 грн."
                deliverySumInput.value = 50
            } else {
                deliverySum.innerText = " + 70 грн."
                deliverySumInput.value = 70
            }
        }
    )
}

const recalcDistance = () => {
        calcDistance(location1)
    }
document.recalcDistance = recalcDistance