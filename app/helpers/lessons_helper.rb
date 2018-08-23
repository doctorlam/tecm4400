module LessonsHelper
	def options_for_lesson_type 
		['Main', 'Lab']
	end
	def options_for_week
		['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5','Week 6', 'Week 7', 'Week 8','Week 9', 'Week 10','Week 11','Week 12','Week 13','Week 14','Week 15']
	end
	def truncate_with_hover(text_to_truncate, length = 30)
    "<span title='#{text_to_truncate.gsub("'","\\'")}'>#{truncate(text_to_truncate, :length => length)}</span>" if !text_to_truncate.blank?
end
end
