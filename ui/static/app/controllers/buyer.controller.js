mainApp.controller('BuyerController', ['$scope', '$http', '$location', 'Contact', 'Product', '$routeParams', function ($scope, $http, $location, Contact, Product, $routeParams) {

    $scope.product= new Product();
    $scope.contact = new Contact();

    $scope.productList = [];
    $scope.contactList = [];

    //$scope.addProduct = function () {
    //    $scope.product.product_id = null;
    //    $scope.product.$save(function () {
    //        $scope.product = new Location();
    //        $location.path('/dashboard/products');
    //        $scope.initialize();
    //    });
    //};

    $scope.addContact = function () {
        //$scope.contact.contact_id = null;
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



mainApp.controller('BuyerLoginController', function($scope, $location, $rootScope){
    $scope.submit = function() {
        if($scope.username == 'cath@gmail.com' && $scope.password == 'cath') {
            $rootScope.loggedIn = true;
            $location.path('/buyer/dashboard');
        } else {
            alert('Invalid credentials');
        }
    }
});


