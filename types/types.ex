defmodule Types do
    def integer do
        1 + 1
    end

    def float do
        1.3 + 0.5
    end
    def bin do
        0b1010
    end
    def hex do
        0xFF
    end
    def oc do
        0o755
    end
    def bool do
        false == true
    end
    def atom do
        :atom
    end
    def string do
        name = "Texto"
        char = String.to_charlist("Douglas")
        IO.puts("#{name} \n #{name} é aqui " <> name)
    end
    def list do
        a = ["Texto", 1, 5]
        b = [2, 4, :true]
        c = ["Texto"]

        d = a ++ b
        e = d -- c

        [head] = e

        head
    end
    def tuples do
        { "jack", 2, :jack, [1]}
    end
end
