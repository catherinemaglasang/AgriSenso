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

        .otherwise({
            redirectTo: '/AgriSenso'
        });

    $resourceProvider.defaults.stripTrailingSlashes = false;
});
