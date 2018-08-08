control "V-18010" do
  title "Unauthorized accounts must not have the Debug programs user right."
  desc  "Inappropriate granting of user rights can provide system,
  administrative, and other high-level capabilities.

  Accounts with the \"Debug programs\" user right can attach a debugger to
  any process or to the kernel, providing complete access to sensitive and
  critical operating system components.  This right is given to Administrators in
  the default configuration.
  "
  impact 0.7
  tag "gtitle": "User Right - Debug Programs"
  tag "gid": "V-18010"
  tag "rid": "SV-52115r2_rule"
  tag "stig_id": "WN12-UR-000016"
  tag "fix_id": "F-45140r1_fix"
  tag "cci": ["CCE-23648-9", "CCI-002235"]
  tag "nist": ["CCE-23648-9", "CCI-002235"]
  tag "nist": ["AC-6 (10)", "Rev_4"]
  tag "documentable": false
  tag "severity_override_guidance": "If an application requires this user
  right, this can be downgraded to a CAT III if the following conditions are met:
  Vendor documentation must support the requirement for having the user right.
  The requirement must be documented with the ISSO.
  The application account must meet requirements for application account
  passwords, such as length (V-36661) and required changes frequency (V-36662)."
    tag "check": "Verify the effective setting in Local Group Policy Editor.
  Run \"gpedit.msc\".

  Navigate to Local Computer Policy -> Computer Configuration -> Windows Settings
  -> Security Settings -> Local Policies -> User Rights Assignment.

  If any accounts or groups other than the following are granted the \"Debug
  programs\" user right, this is a finding:

  Administrators"
  tag "fix": "Configure the policy value for Computer Configuration -> Windows
  Settings -> Security Settings -> Local Policies -> User Rights Assignment ->
  \"Debug programs\" to only include the following accounts or groups:

  Administrators"
  a = ((users.where { username =~ /.*/}.uids.entries + groups.where { name =~ /.*/}.gids.entries) + (users.where { username == 'Administrators'}.uids.entries + groups.where { name == 'Administrators'}.gids.entries)).uniq
  a.each do |entry|
    describe security_policy do
      its("SeDebugPrivilege") { should_not include entry }
    end
  end
end
