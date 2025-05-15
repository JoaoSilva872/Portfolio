
let searchInput = document.querySelector('input[name="search"]');
let produtos = document.querySelectorAll('.produto');

searchInput.addEventListener('input', function () {
    let searchTerm = this.value.toLowerCase();

    produtos.forEach(produto => {
        let nomeProduto = produto.querySelector('.nome_produto').textContent.toLowerCase();

        if (nomeProduto.includes(searchTerm)) {
            produto.style.display = '';
        } else {
            produto.style.display = 'none';
        }
    });
});
