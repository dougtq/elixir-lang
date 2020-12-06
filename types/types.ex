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
        IO.puts("#{name} \n #{name} é aqui " <> name)
    end
end
