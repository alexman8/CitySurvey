module ApplicationHelper
  def join_elements_by_pipe(*elements)
    elements.select { |element| element.present? }.join('&nbsp;|&nbsp;').html_safe
  end
end
