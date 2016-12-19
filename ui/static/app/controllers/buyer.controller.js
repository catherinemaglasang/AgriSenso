mainApp.controller('BuyerController', ['$scope', '$http', '$location', 'Contact', 'Product', '$routeParams', 'toaster', function ($scope, $http, $location, Contact, Product, $routeParams, toaster) {

    $scope.product= new Product();
    $scope.contact = new Contact();

    $scope.productList = [];
    $scope.contactList = [];

    //$scope.addProduct = function () {
    //    $scope.product.product_id = null;
    //    $scope.product.$save(function () {
    //        $scope.product = new Location();
    //        $location.path('/buyer/products');
    //        $scope.initialize();
    //    });
    //};
    $scope.Reset = function () {
            $scope.new_c_number = '';
            $scope.new_name = '';
            $scope.new_l_name = '';
        }
    $scope.Reset();

    $scope.addContact = function () {
        $scope.contactList.push({
            'c_number': $scope.new_c_number,
            'name': $scope.new_name,
            'l_name': $scope.new_l_name
        });

        toaster.pop({
            type: 'success',
            title: 'Success',
            body: 'Added new contact',
            showCloseButton: true
        });
        console.log($scope.contactList);
        $scope.Reset();

        //$scope.contact.contact_id = null;
        //$scope.contact.$save(function () {
        //    $scope.contact= new Contact();
        //    $location.path('/buyer/dashboard/contacts');
        //    $scope.initialize();
        //});

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



mainApp.controller('BuyerLoginController', function($scope, $location, $rootScope, toaster){
    $scope.submit = function() {
        if($scope.username == 'cath@gmail.com' && $scope.password == 'cath') {
            $rootScope.loggedIn = true;
            toaster.pop({
                type: 'success',
                title: 'Successfully logged in',
                body: 'Welcome ' + $scope.username + '!',
                showCloseButton: true
            });
            $location.path('/buyer/dashboard');
        } else {
            alert('Invalid credentials');
        }
    }
});


