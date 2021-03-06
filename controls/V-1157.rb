# -*- encoding : utf-8 -*-
# frozen_string_literal: true

control 'V-1157' do
  title "The Smart Card removal option must be configured to Force Logoff or
  Lock Workstation."
  desc "Unattended systems are susceptible to unauthorized use and must be
  locked.  Configuring a system to lock when a smart card is removed will ensure
  the system is inaccessible when unattended."
  impact 0.5
  tag "gtitle": 'Smart Card Removal Option '
  tag "gid": 'V-1157'
  tag "rid": 'SV-52867r2_rule'
  tag "stig_id": 'WN12-SO-000027'
  tag "fix_id": 'F-45793r1_fix'
  tag "cci": ['CCI-000366']
  tag "cce": ['CCE-24154-7']
  tag "nist": ['CM-6 b', 'Rev_4']
  tag "documentable": false
  tag "check": "If the following registry value does not exist or is not
  configured as specified, this is a finding:

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\

  Value Name: SCRemoveOption

  Value Type: REG_SZ
  Value: 1 (Lock Workstation) or 2 (Force Logoff)

  If configuring this on servers causes issues such as terminating users' remote
  sessions and the site has a policy in place that any other sessions on the
  servers such as administrative console logons, are manually locked or logged
  off when unattended or not in use, this would be acceptable. This must be
  documented with the ISSO."
  tag "fix": "Configure the policy value for Computer Configuration -> Windows
  Settings -> Security Settings -> Local Policies -> Security Options ->
  \"Interactive logon: Smart card removal behavior\" to  \"Lock Workstation\" or
  \"Force Logoff\"."

  describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
    it { should have_property 'scremoveoption' }
  end
  describe.one do
    describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
      its('scremoveoption') { should cmp == 1 }
    end
    describe registry_key('HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon') do
      its('scremoveoption') { should cmp == 2 }
    end
  end
end
