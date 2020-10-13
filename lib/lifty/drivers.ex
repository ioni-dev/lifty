defmodule Lifty.Drivers do
  @moduledoc """
  The Drivers context.
  """

  import Ecto.Query, warn: false
  alias Lifty.Repo
  alias Lifty.Drivers.{Driver}

  ## Database getters

  @doc """
  Gets a driver by email.
  ## Examples
      iex> get_driver_by_email("foo@example.com")
      %driver{}
      iex> get_driver_by_email("unknown@example.com")
      nil
  """
  # def get_driver_by_email(email) when is_binary(email) do
  #   Repo.get_by(driver, email: email)
  # end

  @doc """
  Gets a driver by email and password.
  ## Examples
      iex> get_driver_by_email_and_password("foo@example.com", "correct_password")
      %driver{}
      iex> get_driver_by_email_and_password("foo@example.com", "invalid_password")
      nil
  """
  # def get_driver_by_email_and_password(email, password)
  #     when is_binary(email) and is_binary(password) do
  #   driver = Repo.get_by(driver, email: email)
  #   if driver.valid_password?(driver, password), do: driver
  # end

  @doc """
  Gets a single driver.
  Raises `Ecto.NoResultsError` if the driver does not exist.
  ## Examples
      iex> get_driver!(123)
      %driver{}
      iex> get_driver!(456)
      ** (Ecto.NoResultsError)
  """
  # def get_driver!(id), do: Repo.get!(driver, id)

  ## driver registration

  @doc """
  Registers a driver.
  ## Examples
      iex> register_driver(%{field: value})
      {:ok, %driver{}}
      iex> register_driver(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_driver(attrs) do
    %Driver{}
    |> Driver.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking driver changes.
  ## Examples
      iex> change_driver_registration(driver)
      %Ecto.Changeset{data: %driver{}}
  """
  def change_driver_registration(%driver{} = driver, attrs \\ %{}) do
    Driver.registration_changeset(driver, attrs)
  end

  ## Settings

  @doc """
  Returns an `%Ecto.Changeset{}` for changing the driver email.
  ## Examples
      iex> change_driver_email(driver)
      %Ecto.Changeset{data: %driver{}}
  """
  def change_driver_email(driver, attrs \\ %{}) do
    Driver.email_changeset(driver, attrs)
  end

  @doc """
  Emulates that the email will change without actually changing
  it in the database.
  ## Examples
      iex> apply_driver_email(driver, "valid password", %{email: ...})
      {:ok, %driver{}}
      iex> apply_driver_email(driver, "invalid password", %{email: ...})
      {:error, %Ecto.Changeset{}}
  """
  def apply_driver_email(driver, password, attrs) do
    driver
    |> Driver.email_changeset(attrs)
    # |> Driver.validate_current_password(password)
    |> Ecto.Changeset.apply_action(:update)
  end

  @doc """
  Updates the driver email using the given token.
  If the token matches, the driver email is updated and the token is deleted.
  The confirmed_at date is also updated to the current time.
  """
  # def update_driver_email(driver, token) do
  #   context = "change:#{driver.email}"

  #   with {:ok, query} <- driverToken.verify_change_email_token_query(token, context),
  #        %driverToken{sent_to: email} <- Repo.one(query),
  #        {:ok, _} <- Repo.transaction(driver_email_multi(driver, email, context)) do
  #     :ok
  #   else
  #     _ -> :error
  #   end
  # end

  # defp driver_email_multi(driver, email, context) do
  #   changeset = driver |> driver.email_changeset(%{email: email}) |> driver.confirm_changeset()

  #   Ecto.Multi.new()
  #   |> Ecto.Multi.update(:driver, changeset)
  #   |> Ecto.Multi.delete_all(:tokens, driverToken.driver_and_contexts_query(driver, [context]))
  # end

  @doc """
  Delivers the update email instructions to the given driver.
  ## Examples
      iex> deliver_update_email_instructions(driver, current_email, &Routes.driver_update_email_url(conn, :edit, &1))
      {:ok, %{to: ..., body: ...}}
  """
  # def deliver_update_email_instructions(%driver{} = driver, current_email, update_email_url_fun)
  #     when is_function(update_email_url_fun, 1) do
  #   {encoded_token, driver_token} = driverToken.build_email_token(driver, "change:#{current_email}")

  #   Repo.insert!(driver_token)
  #   driverNotifier.deliver_update_email_instructions(driver, update_email_url_fun.(encoded_token))
  # end

end
