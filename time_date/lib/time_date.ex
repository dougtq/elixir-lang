defmodule TimeDate do
  @spec today() :: { :ok, Date }
  def today do
    { :ok, Date.utc_today() }
  end

  def now do
    { :ok, Time.utc_now() }
  end

  @spec get_recent_date(Date, Date) :: Date
  def get_recent_date(date_x, date_y) do
    case date_x > date_y do
      true -> date_x
      false -> date_y
    end
  end

  @spec get_recent_time(Time, Time) :: Time
  def get_recent_time(time_x, time_y) do
    case Time.compare(time_x, time_y) do
      :lt -> time_y
      :gt -> time_x
      :eq -> time_x
    end
  end

  @spec dates_to_range(Date, Date) :: Range
  def dates_to_range(initial_date, final_date) do
    Date.range(initial_date, final_date)
  end

  @spec date_range_to_list(Range) :: List
  def date_range_to_list(range) do
    Enum.to_list(range)
  end
end
