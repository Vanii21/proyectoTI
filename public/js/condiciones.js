const btnFinalizarCompra = document.querySelector(".checkout-btn");

btnFinalizarCompra.addEventListener("click", () => {
    const compra = JSON.parse(localStorage.getItem("cart"));
    if (!compra.length) {
        swal.fire("Debe seleccionar un producto para realizar su compra");
    } else {
        fetch("/finalizar", {
            method: "POST",
            headers:{
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                items: compra,
            }),
        })
        .then((res) => res.json())
        .then((data) => {
            if (data.url){
                window.location.href = data.url;
            }else{
                console.error('INVALID URL RECIVED FROM THE SERVER:', data.url);
            }
        })
        .catch((err) => console.error(err));
    }

})