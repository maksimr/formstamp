mod = require('./module')

u = require('./utils')

mod.directive('fsDate', ->
  restrict: 'EA'
  require: '?ngModel'
  scope:
    class: '@'
    disabled: '=ngDisabled'
    placeholder: '@'
    format: '@'
  template: require('html!../templates/date.html')
  replace: true
  link: ($scope, element, attrs, ngModel) ->
    $scope.selectedDate = {}

    if ngModel
      ngModel.$render = ->
        $scope.selectedDate.date = ngModel.$modelValue

      $scope.$watch 'selectedDate.date', (newDate, oldDate) ->
        updatedDate = u.updateDate(newDate, oldDate)

        if updatedDate?.getTime() != oldDate?.getTime()
          ngModel.$setViewValue(updatedDate)

    $scope.close = ->
      $scope.active = false
)
