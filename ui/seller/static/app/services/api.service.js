mainApp.factory("Seller", ['$resource',
	function ($resource) {
		return $resource("http://localhost:5000/sellers/:id", {id:'@id'}, {});
	}]);

mainApp.factory("Product", ['$resource',
    function ($resource) {
        return $resource("http://localhost:5000/products/:id", {id: '@id'}, {});
    }]);

mainApp.factory("Contact", ['$resource',
    function ($resource) {
        return $resource("http://localhost:5000/contacts/:id", {id: '@id'}, {});
    }]);

