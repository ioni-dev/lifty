defmodule Lifty.Pickups do
  @moduledoc """
  The Pickups context.
  """

  import Ecto.Query, warn: false
  alias Lifty.Repo

  alias Lifty.Pickups.Pickup

  @doc """
  Returns the list of pickups.

  ## Examples

      iex> list_pickups()
      [%Pickup{}, ...]

  """
  def list_pickups do
    Repo.all(Pickup)
  end

  @doc """
  Gets a single pickup.

  Raises `Ecto.NoResultsError` if the Pickup does not exist.

  ## Examples

      iex> get_pickup!(123)
      %Pickup{}

      iex> get_pickup!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pickup!(id), do: Repo.get!(Pickup, id)

  @doc """
  Creates a pickup.

  ## Examples

      iex> create_pickup(%{field: value})
      {:ok, %Pickup{}}

      iex> create_pickup(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pickup(attrs \\ %{}) do
    %Pickup{}
    |> Pickup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pickup.

  ## Examples

      iex> update_pickup(pickup, %{field: new_value})
      {:ok, %Pickup{}}

      iex> update_pickup(pickup, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pickup(%Pickup{} = pickup, attrs) do
    pickup
    |> Pickup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pickup.

  ## Examples

      iex> delete_pickup(pickup)
      {:ok, %Pickup{}}

      iex> delete_pickup(pickup)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pickup(%Pickup{} = pickup) do
    Repo.delete(pickup)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pickup changes.

  ## Examples

      iex> change_pickup(pickup)
      %Ecto.Changeset{data: %Pickup{}}

  """
  def change_pickup(%Pickup{} = pickup, attrs \\ %{}) do
    Pickup.changeset(pickup, attrs)
  end
end
