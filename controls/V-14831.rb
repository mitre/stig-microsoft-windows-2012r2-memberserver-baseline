control "V-14831" do
  title "The directory service must be configured to terminate LDAP-based
network connections to the directory server after five (5) minutes of
inactivity."
  desc  "The failure to terminate inactive network connections increases the
risk of a successful attack on the directory server.  The longer an established
session is in progress, the more time an attacker has to hijack the session,
implement a means to passively intercept data, or compromise any protections on
client access.  For example, if an attacker gains control of a client computer,
an existing (already authenticated) session with the directory server could
allow access to the directory.  The lack of confidentiality protection in
LDAP-based sessions increases exposure to this vulnerability."
  impact 0.3
  tag 'severity': nil
  tag 'gtitle': 'nactive Server Connections'
  tag 'gid': 'V-14831'
  tag 'rid': 'SV-51188r2_rule'
  tag 'stig_id': 'WN12-AD-000014-DC'
  tag 'fix_id': 'F-44345r1_fix'
  tag 'cci': ["CCI-001133"]
  tag 'nist': ["SC-10", "Rev_4"]
  tag 'false_negatives': nil
  tag 'false_positives': nil
  tag 'documentable': false
  tag 'mitigations': nil
  tag 'severity_override_guidance': false
  tag 'potential_impacts': nil
  tag 'third_party_tools': nil
  tag 'mitigation_controls': nil
  tag 'responsibility': nil
  tag 'ia_controls': nil
  tag 'check': "Verify the value for MaxConnIdleTime.

Open an elevated command prompt.
Enter \"ntdsutil\".
At the \"ntdsutil:\" prompt, enter \"LDAP policies\".
At the \"ldap policy:\" prompt, enter \"connections\".
At the \"server connections:\" prompt, enter \"connect to server [host-name]\".
(Where [host-name] is the computer name of the domain controller.)
At the \"server connections:\" prompt, enter \"q\".
At the \"ldap policy:\" prompt, enter \"show values\".

If the value for MaxConnIdleTime is greater than 300 (the value for five
minutes) or it is not specified, this is a finding.

Enter \"q\" at the \"ldap policy:\" and \"ntdsutil:\" prompts to exit.


Alternately, Dsquery can be used to display MaxConnIdleTime:

Open an elevated command prompt.
Enter the following command (on a single line).
dsquery * \"cn=Default Query Policy,cn=Query-Policies,cn=Directory Service,
cn=Windows NT,cn=Services,cn=Configuration,dc=[forest-name]\" -attr
LDAPAdminLimits
The quotes are required and dc=[forest-name] is the fully qualified LDAP name
of the domain being reviewed (e.g., dc=disaost,dc=mil)."
  tag 'fix': "Configure the directory service to terminate LDAP-based network
connections to the directory server after five (5) minutes of inactivity.

Open an elevated command prompt.
Enter \"ntdsutil\".
At the \"ntdsutil:\" prompt, enter \"LDAP policies\".
At the \"ldap policy:\" prompt, enter \"connections\".
At the \"server connections:\" prompt, enter \"connect to server [host-name]\".
(Where [host-name] is the computer name of the domain controller.)
At the \"server connections:\" prompt, enter \"q\".
At the \"ldap policy:\" prompt, enter \"Set MaxConnIdleTime to 300\".
Enter \"Commit Changes\" to save.
Enter \"Show values\" to verify changes.
Enter \"q\" at the \"ldap policy:\" and \"ntdsutil:\" prompts to exit."

domain_role = command('wmic computersystem get domainrole | Findstr /v DomainRole').stdout.strip
 if domain_role == '4' || domain_role == '5'
  distinguishedName = json(command: '(Get-ADDomain).DistinguishedName | ConvertTo-Json').params
    query = command("dsquery * 'cn=Default Query Policy,cn=Query-Policies,cn=Directory Service,cn=Windows NT,cn=Services,cn=Configuration,#{distinguishedName}' -attr LDAPAdminLimits").stdout
    ldap_admin_limits = parse_config(query.gsub(/;/, "\n")).params
     describe "MaxConnIdleTime is configured" do
      subject { ldap_admin_limits }
       it { should include 'MaxConnIdleTime' }
     end
     describe "The MaxConnIdleTime" do
      subject { ldap_admin_limits['MaxConnIdleTime'] }
       it { should cmp <= 300 }
     end
 else
    impact 0.0
    desc 'This system is not a domain controller, therefore this control is not applicable as it only applies to domain controllers'
     describe 'This system is not a domain controller, therefore this control is not applicable as it only applies to domain controllers' do
      skip 'This system is not a domain controller, therefore this control is not applicable as it only applies to domain controllers'
     end
 end
end
 