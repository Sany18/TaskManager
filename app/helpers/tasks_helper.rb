module TasksHelper
  @self = self

  def date_now
    r = Time.now
    "#{self.check_zero(r.year)}-#{self.check_zero(r.month)}-#{r.day}"
  end

  def check_zero num
    if num < 10
      "0#{num}"
    else
      num
    end
  end

  def color_of_priority id
    case id
    when 1
      "w3-light-green"
    when 2
      "w3-lime"
    when 3
      "w3-yellow"
    when 4
      "w3-orange"
    when 5
      "w3-deep-orange"
    else
      ""
    end
  end
end
