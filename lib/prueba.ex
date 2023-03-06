defmodule Blackjack do
  @baraja [                                                                                    #--> Creacion de la lista de Cartas #
    "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"
  ]
  @palos [:picas, :corazones, :diamantes, :treboles]                                           #---> Atom con la creacion de los palos que me da valor constante #

  def carta_valor(carta) do                                                                     #---> Fucion para dar valor a las cartas, adicional a esto la que no este en ese rango de 2 a 10 puede ser asociada a un As#    case carta do
      "2" -> 2
      "3" -> 3
      "4" -> 4
      "5" -> 5
      "6" -> 6
      "7" -> 7
      "8" -> 8
      "9" -> 9
      "10" -> 10
      "J" -> 10
      "Q" -> 10
      "K" -> 10
      _ -> 11
    end
  end
  Blackjack.start

 # def start do
    #IO.puts "¡Bienvenido al Juego de Blackjack!"
    #mano_jugador = []
    #mano_pc = []
    #baraja = construir_baraja() |> mezclar_baraja()

   # {mano_jugador, mano_pc, baraja} = repartir_cartas(mano_jugador, mano_pc, baraja)
  #  display_manos(mano_jugador, mano_pc)

 #   {mano_jugador, baraja} = turno_jugador(mano_jugador, baraja)
#    {mano_pc, baraja} = turno_pc(mano_pc, baraja)

 #   display_final_manos(mano_jugador, mano_pc)
#    display_resultado(mano_jugador, mano_pc)
#  end
