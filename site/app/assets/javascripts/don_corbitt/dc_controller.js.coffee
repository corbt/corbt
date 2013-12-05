angular.module('dc').controller 'dc_cntl', ($scope, $http) ->
# window.dc_cntl = ($scope, $location) ->
	for list in lists 
		# You can't see it, but I'm adding a zero-width space before the "." for word wrap
		list['name'] = list['name'].replace /\./g, "​."

	$scope.select_list = (list) ->
		$scope.load_threads list.id
		$scope.current_list = list.id
		$scope.current_thread = null

	$scope.load_threads = (list) ->
		unless $scope.threads[list]?
			$http.get("/don/threads/by_list/#{list}.json").success (threads) ->
				$scope.threads[list] = threads
				console.log threads
		# console

	$scope.current_threads = ->
		$scope.threads[$scope.current_list]

	$scope.select_thread = (thread) ->
		$scope.current_thread = thread.id

	$scope.current_posts = ->
		$scope.posts[$scope.current_thread]

	$scope.lists = lists
	$scope.threads = {}
	$scope.posts = {}
	# $scope.select_list lists[0]