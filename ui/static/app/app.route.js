mainApp.config(function ($routeProvider, $locationProvider, $resourceProvider) {

    $routeProvider
        //Main
        .when('/AgriSenso', {
            templateUrl: 'common/content.html'
            //controller: 'MainController'
        })

        // Buyer Module

        .when('/buyer/login', {
            templateUrl: 'buyer/login.html',
            controller: 'BuyerLoginController'
        })

        .when('/buyer/logout', {
            templateUrl: 'buyer/login.html',
            controller: 'BuyerLogoutController'
        })

        .when('/buyer/dashboard', {
            resolve: {
                "check": function($location, $rootScope) {
                    if(!$rootScope.loggedIn) {
                        $location.path('/buyer/login')
                    }
                }
            },
            templateUrl: 'buyer/home.html',
            controller: 'BuyerController'
        })

        .when('/buyer/dashboard/contacts', {
             resolve: {
                "check": function($location, $rootScope) {
                    if(!$rootScope.loggedIn) {
                        $location.path('/buyer/login')
                    }
                }
            },
            templateUrl: 'buyer/contacts/contacts.html',
            controller: 'BuyerController'
        })

        .when('/buyer/dashboard/contacts/:contact_id', {
             resolve: {
                "check": function($location, $rootScope) {
                    if(!$rootScope.loggedIn) {
                        $location.path('/buyer/login')
                    }
                }
            },
            templateUrl: 'buyer/contacts/update_contact.html',
            controller: 'BuyerController'
        })


        .when('/buyer/dashboard/products', {
            templateUrl: 'buyer/products/products.html',
            controller: 'BuyerController'
        })

        .when('/buyer/dashboard/contacts/add', {
             resolve: {
                "check": function($location, $rootScope) {
                    if(!$rootScope.loggedIn) {
                        $location.path('/buyer/login')
                    }
                }
            },
            templateUrl: 'buyer/contacts/add_contacts.html',
            controller: 'BuyerController'
        })

        //Seller Module
        .when('/seller/login_seller', {
            templateUrl: 'seller/login_seller.html',
            controller: 'SellerLoginController'
        })
        .when('/seller/signup', {
            templateUrl: 'seller/signup_seller.html',
            controller: 'SellerController'
        })

        .when('/seller/dashboard', {
            resolve: {
                "check": function($location, $rootScope) {
                    if(!$rootScope.loggedIn) {
                        $location.path('/seller/login_seller')
                    }
                }
            },
            templateUrl: 'seller/index.html',
            controller: 'SellerController'
        })

        .when('/seller/dashboard/addcontact', {
            templateUrl: 'seller/addcontact.html',
            controller: 'SellerController'
        })

        .when('/seller/dashboard/contacts', {
            templateUrl: 'seller/contacts.html',
            controller: 'SellerController'
        })

        .when('/seller/dashboard/products/add', {
            templateUrl: 'seller/products/addproduct.html',
            controller: 'SellerController'
        })

        .when('/seller/dashboard/products', {
            templateUrl: 'seller/products/products.html',
            controller: 'SellerController'
        })

        .otherwise({
            redirectTo: '/AgriSenso'
        });

    $resourceProvider.defaults.stripTrailingSlashes = false;
});
