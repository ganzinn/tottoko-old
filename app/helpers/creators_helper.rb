module CreatorsHelper
  def age(creator, start_day = Time.zone.today)
    dob = creator.date_of_birth

    age_years = (start_day.strftime('%Y%m%d').to_i - dob.strftime('%Y%m%d').to_i) / 10_000.to_i
    age_months = (start_day.strftime('%m%d').to_i - dob.strftime('%m%d').to_i) / 100.to_i
    age_months += 12 if age_months.negative?

    "#{age_years}歳#{age_months}ヶ月"
  end
end
