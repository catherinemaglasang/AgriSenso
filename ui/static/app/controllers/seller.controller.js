mainApp.controller('SellerController', ['$scope', '$http', '$location', '$filter', 'Contact', 'Product', '$routeParams', function ($filter, $scope, $http, $location, Contact, Product, $routeParams) {

    $scope.product= new Product();
    $scope.contact = new Contact();

    $scope.productList = [];
    $scope.contactList = [];

    $scope.addProduct = function () {
        $scope.product.product_id = null;
        $scope.product.date_added = $filter('date')(Date.now(), 'MMM-dd-yyyy HH:mm:ss');
        $scope.product.$save(function () {
            $scope.product = new Product();
            $location.path('/dashboard/products');
            $scope.initialize();
        });
    };

    $scope.addContact = function () {
        $scope.contact.contact_id = null;
        $scope.contact.$save(function () {
            $scope.contact= new Contact();
            $location.path('/dashboard/addcontact');
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

mainApp.controller('SellerLoginController', function($scope, $location, $rootScope){
    $scope.submit = function() {
        if($scope.username == 'marjorie@gmail.com' && $scope.password == 'asdasd') {
            $rootScope.loggedIn = true;
            $location.path('/seller/dashboard');
        } else {
            alert('Invalid credentials');
        }
    }
});