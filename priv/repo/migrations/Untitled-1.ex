mix phx.gen.json Driver Driver drivers \
first_name:string last_name:string email:string:unique \
password_hash:string cellphone:string address:string city:string \
country:string profile_pic:string id_photos:map driver_license:map \
date_of_birth:date years_of_experience:integer ways_of_reference:string \
email_verified:boolean active:boolean last_logged_in:utc_datetime \
certifications:{:array, :map} emergency_contact:map work_reference:{:array, :map} referred_contact:{:array, :map}  --no-context --no-schema
