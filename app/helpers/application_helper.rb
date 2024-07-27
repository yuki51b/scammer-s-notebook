# frozen_string_literal: true

module ApplicationHelper
  include MarkdownHelper
  
    def flash_background_color(type)
      case type.to_sym
        when :notice then "bg-green-500"
        when :alert  then "bg-red-500"
        when :error  then "bg-yellow-500"
        else "bg-gray-500"
      end
    end

    def page_title(title = '')
      base_title = '詐欺師の手帳'
      title.present? ? "#{title} | #{base_title}" : base_title
    end
end
