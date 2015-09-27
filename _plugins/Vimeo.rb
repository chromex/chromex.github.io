module Jekyll
	class VimeoTag < Liquid::Tag
		def initialize(tag_name, text, tokens)
			super
			params = text.split(' ')
			@id = params[0]
			@width = params[1]
			@height = params[2]
		end

		def render(context)
			%(<center><iframe src="http://player.vimeo.com/video/#@id" width="#@width" height="#@height" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe></center>)
		end
	end
end

Liquid::Template.register_tag('vimeo_video', Jekyll::VimeoTag)