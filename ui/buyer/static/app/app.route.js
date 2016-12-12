mainApp.config(function ($routeProvider, $locationProvider, $resourceProvider) {

    $routeProvider
    // Authentication Module

        .when('/login', {
            templateUrl: 'pages/user/login.html',
            controller: 'MainController'
        })

        // Inventory Module
        .when('/dashboard', {
            templateUrl: 'pages/home.html',
            controller: 'MainController'
        })

        .when('/dashboard/contacts', {
            templateUrl: 'pages/contacts/contacts.html',
            controller: 'MainController'
        })


        .when('/dashboard/products', {
            templateUrl: 'pages/products/products.html',
            controller: 'MainController'
        })

        .when('/dashboard/contacts/add', {
            templateUrl: 'pages/contacts/add_contacts.html',
            controller: 'MainController'
        })

        .otherwise({
            redirectTo: '/dashboard'
        });

    $resourceProvider.defaults.stripTrailingSlashes = false;
});
