// Header Scroll
let header = document.querySelector("header");

window.addEventListener("scroll", () => {
  header.classList.toggle("shadow", window.scrollY > 0);
});

// Obtengo la lista de productos y elementos
const productList = document.getElementById('productList');
const cartItemsElement = document.getElementById('cartItems');
const cartTotalElement = document.getElementById('cartTotal');

// Store Cart Items In Local Storage
let cart = JSON.parse(localStorage.getItem("cart")) || [];

// Render Product on Page
function renderProducts(data){
  productList.innerHTML = data
  .map(
    (product) => `
    <div class="product">
        <img src="${product.ruta}" alt="${product.nombre}" class="product-img">
        <div class="product-info">
            <h2 class="product-tittle">${product.nombre}</h2>
            <p class="product-price">Q${product.precio.toFixed(2)}</p>
            <a class="add-to-cart" data-id="${product.id_articulo}">Agregar Al Carrito</a>
        </div>
    </div>
    `
  ).join("");

  // Add to cart
  const addToCartButtons = document.getElementsByClassName("add-to-cart");

  for (let i = 0; i < addToCartButtons.length; i++){
    const addToCartButton = addToCartButtons[i];
    addToCartButton.addEventListener('click', addToCart);
  }
};

// Add to cart
function addToCart(event){

  fetch('http://localhost:3001/api')
    .then((res) => res.json())
    .then((data) => {
      const productID = parseInt(event.target.dataset.id);
      const product = data.find((product) => product.id_articulo === productID);

      if (product){
        // if product already in cart
        const exixtingItem = cart.find((item) => item.id_articulo === productID);

        if (exixtingItem){
          swal.fire("Su Articulo ya fue agregado");
        }else{
          const cartItem = {
            id_articulo: product.id_articulo,
            nombre: product.nombre,
            precio: product.precio,
            ruta: product.ruta,
            quantity: 1,
          };
          cart.push(cartItem);
      
        }
        //Change add to cart text to added
        if (event.target.textContent = 'Agregar Al Carrito'){
          event.target.textContent = 'Agregado'
        }
        updateCartIcon();
        saveToLocalStorage();
      }
    })
    .catch((err) => console.log(err));

}

// Remove from cart
function removeFromCart(event){
  const productID = parseInt(event.target.dataset.id);
  cart = cart.filter((item) => item.id_articulo !== productID);
  updateCartIcon();
  saveToLocalStorage();
  renderCartItems();
  calculateCartTotal();
}

// Quantity Change
function changeQuantity(event){
  const productID = parseInt(event.target.dataset.id);
  const quantity = parseInt(event.target.value);

  if (quantity > 0){
    const cartItem = cart.find((item) => item.id_articulo === productID);
    if (cartItem) {
      cartItem.quantity = quantity;
      updateCartIcon();
      saveToLocalStorage();
      calculateCartTotal();
    }
  }
}

// saveToLocalStorage
function saveToLocalStorage(){
  localStorage.setItem("cart", JSON.stringify(cart));
}

// Render Product on Cart Page
function renderCartItems(){
  cartItemsElement.innerHTML = cart.map(
  (item) => `
  <div class="cart-item">
      <img src="${item.ruta}" alt="${item.nombre}">
      <div class="cart-item-info">
          <h2 class="cart-item-title">${item.nombre}</h2>
          <input class="cart-item-quantity" type="number" name="" min="1" value="${item.quantity}" data-id="${item.id_articulo}">
      </div>
      <h2 class="cart-item-price">Q${item.precio}</h2>
      <button class="remove-from-cart" data-id="${item.id_articulo}">Remove</button>
  </div>
  `
  )
  .join("");
  // Remove from cart
  const removeToCartButtons = document.getElementsByClassName("remove-from-cart");

  for (let i = 0; i < removeToCartButtons.length; i++){
    const removeToCartButton = removeToCartButtons[i];
    removeToCartButton.addEventListener('click', removeFromCart);
  }
  //Quantity Change
  const quantityInputs = document.querySelectorAll(".cart-item-quantity");
  quantityInputs.forEach((input) => {
    input.addEventListener('change', changeQuantity);
  })
}

// Calculate total
function calculateCartTotal(){
  const total = cart.reduce((sum, item) => sum + item.precio * item.quantity, 0);
  cartTotalElement.textContent = `Total: Q${total.toFixed(2)}`;
}

// Check if on cart page
if (window.location.pathname.includes("/cart.html")){
  renderCartItems();
  calculateCartTotal();
  updateCartIcon();
} else if (window.location.pathname.includes("/success.html")){
  clearCart();
} else {
  fetch('http://localhost:3001/api')
    .then((res) => res.json())
    .then((data) => renderProducts(data))
    .catch((err) => console.log(err));

  updateCartIcon();
}

// Empty Cart on Successfull payment
function clearCart(){
  cart = [];
  saveToLocalStorage();
  updateCartIcon();
}

// Cart Icon Quantity
const cartIcon = document.getElementById("cart-icon");

function updateCartIcon(){
  const totalQuantity = cart.reduce((sum, item) => sum + item.quantity, 0);
  const cartIcon = document.getElementById('cart-icon');
  if (cartIcon !== null){
    cartIcon.setAttribute('data-quantify', totalQuantity);
  }
}


