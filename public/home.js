document.addEventListener('DOMContentLoaded', function () {
    // Obtém elementos da página
    const productContainer = document.getElementById('product-container');
    const cartSidebar = document.getElementById('cart-sidebar');
    const cartIcon = document.getElementById('cart-icon');
    const cartCount = document.getElementById('cart-count'); // Notificação de quantidade no carrinho
    const cartItemsList = document.getElementById('cart-items');
    const cartTotal = document.getElementById('cart-total');
    const checkoutButton = document.getElementById('checkout-button');
    const clearCartButton = document.getElementById('clear-cart-button');
    const searchInput = document.getElementById('search-input');
    const categoryElements = document.querySelectorAll('.category');

    let cart = JSON.parse(localStorage.getItem('cart')) || [];
    let products = Array.from(document.querySelectorAll('.product'));

    function renderProducts(productsToRender) {
        productContainer.innerHTML = '';
        productsToRender.forEach(product => {
            productContainer.appendChild(product);
        });
    }

    function updateCartUI() {
        cartItemsList.innerHTML = '';
        let total = 0;
        let itemCount = 0;
        cart.forEach(item => {
            const listItem = document.createElement('li');
            listItem.innerHTML = `
                <img src="${item.image}" alt="${item.name}">
                <div class="item-info">
                    <h3>${item.name} <span class="item-quantity">(${item.quantity})</span></h3>
                    <p class="item-price">R$ ${item.price.toFixed(2).replace('.', ',')}</p>
                </div>
                <button class="remove-from-cart" data-id="${item.id}">Remover</button>
            `;
            cartItemsList.appendChild(listItem);
            total += item.price * item.quantity;
            itemCount += item.quantity;
        });
        cartTotal.textContent = `Total: R$ ${total.toFixed(2).replace('.', ',')}`;
        cartCount.textContent = itemCount; // Atualiza a notificação de quantidade
    }

    function addToCart(product) {
        const existingItemIndex = cart.findIndex(item => item.id === product.id);
        if (existingItemIndex >= 0) {
            cart[existingItemIndex].quantity += product.quantity;
        } else {
            cart.push(product);
        }
        localStorage.setItem('cart', JSON.stringify(cart));
        updateCartUI();
    }

    function handleCartIconClick() {
        cartSidebar.classList.toggle('active');
        document.body.classList.toggle('cart-active');
    }

    function handleOutsideClick(e) {
        if (cartSidebar.classList.contains('active') && !cartSidebar.contains(e.target) && e.target !== cartIcon) {
            cartSidebar.classList.remove('active');
            document.body.classList.remove('cart-active');
        }
    }

    function handleAddToCartClick(e) {
        if (e.target.classList.contains('add-to-cart')) {
            const productElement = e.target.closest('.product');
            const productId = productElement.dataset.id;
            const productName = productElement.dataset.name;
            const productPrice = parseFloat(productElement.dataset.price);
            const productQuantity = parseInt(productElement.querySelector('.quantity').value);
            const productImage = productElement.querySelector('img').src;
            
            const product = {
                id: productId,
                name: productName,
                price: productPrice,
                quantity: productQuantity,
                image: productImage
            };
            
            addToCart(product);
        }
    }

    function handleRemoveFromCartClick(e) {
        if (e.target.classList.contains('remove-from-cart')) {
            const productId = e.target.dataset.id;
            cart = cart.filter(item => item.id !== productId);
            localStorage.setItem('cart', JSON.stringify(cart));
            updateCartUI();
        }
    }

    function handleClearCartButtonClick() {
        cart = [];
        localStorage.removeItem('cart');
        updateCartUI();
    }

    function handleSearchInput() {
        const searchTerm = searchInput.value.toLowerCase();
        const filteredProducts = products.filter(product => {
            const name = product.dataset.name.toLowerCase();
            const description = product.dataset.description.toLowerCase();
            return name.includes(searchTerm) || description.includes(searchTerm);
        });
        renderProducts(filteredProducts);
    }

    function handleCategoryClick(e) {
        if (e.target.classList.contains('category')) {
            const categoryId = e.target.dataset.id;
            const filteredProducts = products.filter(product => product.dataset.categoryId === categoryId);
            renderProducts(filteredProducts);
        }
    }

    // Inicialização
    updateCartUI();
    
    // Eventos
    cartIcon.addEventListener('click', handleCartIconClick);
    document.addEventListener('click', handleOutsideClick);
    productContainer.addEventListener('click', handleAddToCartClick);
    cartItemsList.addEventListener('click', handleRemoveFromCartClick);
    clearCartButton.addEventListener('click', handleClearCartButtonClick);
    searchInput.addEventListener('input', handleSearchInput);
    categoryElements.forEach(category => category.addEventListener('click', handleCategoryClick));
});
