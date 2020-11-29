defmodule Lifty.Drivers do
  @moduledoc """
  The Drivers context.
  """

  import Ecto.Query, warn: false
  alias Lifty.Repo

  alias Lifty.Drivers.Driver

  @doc """
  Returns the list of driver.

  ## Examples

      iex> list_drivers()
      [%User{}, ...]

  """
  def list_drivers(id) do
    # Fetch all post titles
    query = from d in Driver,
    where: d.organization_id == ^id
    Repo.all(query)
  end

  @doc """
  Gets a single driver.

  Raises `Ecto.NoResultsError` if the Driver does not exist.

  ## Examples

      iex> get_driver!(123)
      %Driver{}

      iex> get_Driver!(456)
      ** (Ecto.NoResultsError)

  """
  def get_driver!(id), do: Repo.get!(Driver, id)

  @doc """
  Creates a Driver.

  ## Examples

      iex> create_driver(%{field: value})
      {:ok, %Driver{}}

      iex> create_driver(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_driver(attrs \\ %{}) do
    %Driver{}
    |> Driver.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, driver} -> {:ok, driver}
      {:error, changeset} -> {:error, changeset}
    end
  end

  @doc """
  Updates a driver.

  ## Examples

      iex> update_driver(driver, %{field: new_value})
      {:ok, %Driver{}}

      iex> update_driver(driver, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_driver(%Driver{} = driver, attrs) do
    driver
    |> Driver.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Driver.

  ## Examples

      iex> delete_driver(driver)
      {:ok, %Driver{}}

      iex> delete_driver(driver)
      {:error, %Ecto.Changeset{}}

  """
  def delete_driver(%Driver{} = driver) do
    Repo.delete(driver)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking driver changes.

  ## Examples

      iex> change_driver(driver)
      %Ecto.Changeset{source: %Driver{}}

  """
  def change_driver(%Driver{} = driver) do
    Driver.changeset(driver, %{})
  end

  @spec get_driver_by_email_and_password(String.t, String.t) :: {:ok, Driver.t} | {:error, atom}
  def get_driver_by_email_and_password(nil, password), do: {:error, :invalid}
  def get_driver_by_email_and_password(email, nil), do: {:error, :invalid}

  def get_driver_by_email_and_password(email, password) do
    with  %Driver{} = driver <- Repo.get_by(Driver, email: String.downcase(email)),
          true <- Argon2.verify_pass(password, driver.password_hash) do
      {:ok, driver}
    else
      _ ->
        # Help to mitigate timing attacks
        Argon2.no_user_verify()
        {:error, :unauthorized}
    end
  end
end
