control "V-26481" do
  title "Unauthorized accounts must not have the Create permanent shared
  objects user right."
  desc  "Inappropriate granting of user rights can provide system,
  administrative, and other high-level capabilities.

  Accounts with the \"Create permanent shared objects\" user right could
  expose sensitive data by creating shared objects.
  "
  impact 0.5
  tag "gtitle": "Create permanent shared objects"
  tag "gid": "V-26481"
  tag "rid": "SV-53059r1_rule"
  tag "stig_id": "WN12-UR-000014"
  tag "fix_id": "F-45985r1_fix"
  tag "cci": ["CCE-23723-0", "CCI-002235"]
  tag "nist": ["CCE-23723-0", "CCI-002235"]
  tag "nist": ["AC-6 (10)", "Rev_4"]
  tag "documentable": false
  tag "check": "Verify the effective setting in Local Group Policy Editor.
  Run \"gpedit.msc\".

  Navigate to Local Computer Policy -> Computer Configuration -> Windows Settings
  -> Security Settings -> Local Policies -> User Rights Assignment.

  If any accounts or groups are granted the \"Create permanent shared objects\"
  user right, this is a finding."
  tag "fix": "Configure the policy value for Computer Configuration -> Windows
  Settings -> Security Settings -> Local Policies -> User Rights Assignment ->
  \"Create permanent shared objects\" to be defined but containing no entries
  (blank)."
  (users.where { username =~ /.*/}.uids.entries + groups.where { name =~ /.*/}.gids.entries).each do |entry|
    describe security_policy do
      its("SeCreatePermanentPrivilege") { should_not include entry }
    end
  end
end
