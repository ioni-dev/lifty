mix phx.gen.json Driver Driver drivers \
first_name:string last_name:string email:string:unique \
password_hash:string cellphone:string address:string city:string \
country:string profile_pic:string photos_id:map driver_license:map \
date_of_birth:date years_of_experience:integer ways_of_reference:string \
email_verified:boolean active:boolean last_logged_in:utc_datetime \
certifications:{:array, :map} emergency_contact:map work_reference:{:array, :map} referred_contact:{:array, :map}  --no-context --no-schema


mix phx.gen.json Organization Organization organizations \
 email:string password_hash:string password:string confirmed_at:naive_datetime \
 name:string taxpayer_id:string country:string cellphone:string \
 montly_deliveries:integer website:string is_active:boolean address:string \

 mix phx.gen.json Client Client clients \
 email:string name:string \
 first_name:string last_name:string cellphone:string \
 birthday:date city:string country:string password:string \
 password_hash:string confirmed_at:naive_datetime delivery_destination:string


mix phx.gen.json Requests Request requests \
 status:string from_latitude:float from_longitude:float destinations:array:map

mix phx.gen.json Pickups Pickup pickups \
 status:string latitude:float longitude:float departed_at:utc_datetime_usec arrived_at:utc_datetime_usec


mix phx.gen.json Pickups Pickup pickups \
 status:string latitude:float longitude:float departed_at:utc_datetime_usec arrived_at:utc_datetime_usec

mix phx.gen.json Rides Ride rides \
 status:string destinations_status:array:map
