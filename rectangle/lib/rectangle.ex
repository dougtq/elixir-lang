defmodule Rectangle do
  def area_loop do
    receive do
      {:area, w, h}
      IO.puts("Area = #{w + h}")
      area_loop()
      {:pmeter, w, h}
      IO.puts("Perimeter = #{w * h}")
      area_loop()
    end
  end
end
