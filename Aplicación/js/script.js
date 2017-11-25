﻿// Code goes here

var myApp = angular.module('myApp', ['angularUtils.directives.dirPagination']);
myApp.controller('MyController', MyController);

function MyController($scope) {

  $scope.currentPage = 1;
  $scope.pageSize = 10;
  $scope.permissions = [];
  for (var i = 1; i <= 100; i++) {  
    $scope.permission = {};
    $scope.permission.id = i;
    $scope.permission.nombre = "permiso "+i;
    $scope.permissions.push($scope.permission);
  };

  $scope.remove = function(permission) {
    $scope.permissions.splice($scope.permissions.indexOf(permission),1);
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