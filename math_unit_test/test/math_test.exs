defmodule MathTest do
  use ExUnit.Case
  doctest MathUnitTest

  import MathUnitTest

  describe "Testing add functionality" do
    test "Add two positive numbers" do
      assert add(102, 45) == 147
    end

    test "Add a positive and a negative number" do
      assert add(4, -4) == 0
    end

    test "Add two negative numbers" do
      assert add(-6, -8) == -14
    end
  end

  describe "Testing subtract functionality" do
    test "Subtract two positive numbers to get a positive result" do
      assert subtract(20, 18) == 2
    end

    test "Subtract two positive numbers to get a zero result" do
      assert subtract(31, 31) == 0
    end

    test "Subtract two positive numbers to get a negative result" do
      assert subtract(14, 21) == -7
    end

    test "Subtract a negative from a positive number" do
      assert subtract(4, -4) == 8
    end

    test "Subtract a positive from a negative number" do
      assert subtract(-6, 8) == -14
    end

    test "Subtract two negative numbers" do
      assert subtract(-6, -8) == 2
    end

    test "Subtract a zero from a positive number" do
      assert subtract(6, 0) == 6
    end

    test "Subtract a zero from a negative number" do
      assert subtract(-3, 0) == -3
    end

    test "Subtract a zero from a zero" do
      assert subtract(0, 0) == 0
    end
  end

  describe "Testing multiply functionality" do
    test "Multiply zero with zero" do
      assert multiply(0, 0) == 0
    end

    test "Multiply 10 with 10" do
      assert multiply(10, 10) == 100
    end

    test "Multiply 7 with 2" do
      assert multiply(7, 2) == 14
    end

    test "Multiply 2 with 7" do
      assert multiply(2, 7) == 14
    end

    test "Multiply negative 2 with negative 7" do
      assert multiply(-2, -7) == 14
    end

    test "Multiply negative 2 with 7" do
      assert multiply(-2, 7) == -14
    end
  end
end
