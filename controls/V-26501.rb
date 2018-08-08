control "V-26501" do
  title "Unauthorized accounts must not have the Profile system performance user right."
  desc  "
    Inappropriate granting of user rights can provide system, administrative, and other high-level capabilities.

    Accounts with the "Profile system performance" user right can monitor system processes performance.  An attacker could potentially use this to id
  "
  impact 0.5
  tag "severity": "medium"
  tag "gtitle": "UAC - Application Elevations"
  tag "gid": "V-26501"
  tag "rid": "SV-53019r1_rule"
  tag "stig_id": "WN12-SO-000081"
  tag "cci": "CCI-001084"
  tag "cce": "CCE-23880-8"
  #tag "nist": ["SC-18 (3)", "Rev_4"]
  tag "check": "Verify the effective setting in Local Group Policy Editor.
  Run "gpedit.msc".

  Navigate to Local Computer Policy -> Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> User Rights Assignment.

  If any accounts or groups other than the following are granted the "Profile system performance" user right, this is a finding:

  Administrators
  NT Service\WdiServiceHost"

  tag "fix": Configure the policy value for Computer Configuration -> Windows Settings -> Security Settings -> Local Policies -> User Rights Assignment -> "Profile system performance" to only include the following accounts or groups:

  Administrators
  NT Service\WdiServ"
  "
  a = ((users.where { username =~ /.*/}.uids.entries + groups.where { name =~ /.*/}.gids.entries) + (users.where { username == 'Administrators'}.uids.entries + groups.where { name == 'Administrators'}.gids.entries) + (users.where { username == 'NT SERVICE\WdiServiceHost'}.uids.entries + groups.where { name == 'NT SERVICE\WdiServiceHost'}.gids.entries)).uniq
  a.each do |entry|
    describe security_policy do
      its("SeSystemProfilePrivilege") { should_not include entry }
    end
  end
end  