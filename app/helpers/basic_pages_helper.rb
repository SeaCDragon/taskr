module BasicPagesHelper

	def full_title(title)
		if title.empty?
			return "Taskr"
		else
			return "#{title} | Taskr"
		end
	end

end
