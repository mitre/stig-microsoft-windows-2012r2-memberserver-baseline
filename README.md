# microsoft-windows-2012r2-memberserver-stig-baseline
InSpec profile to validate the secure configuration of Microsoft Windows 2012 R2 Member Server, against [DISA](https://iase.disa.mil/stigs/)'s Microsoft Windows Server 2012/2012 R2 Member Server Security Technical Implementation Guide (STIG) Version 2, Release 17.

## Getting Started

It is intended and recommended that InSpec run this profile from a __"runner"__ host (such as a DevOps orchestration server, an administrative management system, or a developer's workstation/laptop) against the target remotely over __winrm__.

__For the best security of the runner, always install on the runner the _latest version_ of InSpec and supporting Ruby language components.__

The latest versions and installation options are available at the [InSpec](http://inspec.io/) site.

## Tailoring to Your Environment
The following inputs must be configured in an inputs ".yml" file for the profile to run correctly for your specific environment. More information about InSpec inputs can be found in the [InSpec Profile Documentation](https://www.inspec.io/docs/reference/profiles/).

```
- set to either the string "true" or "false"
sensitive_system: false

- set to your Domain SID as a string in the form `xxxxxxxxxx-xxxxxxx-xxxxxxxxxx`
domain_sid: (NULL)

- add your usernames as needed
backup_operators: (NULL)

- add your usernames as needed
administrators: (NULL)

- add your usernames as needed
hyper_v_admin: (NULL)

- add your AV Software Product to this list
av_approved_software: <List of AV Software>

- add your usernames as needed
shared_accounts: (NULL)

- add your usernames as needed
local_administrator: (NULL)

- add your usernames as needed
temp_accounts_domain: (NULL)

- add your usernames as needed
temp_accounts_local: (NULL)

- add your usernames as needed
emergency_accounts_domain: (NULL)

- add your usernames as needed
emergency_accounts_local: (NULL)

- add your usernames as needed
application_accounts_domain: (NULL)

- add your usernames as needed
application_accounts_local: (NULL)

- add your usernames as needed
excluded_accounts_domain: (NULL)

- Need to allow for Control V-3487 to pass
application_services: (NULL)
```
# Running This Baseline Directly from Github

```
# How to run
inspec exec https://github.com/mitre/microsoft-windows-2012r2-memberserver-stig-baseline/archive/master.tar.gz --target winrm://<hostip> --user '<admin-account>' --password=<password> --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

### Different Run Options

  [Full exec options](https://docs.chef.io/inspec/cli/#options-3)

## Running This Baseline from a local Archive copy 

If your runner is not always expected to have direct access to GitHub, use the following steps to create an archive bundle of this baseline and all of its dependent tests:

(Git is required to clone the InSpec profile using the instructions below. Git can be downloaded from the [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) site.)

When the __"runner"__ host uses this profile baseline for the first time, follow these steps: 

```
mkdir profiles
cd profiles
git clone https://github.com/mitre/microsoft-windows-2012r2-memberserver-stig-baseline
inspec archive microsoft-windows-2012r2-memberserver-stig-baseline
inspec exec <name of generated archive> --target winrm://<hostip> --user '<admin-account>' --password=<password> --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```
For every successive run, follow these steps to always have the latest version of this baseline:

```
cd microsoft-windows-2012r2-memberserver-stig-baseline
git pull
cd ..
inspec archive microsoft-windows-2012r2-memberserver-stig-baseline --overwrite
inspec exec <name of generated archive> --target winrm://<hostip> --user '<admin-account>' --password=<password> --input-file=<path_to_your_inputs_file/name_of_your_inputs_file.yml> --reporter=cli json:<path_to_your_output_file/name_of_your_output_file.json>
```

## Using Heimdall for Viewing the JSON Results

The JSON results output file can be loaded into __[heimdall-lite](https://heimdall-lite.mitre.org/)__ for a user-interactive, graphical view of the InSpec results. 

The JSON InSpec results file may also be loaded into a __[full heimdall server](https://github.com/mitre/heimdall)__, allowing for additional functionality such as to store and compare multiple profile runs.

## Authors
* Aaron Lippold, Mitre - [aaronlippold](https://github.com/aaronlippold)
* Jared Burns, VMware.Inc - [burnsjared0415](https://github.com/burnsjared0415)

## Special Thanks
* Shivani Karikar, DIFZ - [karikarshivani](https://github.com/karikarshivani)

## Contributing and Getting Help

To report a bug or feature request, please open an [issue](https://github.com/mitre/microsoft-windows-2012r2-memberserver-stig-baseline/issues/new).


## Background design of the profile

+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|             Input Name            |               Value               |                                     Description                                     | Required | Allowed Values |   Type  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|        av_approved_software       |         Windows Defender,         |                             This is a list of Approved                              |     X    |     String     |  Array  |
|                                   | Mcafee Host Intrusion Prevention, |                                 Anti-Virus Software                                 |          |                |         |
|                                   |     Mcafee Endpoint Security,     |                                                                                     |          |                |         |
|                                   |            Mcafee Agent           |                                                                                     |          |                |         |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|          shared_accounts          |                NULL               |                        List of shared accounts on the system                        |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|          backup_operators         |                NULL               |                           List of authorized users in the                           |     X    |     String     |  Array  |
|                                   |                                   |                                Backup Operators Group                               |          |                |         |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|           administrators          |                NULL               |                           List of authorized users in the                           |     X    |     String     |  Array  |
|                                   |                                   |                              local Administrators group                             |          |                |         |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|        local_administrator        |                NULL               |                             Local Administrator Account                             |     X    |     String     |  String |
|                                   |                                   |                                  on Windows Server                                  |          |                |         |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|       administrators_domain       |                NULL               |                           List of authorized users in the                           |     X    |     String     |  Array  |
|                                   |                                   |                          local Administrators domain group                          |          |                |         |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|        temp_accounts_domain       |                NULL               |                       List of temporary accounts on the domain                      |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|        temp_accounts_local        |                NULL               |                      List of temporary accounts on local system                     |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|     emergency_accounts_domain     |                NULL               |                       List of emergency accounts on the domain                      |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|      emergency_accounts_local     |                NULL               |                       List of emergency accounts on the system                      |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|    application_accounts_domain    |                NULL               |                     List Application or Service Accounts domain                     |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|     application_accounts_local    |                NULL               |                           List Application Local Accounts                           |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|      excluded_accounts_domain     |                NULL               |                            List Excluded Accounts domain                            |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|            min_pass_len           |                 14                |                      Sets the minimum length of passwords [14]                      |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|       enable_pass_complexity      |                 1                 |               If windows should enforce password complexity (0/1) [1]               |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|            min_pass_age           |                 1                 |                       Sets the minimum age for a password [1]                       |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|            max_pass_age           |                 60                |                       Sets the maximum age for a password [60]                      |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|       comp_acct_max_pass_age      |                 30                |                       Sets the maximum age for a password [30]                      |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|           pass_lock_time          |                 15                |              Sets the number of min before a session is locked out [15]             |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|           pass_hist_size          |                 24                |             Number of passwords remembered in the password history [24]             |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|          max_pass_lockout         |                 3                 | Account lockout threshold is recommended to be 3 or less invalid logon attempts [3] |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|        pass_expiry_warning        |                 14                |      Users must be warned in advance of their passwords expiring[14] or greater     |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|         pass_lock_duration        |                 15                |        Account lockout duration must be configured to [15] minutes or greater       |     X    |   Any Integer  | Numeric |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|          LegalNoticeText          |          see 'inspec.yml'         |                     The default full banner text for the system                     |     X    |     String     |  String |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|         LegalNoticeCaption        |          see 'inspec.yml'         |                     The default short banner text for the system                    |     X    |     String     |  String |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|          reg_winreg_perms         |          see 'inspec.yml'         |                    This is the values of the winreg registry key                    |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|       dod_root_certificates       |          see 'inspec.yml'         |                           List of DoD CA Root Certificates                          |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
| dod_interoperability_certificates |          see 'inspec.yml'         |                     List of DoD InterOperability CA Certificates                    |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|       dod_cceb_certificates       |          see 'inspec.yml'         |                              List of CCEB Certificates                              |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|          sensitive_system         |               False               |                  Set flag to true if the target system is sensitive                 |     X    |     String     |  String |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|       reg_install_comp_perms      |          see 'inspec.yml'         |             This is the values of the Installed Components registry key             |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|   reg_wow6432_install_comp_perms  |          see 'inspec.yml'         |     This is the values of the Installed Components under WoW643Node registry ke     |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|   winevt_logs_application_perms   |          see 'inspec.yml'         |            This is the values of the Application.evtx file under system32           |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|     winevt_logs_security_perms    |          see 'inspec.yml'         |             This is the values of the Security.evtx file under system32             |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|      winevt_logs_system_perms     |          see 'inspec.yml'         |              This is the values of the System.evtx file under system32              |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|           eventvwr_perms          |          see 'inspec.yml'         |              This is the values of the Eventvwr.exe file under system32             |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|       basic_window_services       |          see 'inspec.yml'         |              This is list of Windows Services That are Installed on OS              |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|       vmware_window_services      |          see 'inspec.yml'         |               This is list of VMware Services That are Installed on OS              |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|        application_services       |                NULL               |                   This is a list of Services that are Application                   |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+
|         reg_winlogon_perms        |          see 'inspec.yml'         |                   This is the values of the Winlogon Registry Key                   |     X    |     String     |  Array  |
+-----------------------------------+-----------------------------------+-------------------------------------------------------------------------------------+----------+----------------+---------+


### Domain Controller Controls are include in this Profile
    
    There are 7 Controls that Require the Profile be ran against a Domain controller. These Controls check for User Accounts that are on the domain and require restrictions. List below are these controls:

    - V-1112 - Outdated or unused accounts must be removed from the system or disabled.
    - V-6840 - Windows 2012/2012 R2 passwords must be configured to expire.
    - V-7002 - Windows 2012/2012 R2 accounts must be configured to require passwords.
    - V-14225 - Windows 2012/2012 R2 password for the built-in Administrator account must be changed at least annually or when a member of the administrative team leaves the organization.
    - V-36662 - Windows 2012/2012 R2 manually managed application account passwords must be changed at least annually or when a system administrator with knowledge of the password leaves the organization.
    - V-57653 - If temporary user accounts remain active when no longer needed or for an excessive period, these accounts may be used to gain unauthorized access. To mitigate this risk, automated termination of all temporary accounts must be set upon account creation.
    - V-57655 - Emergency administrator accounts are privileged accounts which are established in response to crisis situations where the need for rapid account activation is required. Therefore, emergency account activation may bypass normal account authorization processes. If these accounts are automatically disabled, system maintenance during emergencies may not be possible, thus adversely affecting system availability.


### NOTICE

© 2018-2020 The MITRE Corporation.

Approved for Public Release; Distribution Unlimited. Case Number 18-3678.

### NOTICE 

MITRE hereby grants express written permission to use, reproduce, distribute, modify, and otherwise leverage this software to the extent permitted by the licensed terms provided in the LICENSE.md file included with this project.

### NOTICE  

This software was produced for the U. S. Government under Contract Number HHSM-500-2012-00008I, and is subject to Federal Acquisition Regulation Clause 52.227-14, Rights in Data-General.  

No other use other than that granted to the U. S. Government, or to those acting on behalf of the U. S. Government under that Clause is authorized without the express written permission of The MITRE Corporation.

For further information, please contact The MITRE Corporation, Contracts Management Office, 7515 Colshire Drive, McLean, VA  22102-7539, (703) 983-6000.

### NOTICE 

DISA STIGs are published by DISA IASE, see: https://iase.disa.mil/Pages/privacy_policy.aspx