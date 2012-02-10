require 'yaml'

USER_HASH = YAML.load_file(File.dirname(__FILE__) + "/test_users.yml")
CLAIMS_HASH = YAML.load_file(File.dirname(__FILE__) + "/test_claims.yml")

def retrive_claim(claim_number)
  claim = CLAIMS_HASH[claim_number]
  fail "#{claim_number} does not exist in support/test_claims.yml" unless claim
  claim
end

def retrieve_user_id(user_type)
  type = USER_HASH[:user_types][user_type]
  type = USER_HASH[:user_types][user_type.downcase] unless type
  fail "#{user_type} does not exist in support/test_users.yml" unless type
  type
end

def retrieve_user(user_id)
  user = USER_HASH[:users][user_id]
  user = USER_HASH[:users][user_id.downcase] unless user # In case the user name is case sensitive
  fail "#{user_id} does not exist in support/test_users.yml" unless user
  user
end

def retrieve_user_password(user)
  user[:password]
end

def retrieve_user_household(user)
  user[:household]
end

def retrieve_user_billing_account(user)
  user[:billing_account]
end

def retrieve_user_first_name(user)
  user[:first_name]
end

def retrieve_user_last_name(user)
  user[:last_name]
end

def retrieve_user_zip_code(user)
  user[:zip_code]
end

def retrieve_user_d_o_b(user)
  user[:d_o_b]
end

def retrieve_user_SSN(user)
  user[:SSN]
end

def retrieve_user_password_hint(user)
  user[:password_hint]
end

def retrieve_user_email(user)
  user[:email]
end

def retrieve_user_answer(user)
  user[:answer]
end

def get_household_number(user_id)
  {
      "arizona4" => "896068991", # hh 14248321
      "nwcommline" => "800141022",
      "boatHolmes1" => "9551195",
      "alliedpersonal" => "5294179"

  }[user_id]
end