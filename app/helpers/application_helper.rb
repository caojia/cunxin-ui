module ApplicationHelper
  def klass_for_col items_per_col
    case items_per_col
    when 3 then "span4"
    when 4 then "span3"
    end
  end
end
