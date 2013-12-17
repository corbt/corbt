if window.angular
	angular.module('dc').controller 'dc_cntl', ($scope, $http, $sanitize) ->
	# window.dc_cntl = ($scope, $location) ->
		for list in lists 
			# You can't see it, but I'm adding a zero-width space before the "." for word wrap
			list['name'] = list['name'].replace /\./g, "​."

		$scope.select_list = (list) ->
			$scope.load_threads list.id
			$scope.current_list = list
			$scope.current_thread = null

		$scope.load_threads = (list) ->
			unless $scope.threads[list]?
				$http.get("/don/threads/by_list/#{list}.json").success (threads) ->
					$scope.threads[list] = threads

		$scope.current_threads = ->
			if $scope.current_list
				$scope.threads[$scope.current_list.id]

		$scope.select_thread = (thread) ->
			$scope.load_posts thread.id
			$scope.current_thread = thread

		$scope.current_posts = ->
			if $scope.current_thread
				$scope.posts[$scope.current_thread.id]

		$scope.load_posts = (thread) ->
			unless $scope.threads[list]?
				$http.get("/don/posts/by_thread/#{thread}.json").success (posts) ->
					for post in posts
						post.summary = angular.element(post.content).find('p').text()
						post.expanded = post.corbitt
					$scope.posts[thread] = posts

		$scope.toggle_post = (post) ->
			if post.expanded
				post.expanded = false
			else
				post.expanded = true

		$scope.lists = lists
		$scope.threads = {}
		$scope.posts = {}

		# $scope.load_posts 5
		# $scope.current_thread = 5
		# $scope.select_list lists[0]