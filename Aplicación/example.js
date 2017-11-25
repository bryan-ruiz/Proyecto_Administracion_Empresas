
// Code goes here
var myApp = angular.module('myApp', ['angularUtils.directives.dirPagination']);
myApp.controller('MyController', MyController);

function MyController($scope) {
  $scope.currentId = 0;
  $scope.newPermission = {}
  $scope.currentPage = 1;
  $scope.pageSize = 10;
  $scope.permissions = [];
  $scope.globalComponent = {}
  for (var i = 1; i <= 100; i++) {  
    $scope.currentId = i;
    $scope.permission = {};
    $scope.permission.id = i;
    $scope.permission.name = "permiso "+i;
    $scope.permissions.push($scope.permission);
  };

  $scope.remove = function(permission) {
    $scope.permissions.splice($scope.permissions.indexOf(permission),1);
  }

  $scope.addPermission = function() {
    $scope.permission = {};
    $scope.permission.id = $scope.currentId += 1;
    $scope.permission.name = $scope.newPermission.name;
    $scope.permissions.push($scope.permission); 
    $scope.$apply();
    console.log($scope.permissions);
  }

  $scope.addComponentToEditingModal = function(component) {
    $scope.globalComponent = component;
    $scope.oldComponent = component.name;
  }

  $scope.save = function() {
    $scope.globalComponent.name = $scope.oldComponent;
  }
}



function OtherController($scope) {
  
  $scope.pageChangeHandler = function(num) {
      console.log('meals page changed to ' + num);
  };
}

function ThirdController($scope) {
  
  $scope.currentPage = 1;
  $scope.pageSize = 10;
  $scope.drinks = [];
  
  var drinks = [
    'coke',
    'melange',
    'chai latte',
    'almdudler',
    'beer',
    'vodka',
    'coconut milk',
    'orange juice',
    'wine',
    'whisky',
    'sex on the beach'
  ];
  for (var i = 1; i <= 20; i++) {
    var drink = drinks[Math.floor(Math.random() * drinks.length)];
    $scope.drinks.push('drink ' + i + ': ' + drink);
  }
  
  $scope.pageChangeHandler = function(num) {
      console.log('drinks page changed to ' + num);
  };
}