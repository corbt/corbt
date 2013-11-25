angular.module('dc', []).controller 'dc_cntl', ($scope) ->
# window.dc_cntl = ($scope, $location) ->
	for list in lists 
		# You can't see it, but I'm adding a zero-width space before the "." for word wrap
		list['name'] = list['name'].replace /\./g, "​."

	$scope.select_list = (list) ->
		$scope.selected = list.id

	$scope.lists = lists
	$scope.select_list lists[0]