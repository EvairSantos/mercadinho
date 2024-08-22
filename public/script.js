document.addEventListener('DOMContentLoaded', () => {
    const addCategoryButton = document.getElementById('addCategory');
    const removeCategoryButton = document.getElementById('removeCategory');
    const addProductButton = document.getElementById('addProduct');
    const removeProductButton = document.getElementById('removeProduct');
    const editProductButton = document.getElementById('editProduct');
    const checkStockButton = document.getElementById('checkStock');
    const bestSellingButton = document.getElementById('bestSelling');

    const addProductForm = document.getElementById('addProductForm');
    const closeAddProductFormButton = document.getElementById('closeAddProductForm');

    addProductButton.addEventListener('click', () => {
        addProductForm.style.display = 'block';
    });

    closeAddProductFormButton.addEventListener('click', () => {
        addProductForm.style.display = 'none';
    });

    // Adicione eventos para os outros botões conforme necessário
});
