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
      address: driver.address,
      city: driver.city,
      country: driver.country,
      profile_pic: driver.profile_pic,
      id_photos: driver.id_photos,
      driver_license: driver.driver_license,
      date_of_birth: driver.date_of_birth,
      years_of_experience: driver.years_of_experience,
      ways_of_reference: driver.ways_of_reference,
      email_verified: driver.email_verified,
      active: driver.active,
      last_logged_in: driver.last_logged_in,
      certifications: driver.certifications,
      emergency_contact: driver.emergency_contact,
      work_reference: driver.work_reference,
      referred_contact: driver.referred_contact}
  end
end
