# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lifty.Repo.insert!(%Lifty.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias LiftyWeb.Repo
alias Lifty.Drivers.Driver.ReferredContact
alias Lifty.Organizations.Organization

# Organizations
{:ok, _organization} = Lifty.Organizations.create_organization(%{
  address: "fake address organization",
  cellphone: "555555555",
  confirmed_at: "2020-01-01 00:00:00",
  country: "Uruguay",
  email: "organization1@test.com",
  is_active: true,
  montly_deliveries: 20,
  name: "Sabelina",
  password: "sabelina",
  taxpayer_id: "12345",
  website: "sabelina.com"
})

last_record = Lifty.Repo.get_by(Organization, email: "organization1@test.com")
IO.puts last_record.id
{:ok, _driver} = Lifty.Drivers.create_driver(%{
  email: "test1@test.com",
  password: "qweqweqwe",
  first_name: "Driver uno",
  last_name: "thon",
  cellphone: "656566556656",
  address: "av. siempre viva 123",
  city: "Montevideo",
  country: "Uruguay",
  profile_pic: "www.test.com",
  date_of_birth: ~D[2028-10-21],
  years_of_experience: 5,
  ways_of_reference: "Instagram",
  permissions: %{default: ["read_drivers", "write_drivers"]},
  referred_contact: [
    %{
      :full_name => "Nombre de prueba 1",
      :email => "referred1@test.com",
      :phone => "4421170",
      :relation => "cousin",
      :role => "Operario",
      :note => "It's all good man"
    }],
    work_reference: [
      %{
        :full_name => "Nombre de prueba 1",
        :phone => "4421170",
        :relation => "cousin",
        :note => "It's all good man"
      }],
      emergency_contact: %{
        :full_name => "emergency 1",
        :relationship => "wife",
        :phone => "111111",
        :email => "emergency@test.com",
        :address => "av. siempre viva"
      },
      certifications: [
        %{
          :title => "certificado 1",
          :path => "efece.aws"
        }],
      driver_license: %{
        :front_path => "dddd.aws",
        :back_path => "sdsds.aws",
      },
      photos_id: %{
        :front_path => "dsdd.aws",
        :back_path => "aaaa.aws",
      },
      organization_id: last_record.id
})

# {:ok, _driver} = Lifty.Drivers.create_driver(%{
#   email: "test2@test.com",
#   password: "qweqweqwe",
#   permissions: %{default: [:read_drivers]},
#   referred_contact: [%{
#     :full_name => "Nombre de prueba 2",
#     :email => "referred2@test.com",
#     :phone => "4421170",
#     :relation => "cousin",
#     :role => "Operario",
#     :note => "It's all good man"}]
# })

# {:ok, _driver} = Lifty.Drivers.create_driver(%{
#   email: "test3@test.com",
#   password: "qweqweqwe",
#   permissions: %{default: []},
#   referred_contact: [%{
#     :full_name => "Nombre de prueba 3",
#     :email => "referred3@test.com",
#     :phone => "4421170",
#     :relation => "cousin",
#     :role => "Operario",
#     :note => "It's all good man"}]
# })




# Client

# {:ok, _client} = Lifty.Clients.create_client(%{
#   birthday: ~D[2028-10-21],
#   cellphone: "1111111",
#   city: "Montevideo",
#   confirmed_at: "2020-01-01 00:00:00",
#   country: "Uruguay",
#   delivery_destination: "av. blabla",
#   email: "client1@test.com",
#   first_name: "Haru",
#   last_name: "aa",
#   name: "Haru",
#   password: "123456789"
# })
