defmodule Blackjack do
  @baraja [                                                                                    #--> Creacion de la lista de Cartas #
    "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K", "A"
  ]
  @palos [:picas, :corazones, :diamantes, :treboles]                                           #---> Atom con la creacion de los palos que me da valor constante #

  def carta_valor(carta) do
      "2" => 2
      "3" => 3
      "4" => 4
      "5" => 5
      "6" => 6
      "7" => 7
      "8" => 8
      "9" => 9
      "10"=> 10
      "J" => 10
      "Q" => 10
      "K" => 10
        _ => 11
    end


  def start do
    IO.puts "¡Bienvenido al Juego de Blackjack!"
    mano_jugador = []
    mano_pc = []
    baraja = construir_baraja() |> mezclar_baraja()

    {mano_jugador, mano_pc, baraja} = repartir_cartas(mano_jugador, mano_pc, baraja)
    display_manos(mano_jugador, mano_pc)

    {mano_jugador, baraja} = turno_jugador(mano_jugador, baraja)
    {mano_pc, baraja} = turno_pc(mano_pc, baraja)

    display_final_manos(mano_jugador, mano_pc)
    display_resultado(mano_jugador, mano_pc)
  end

  def construir_baraja do
    for suit <- @palos, carta <- @baraja, do: %{carta: carta, suit: suit}
  end

  def mezclar_baraja(baraja) do
    Enum.seed(:os.timestamp())
    Enum.shuffle(baraja)
  end

  def repartir_cartas(mano_jugador, mano_pc, baraja) do
    {baraja, _} = repartir_carta(mano_jugador, baraja)
    {baraja, mano_pc} = repartir_carta(mano_pc, baraja)
    {baraja, _} = repartir_carta(mano_jugador, baraja)
    {baraja, mano_pc} = repartir_carta(mano_pc, baraja)
    {mano_jugador, mano_pc, baraja}
  end

  def repartir_carta(mano, baraja) do
    {[carta | rest], baraja} = baraja
    {[carta | mano], rest}
  end

  def display_manos(mano_jugador, mano_pc) do
    IO.puts "Tu mano: #{mano_to_string(mano_jugador)}"
    IO.puts "Carta de la Pc: #{mano_to_string([List.first(mano_pc)])}"
  end

  def mano_to_string(mano) do
    mano
    |> Enum.map(fn {carta, suit} -> "#{carta} de #{suit}" end)
    |> Enum.join(", ")
  end

  def turno_jugador(mano_jugador, baraja) do
    IO.puts "¿Quieres otra carta? (s/n)"
    case IO.gets() do
      "s\n" ->
        {baraja, mano_jugador} = repartir_carta(mano_jugador, baraja)
        IO.puts "Tu mano: #{mano_to_string(mano_jugador)}"
        if mano_valor(mano_jugador) > 21 do
          IO.puts "Te pasaste de 21. ¡Perdiste!"
          exit(:normal)
        else
          turno_jugador(mano_jugador, baraja)
        end
      _ -> {mano_jugador, baraja}
    end
  end

  def turno_pc(mano_pc, baraja) do
    if mano_valor(mano_pc) < 17 do
      {baraja, mano_pc} = repartir_carta(mano_pc, baraja)
      turno_pc(mano_pc, baraja)
    else
      {mano_pc, baraja}
    end
  end

  def display_final_manos(mano_jugador, mano_pc) do
    IO.puts "Tu mano final: #{mano_to_string(mano_jugador)}"
    IO.puts "Mano final del crupier: #{mano_to_string(mano_pc)}"
  end

  def display_resultado(mano_jugador, mano_pc) do
    jugador_valor = mano_valor(mano_jugador)
    pc_valor = mano_valor(mano_pc)

    case {jugador_valor, pc_valor} do
      {pv, dv} when pv > 21 ->
        IO.puts "Te pasaste de 21. ¡Perdiste!"
      {pv, dv} when dv > 21 ->
        IO.puts "La PC se pasó de 21. ¡Ganaste!"
      {pv, dv} when pv == dv ->
        IO.puts "Empate. Nadie gana."
      {pv, dv} when pv > dv ->
        IO.puts "¡Ganaste!"
      _ ->
        IO.puts "Perdiste. La PC ganó."
    end
  end
  def mano_valor(mano) do
    aces_count = mano
      |> Enum.count(fn {carta, _} -> carta == "A" end)
    non_aces = mano
      |> Enum.reject(fn {carta, _} -> carta == "A" end)
      |> Enum.map(fn {carta, _} -> carta_valor(carta) end)
      |> Enum.sum()

    if aces_count == 0 do
      non_aces
    else
      posible_valor_aces = for i <- 0..aces_count, do: i * 10 + (aces_count - i)
      posible_valor_aces
        |> Enum.map(fn ace_sum -> ace_sum + non_aces end)
        |> Enum.filter(fn mano_valor -> mano_valor <= 21 end)
        |> List.last()
    end
  end
end

Blackjack.start()
