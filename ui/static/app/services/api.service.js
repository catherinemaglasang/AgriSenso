mainApp.factory("Contact", ['$resource',
    function ($resource) {
        return $resource("http://localhost:5000/contacts/:contact_id", {contact_id: '@contact_id'}, {'update': {method: 'PUT'}});
    }]);

mainApp.factory("Product", ['$resource',

    function ($resource) {
        return $resource("http://localhost:5000/products/:id", {id: '@id'}, {});
    }]);
