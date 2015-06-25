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

  def join_game(id) do

    # {:ok, json } = JSON.encode([name: @name, id: id])

    url = "#{@url}games/#{id}/players"


    body = HTTPoison.post!(url, {:form, [name: @name, id: id]}, %{"Content-type" => "application/x-www-form-urlencoded"})

  end


  def main do
   make_game!
   |> join_game
  end
end
