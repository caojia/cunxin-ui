module ApplicationHelper
  def klass_for_col items_per_col
    case items_per_col
    when 3 then "span4"
    when 4 then "span3"
    when 5 then "span2_4"
    end
  end

  def button_link klass
    (<<-HTML
    <div class='button #{klass}'>
      <div class='btn-left'>
      #{yield}
      </div>
      <div class='btn-right'></div>
    </div>
    HTML
    ).html_safe
  end
end
