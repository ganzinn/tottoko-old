module CreatorsHelper
  def age(creator)
    dob = creator.date_of_birth
    today = Date.today

    age_years = (today.strftime('%Y%m%d').to_i - dob.strftime('%Y%m%d').to_i)/10000.to_i
    age_months = (today.strftime('%m%d').to_i - dob.strftime('%m%d').to_i)/100.to_i
    age_months = age_months < 0 ? age_months + 12 : age_months

    return "#{age_years}歳#{age_months}ヶ月"
  end
end
