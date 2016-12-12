mainApp.controller('MainController', ['$scope', '$http', '$location', 'Contact', 'Product', '$routeParams', function ($scope, $http, $location, Contact, Product, $routeParams) {

    $scope.product= new Product();
    $scope.contact = new Contact();

    $scope.productList = [];
    $scope.contactList = [];

    $scope.addProduct = function () {
        $scope.product.product_id = null;
        $scope.product.$save(function () {
            $scope.product = new Location();
            $location.path('/dashboard/products');
            $scope.initialize();
        });
    };

    $scope.addContact = function () {
        $scope.contact.contact_id = null;
        $scope.contact.$save(function () {
            $scope.contact= new Contact();
            $location.path('/dashboard/contacts');
            $scope.initialize();
        });
    };


    $scope.initialize = function () {
        Product.get(function (data) {
            $scope.productList = data.entries;
        });
        Contact.get(function (data) {
            $scope.contactList = data.entries;
        });
    };

    $scope.initialize();

}]);


//
//mainApp.controller('LocationDetailController', ['$scope', '$http', '$location', 'Item', 'Location', 'Attribute', '$routeParams', function ($scope, $http, $location, Item, Location, Attribute, $routeParams) {
//    var locationId = $routeParams.id;
//
//    $scope.location = '';
//
//    $scope.getLocationDetail = function () {
//        Location.get({id: locationId}, function (data) {
//            $scope.location = data.entries[0];
//        });
//    };
//
//    $scope.updateLocationDetail = function () {
//        Location.update({id: locationId}, $scope.location, function () {
//            $location.path('/dashboard/locations/all');
//        });
//    };
//
//    $scope.getLocationDetail();
//}]);

