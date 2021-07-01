defmodule FoodApp.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :color, :string
    field :description, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :description, :color])
    |> validate_required([:title, :description, :color])
  end
end
