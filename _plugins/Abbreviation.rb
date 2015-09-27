module Jekyll
	class AbbrTag < Liquid::Tag
		def initialize(tag_name, text, tokens)
			super
			split = text.split(' ')
			@text = split[1..-1].join(' ')
			@abbr = split[0]
		end

		def render(context)
			%(<abbr title="#@text">#@abbr</abbr>)
		end
	end
end

Liquid::Template.register_tag('abbr', Jekyll::AbbrTag)