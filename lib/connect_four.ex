defmodule ConnectFour do
  @url "http://connectfour.inseng.net/"
  # @url "http://httparrot.herokuapp.com/get"
  @name "gp_elixir"


  def get_games do
    %HTTPoison.Response{body: body} = HTTPoison.get!(@url <> "games")
    IO.puts body
  end

  def make_game! do
    %HTTPoison.Response{body: body} = HTTPoison.post!(@url <> "games", [])
    body = JSON.decode(body)
    {:ok, %{"id" => id}} = body
    id
  end

  def join_game(id, match: match) do
    url = "#{@url}games/#{id}/players"

    %HTTPoison.Response{body: body} = HTTPoison.post!(url, 
      {:form, [name: @name, id: id, match: match]},
      %{"Content-type" => "application/x-www-form-urlencoded"})
      {:ok, body} = JSON.decode body

    %{"players" => players} = body

    me = Enum.find(players, fn (%{"name" => name}) -> name == @name end)
    me
  end

  def main do
   make_game!
   |> join_game match: true
  end
end
