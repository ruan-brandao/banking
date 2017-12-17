module AccountsHelper
  def formatted_currency(value)
    ActiveSupport::NumberHelper.number_to_currency(
      value/100.0,
      unit: 'R$',
      separator: ',',
      delimiter: '.',
      format: "%u %n"
    )
  end
end
