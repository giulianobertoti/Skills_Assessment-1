﻿publication.factory('CourseService', ['$http', '$q', function ($http, $q) {

    return {

        courseList: _courseList,
        courseAdd: _courseAdd,
        courseDelete: _courseDelete,
        courseUpdate: _courseUpdate
    };

    function _courseList() {

        var deferred = $q.defer();

        $http({
            method: 'GET',
            url: config.generateApiUrl('searchAllCourses')
        }).
           success(function (data, status, headers, config) {
               deferred.resolve(data);
           });

        return deferred.promise;
    }

    function _courseAdd(data) {

        var deferred = $q.defer();

        $http({
            method: 'POST',
            url: config.generateApiUrl('insertCourse'),
            data: JSON.stringify(data)
        }).
           success(function (data, status, headers, config) {
               deferred.resolve(data);
           });

        return deferred.promise;
    }

    function _courseDelete(id) {

        var deferred = $q.defer();

        $http({
            method: 'DELETE',
            url: config.generateApiUrl('deleteCourse'),
            params: { "codeCourse": id }
        }).
           success(function (data, status, headers, config) {
               deferred.resolve(data);
           });

        return deferred.promise;
    }

    function _courseUpdate(obj) {

        var deferred = $q.defer();

        $http({
            method: 'PUT',
            url: config.generateApiUrl('updateCourse'),
            header : {'Content-Type' : 'application/json; charset=UTF-8'},
            data: JSON.stringify(obj)
        }).
           success(function (data, status, headers, config) {
               deferred.resolve(data);
           });

        return deferred.promise;
    }

}]);