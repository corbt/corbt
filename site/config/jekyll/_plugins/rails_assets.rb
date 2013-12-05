module Jekyll
	class RailsCSS < Liquid::Tag
		def initialize(tag_name, text, tokens)
			@stylesheet = find_stylesheet
		end

		def render(context)
			"<link data-turbolinks-track=\"true\" href=\"#{@stylesheet}\" media=\"all\" rel=\"stylesheet\" />"
		end

		def find_stylesheet
			# system('bundle exec rake assets:precompile')
			Dir.glob('../../public/assets/*.css') do |f|
				return f[12..f.size]
			end
		end
	end

	class RailsJS < Liquid::Tag
		def initialize(tag_name, text, tokens)
			@javascript = find_javascript
		end

		def render(context)
			"<script data-turbolinks-track=\"true\" src=\"#{@javascript}\"></script>"
		end

		def find_javascript
			# system('bundle exec rake assets:precompile')
			Dir.glob('../../public/assets/*.js') do |f|
				return f[12..f.size]
			end
		end
	end

end

Liquid::Template.register_tag 'RailsCSS', Jekyll::RailsCSS
Liquid::Template.register_tag 'RailsJS', Jekyll::RailsJS