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
            $location.path('/seller/dashboard/products');
            $scope.initialize();
        });
        toaster.pop({
            type: 'success',
            title: 'Success',
            body: 'Added New Product',
            showCloseButton: true
        });
    };

    $scope.addContact = function () {
        $scope.contact.contact_id = null;
        $scope.contact.$save(function () {
            $scope.contact= new Contact();
            $location.path('/seller/dashboard/contacts');
            $scope.initialize();
        });
        toaster.pop({
            type: 'success',
            title: 'Success',
            body: 'Added New Contact',
            showCloseButton: true
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

mainApp.controller('SellerLoginController', function($scope, $location, $rootScope, toaster){
    $scope.submit = function() {
        if($scope.username == 'marjorie@gmail.com' && $scope.password == 'asdasd') {
            $rootScope.loggedIn = true;
            toaster.pop({
                type: 'success',
                title: 'Successfully logged in',
                body: 'Welcome ' + $scope.username + '!',
                showCloseButton: true
            })
            $location.path('/seller/dashboard');
        } else {
            alert('Invalid credentials');
        }
    }
});

mainApp.controller('SellerLogoutController', function($location, $window, $scope, toaster, $rootScope){
    $rootScope.loggedIn = false;
    $window.localStorage.clear();
    $location.path('/seller/login_seller.html');
    toaster.pop({
        type: 'success',
        title: 'Success',
        body: 'Logged out',
        showCloseButton: true
    });
    $rootScope.loggedIn = false;

});

