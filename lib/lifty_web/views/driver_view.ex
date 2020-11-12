defmodule LiftyWeb.DriverView do
  use LiftyWeb, :view
  alias LiftyWeb.DriverView

  def render("index.json", %{drivers: drivers}) do
    %{data: render_many(drivers, DriverView, "driver.json")}
  end

  def render("show.json", %{driver: driver}) do
    %{data: render_one(driver, DriverView, "driver.json")}
  end

  def render("driver.json", %{driver: driver}) do
    %{id: driver.id,
      first_name: driver.first_name,
      last_name: driver.last_name,
      email: driver.email,
      cellphone: driver.cellphone,
      profile_pic: driver.profile_pic,
      years_of_experience: driver.years_of_experience,
      is_active: driver.is_active,
      last_logged_in: driver.last_logged_in,
      certifications: driver.certifications,
      emergency_contact: driver.emergency_contact,
  }
  end
end
