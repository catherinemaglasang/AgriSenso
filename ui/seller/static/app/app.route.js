mainApp.config(function ($routeProvider, $locationProvider, $resourceProvider) {

    $routeProvider
    // Authentication Module

        .when('/login', {
            templateUrl: '/pages/login_seller.html',
            controller: 'MainController'
        })

        // Inventory Module
        .when('/dashboard/addcontact', {
            templateUrl: 'pages/addcontact.html',
            controller: 'MainController'
        })

        .when('/dashboard/contacts', {
            templateUrl: 'pages/contacts.html',
            controller: 'MainController'
        })

        .when('/dashboard/addproduct', {
            templateUrl: 'pages/addproduct.html',
            controller: 'MainController'
        })

        .otherwise({
            redirectTo: '/dashboard'
        });

    $resourceProvider.defaults.stripTrailingSlashes = false;
});
