control "V-39332" do
  title "The Active Directory Domain Controllers Organizational Unit (OU)
object must have the proper access control permissions."
  desc  "When Active Directory (AD) objects do not have appropriate access
control permissions, it may be possible for malicious users to create, read,
update, or delete the objects and degrade or destroy the integrity of the data.
 When the directory service is used for identification, authentication, or
authorization functions, a compromise of the database objects could lead to a
compromise of all systems that rely on the directory service.

    The Domain Controllers OU object requires special attention as the Domain
Controllers are central to the configuration and management of the domain.
Inappropriate access permissions defined for the Domain Controllers OU could
allow an intruder or unauthorized personnel to make changes which could lead to
the compromise of the domain.
  "
  impact 0.7
  tag severity: nil
  tag gtitle: "WINAD-000004-DC"
  tag gid: "V-39332"
  tag rid: "SV-51178r4_rule"
  tag stig_id: "WN12-AD-000004-DC"
  tag fix_id: "F-82941r1_fix"
  tag cci: ["CCI-002235"]
  tag nist: ["AC-6 (10)", "Rev_4"]
  tag false_negatives: nil
  tag false_positives: nil
  tag documentable: false
  tag mitigations: nil
  tag severity_override_guidance: false
  tag potential_impacts: nil
  tag third_party_tools: nil
  tag mitigation_controls: nil
  tag responsibility: nil
  tag ia_controls: nil
  tag check: "Verify the permissions on the Domain Controllers OU.

Open \"Active Directory Users and Computers\". (Available from various menus or
run \"dsa.msc\".)

Select Advanced Features in the View menu if not previously selected.

Navigate to the Domain Controllers OU (folder in folder icon).

Right click the OU and select Properties.

Select the Security tab.

If the permissions on the Domain Controllers OU do not restrict changes to
System, Domain Admins, Enterprise Admins and Administrators, this is a finding.
\t
The default permissions listed below satisfy this requirement.

Domains supporting Microsoft Exchange will have additional Exchange related
permissions on the Domain Controllers OU.  These may include some change
related permissions and are not a finding.

The permissions shown are at the summary level. More detailed permissions can
be viewed by selecting the Advanced button, selecting the desired Permission
entry, and the Edit button.

SELF - Special permissions

Authenticated Users - Read, Special permissions
The Special permissions for Authenticated Users are Read types. If detailed
permissions include any Create, Delete, Modify, or Write Permissions or
Properties, this is a finding.

SYSTEM - Full Control

Domain Admins - Read, Write, Create all child objects, Generate resultant set
of policy (logging), Generate resultant set of policy (planning), Special
permissions

Enterprise Admins - Full Control

Administrators - Read, Write, Create all child objects, Generate resultant set
of policy (logging), Generate resultant set of policy (planning), Special
permissions

Pre-Windows 2000 Compatible Access - Special permissions
The Special permissions for Pre-Windows 2000 Compatible Access are Read types.
If detailed permissions include any Create, Delete, Modify, or Write
Permissions or Properties, this is a finding.

ENTERPRISE DOMAIN CONTROLLERS - Read, Special permissions"
  tag fix: "Limit the permissions on the Domain Controllers OU to restrict
changes to System, Domain Admins, Enterprise Admins and Administrators.

The default permissions listed below satisfy this requirement.

Domains supporting Microsoft Exchange will have additional Exchange related
permissions on the Domain Controllers OU.  These may include some change
related permissions.

SELF - Special permissions

Authenticated Users - Read, Special permissions
The Special permissions for Authenticated Users are Read types. If detailed
permissions include any Create, Delete, Modify, or Write Permissions or
Properties, this is a finding.

SYSTEM - Full Control

Domain Admins - Read, Write, Create all child objects, Generate resultant set
of policy (logging), Generate resultant set of policy (planning), Special
permissions

Enterprise Admins - Full Control

Administrators - Read, Write, Create all child objects, Generate resultant set
of policy (logging), Generate resultant set of policy (planning), Special
permissions

Pre-Windows 2000 Compatible Access - Special permissions
The Special permissions for Pre-Windows 2000 Compatible Access are Read types.
If detailed permissions include any Create, Delete, Modify, or Write
Permissions or Properties, this is a finding.

ENTERPRISE DOMAIN CONTROLLERS - Read, Special permissions"
end
