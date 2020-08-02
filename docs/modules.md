#### add_host
```yaml
- name: Add a host (and alternatively a group) to the ansible-playbook in-memory inventory
  add_host:
      groups:                # The groups to add the hostname to.
      name:                  # (required) The hostname/ip of the host to add to the inventory, can include a colon and a port
                               number.
```
#### apache2_module
```yaml
- name: Enables/disables a module of the Apache2 webserver.
  apache2_module:
      force:                 # Force disabling of default modules and override Debian warnings.
      identifier:            # Identifier of the module as listed by `apache2ctl -M'. This is optional and usually determined
                               automatically by the common convention of appending `_module' to
                               `name' as well as custom exception for popular modules.
      ignore_configcheck:    # Ignore configuration checks about inconsistent module configuration. Especially for mpm_* modules.
      name:                  # (required) Name of the module to enable/disable as given to `a2enmod/a2dismod'.
      state:                 # Desired state of the module.
```
#### command
```yaml
- name: Execute commands on targets
  command:
      argv:                  # Passes the command as a list rather than a string. Use `argv' to avoid quoting values that would
                               otherwise be interpreted incorrectly (for example "user name"). Only
                               the string or the list form can be provided, not both.  One or the
                               other must be provided.
      chdir:                 # Change into this directory before running the command.
      cmd:                   # The command to run.
      creates:               # A filename or (since 2.0) glob pattern. If it already exists, this step *won't* be run.
      free_form:             # The command module takes a free form command to run. There is no actual parameter named 'free form'.
      removes:               # A filename or (since 2.0) glob pattern. If it already exists, this step *will* be run.
      stdin:                 # Set the stdin of the command directly to the specified value.
      stdin_add_newline:     # If set to `yes', append a newline to stdin data.
      strip_empty_ends:      # Strip empty lines from the end of stdout/stderr in result.
      warn:                  # Enable or disable task warnings.
```
#### copy
```yaml
- name: Copy files to remote locations
  copy:
      attributes:            # The attributes the resulting file or directory should have. To get supported flags look at the man
                               page for `chattr' on the target system. This string should contain the
                               attributes in the same order as the one displayed by `lsattr'. The `='
                               operator is assumed as default, otherwise `+' or `-' operators need to
                               be included in the string.
      backup:                # Create a backup file including the timestamp information so you can get the original file back if you
                               somehow clobbered it incorrectly.
      checksum:              # SHA1 checksum of the file being transferred. Used to validate that the copy of the file was
                               successful. If this is not provided, ansible will use the local
                               calculated checksum of the src file.
      content:               # When used instead of `src', sets the contents of a file directly to the specified value. Works only
                               when `dest' is a file. Creates the file if it does not exist. For
                               advanced formatting or if `content' contains a variable, use the
                               [template] module.
      decrypt:               # This option controls the autodecryption of source files using vault.
      dest:                  # (required) Remote absolute path where the file should be copied to. If `src' is a directory, this
                               must be a directory too. If `dest' is a non-existent path and if
                               either `dest' ends with "/" or `src' is a directory, `dest' is
                               created. If `dest' is a relative path, the starting directory is
                               determined by the remote host. If `src' and `dest' are files, the
                               parent directory of `dest' is not created and the task fails if it
                               does not already exist.
      directory_mode:        # When doing a recursive copy set the mode for the directories. If this is not set we will use the
                               system defaults. The mode is only set on directories which are newly
                               created, and will not affect those that already existed.
      follow:                # This flag indicates that filesystem links in the destination, if they exist, should be followed.
      force:                 # Influence whether the remote file must always be replaced. If `yes', the remote file will be replaced
                               when contents are different than the source. If `no', the file will
                               only be transferred if the destination does not exist. Alias `thirsty'
                               has been deprecated and will be removed in 2.13.
      group:                 # Name of the group that should own the file/directory, as would be fed to `chown'.
      local_follow:          # This flag indicates that filesystem links in the source tree, if they exist, should be followed.
      mode:                  # The permissions of the destination file or directory. For those used to `/usr/bin/chmod' remember
                               that modes are actually octal numbers. You must either add a leading
                               zero so that Ansible's YAML parser knows it is an octal number (like
                               `0644' or `01777')or quote it (like `'644'' or `'1777'') so Ansible
                               receives a string and can do its own conversion from string into
                               number. Giving Ansible a number without following one of these rules
                               will end up with a decimal number which will have unexpected results.
                               As of Ansible 1.8, the mode may be specified as a symbolic mode (for
                               example, `u+rwx' or `u=rw,g=r,o=r'). As of Ansible 2.3, the mode may
                               also be the special string `preserve'. `preserve' means that the file
                               will be given the same permissions as the source file.
      owner:                 # Name of the user that should own the file/directory, as would be fed to `chown'.
      remote_src:            # Influence whether `src' needs to be transferred or already is present remotely. If `no', it will
                               search for `src' at originating/master machine. If `yes' it will go to
                               the remote/target machine for the `src'. `remote_src' supports
                               recursive copying as of version 2.8. `remote_src' only works with
                               `mode=preserve' as of version 2.6.
      selevel:               # The level part of the SELinux file context. This is the MLS/MCS attribute, sometimes known as the
                               `range'. When set to `_default', it will use the `level' portion of
                               the policy if available.
      serole:                # The role part of the SELinux file context. When set to `_default', it will use the `role' portion of
                               the policy if available.
      setype:                # The type part of the SELinux file context. When set to `_default', it will use the `type' portion of
                               the policy if available.
      seuser:                # The user part of the SELinux file context. By default it uses the `system' policy, where applicable.
                               When set to `_default', it will use the `user' portion of the policy
                               if available.
      src:                   # Local path to a file to copy to the remote server. This can be absolute or relative. If path is a
                               directory, it is copied recursively. In this case, if path ends with
                               "/", only inside contents of that directory are copied to destination.
                               Otherwise, if it does not end with "/", the directory itself with all
                               contents is copied. This behavior is similar to the `rsync' command
                               line tool.
      unsafe_writes:         # Influence when to use atomic operation to prevent data corruption or inconsistent reads from the
                               target file. By default this module uses atomic operations to prevent
                               data corruption or inconsistent reads from the target files, but
                               sometimes systems are configured or just broken in ways that prevent
                               this. One example is docker mounted files, which cannot be updated
                               atomically from inside the container and can only be written in an
                               unsafe manner. This option allows Ansible to fall back to unsafe
                               methods of updating files when atomic operations fail (however, it
                               doesn't force Ansible to perform unsafe writes). IMPORTANT! Unsafe
                               writes are subject to race conditions and can lead to data corruption.
      validate:              # The validation command to run before copying into place. The path to the file to validate is passed
                               in via '%s' which must be present as in the examples below. The
                               command is passed securely so shell features like expansion and pipes
                               will not work.
```
#### debug
```yaml
- name: Print statements during execution
  debug:
      msg:                   # The customized message that is printed. If omitted, prints a generic message.
      var:                   # A variable name to debug. Mutually exclusive with the `msg' option. Be aware that this option already
                               runs in Jinja2 context and has an implicit `{{ }}' wrapping, so you
                               should not be using Jinja2 delimiters unless you are looking for
                               double interpolation.
      verbosity:             # A number that controls when the debug is run, if you set to 3 it will only run debug when -vvv or
                               above
```
#### file
```yaml
- name: Manage files and file properties
  file:
      access_time:           # This parameter indicates the time the file's access time should be set to. Should be `preserve' when
                               no modification is required, `YYYYMMDDHHMM.SS' when using default time
                               format, or `now'. Default is `None' meaning that `preserve' is the
                               default for `state=[file,directory,link,hard]' and `now' is default
                               for `state=touch'.
      access_time_format:    # When used with `access_time', indicates the time format that must be used. Based on default Python
                               format (see time.strftime doc).
      attributes:            # The attributes the resulting file or directory should have. To get supported flags look at the man
                               page for `chattr' on the target system. This string should contain the
                               attributes in the same order as the one displayed by `lsattr'. The `='
                               operator is assumed as default, otherwise `+' or `-' operators need to
                               be included in the string.
      follow:                # This flag indicates that filesystem links, if they exist, should be followed. Previous to Ansible
                               2.5, this was `no' by default.
      force:                 # Force the creation of the symlinks in two cases: the source file does not exist (but will appear
                               later); the destination exists and is a file (so, we need to unlink
                               the `path' file and create symlink to the `src' file in place of it).
      group:                 # Name of the group that should own the file/directory, as would be fed to `chown'.
      mode:                  # The permissions the resulting file or directory should have. For those used to `/usr/bin/chmod'
                               remember that modes are actually octal numbers. You must either add a
                               leading zero so that Ansible's YAML parser knows it is an octal number
                               (like `0644' or `01777') or quote it (like `'644'' or `'1777'') so
                               Ansible receives a string and can do its own conversion from string
                               into number. Giving Ansible a number without following one of these
                               rules will end up with a decimal number which will have unexpected
                               results. As of Ansible 1.8, the mode may be specified as a symbolic
                               mode (for example, `u+rwx' or `u=rw,g=r,o=r'). As of Ansible 2.6, the
                               mode may also be the special string `preserve'. When set to `preserve'
                               the file will be given the same permissions as the source file.
      modification_time:     # This parameter indicates the time the file's modification time should be set to. Should be `preserve'
                               when no modification is required, `YYYYMMDDHHMM.SS' when using default
                               time format, or `now'. Default is None meaning that `preserve' is the
                               default for `state=[file,directory,link,hard]' and `now' is default
                               for `state=touch'.
      modification_time_format:   # When used with `modification_time', indicates the time format that must be used. Based on default
                               Python format (see time.strftime doc).
      owner:                 # Name of the user that should own the file/directory, as would be fed to `chown'.
      path:                  # (required) Path to the file being managed.
      recurse:               # Recursively set the specified file attributes on directory contents. This applies only when `state'
                               is set to `directory'.
      selevel:               # The level part of the SELinux file context. This is the MLS/MCS attribute, sometimes known as the
                               `range'. When set to `_default', it will use the `level' portion of
                               the policy if available.
      serole:                # The role part of the SELinux file context. When set to `_default', it will use the `role' portion of
                               the policy if available.
      setype:                # The type part of the SELinux file context. When set to `_default', it will use the `type' portion of
                               the policy if available.
      seuser:                # The user part of the SELinux file context. By default it uses the `system' policy, where applicable.
                               When set to `_default', it will use the `user' portion of the policy
                               if available.
      src:                   # Path of the file to link to. This applies only to `state=link' and `state=hard'. For `state=link',
                               this will also accept a non-existing path. Relative paths are relative
                               to the file being created (`path') which is how the Unix command `ln
                               -s SRC DEST' treats relative paths.
      state:                 # If `absent', directories will be recursively deleted, and files or symlinks will be unlinked. In the
                               case of a directory, if `diff' is declared, you will see the files and
                               folders deleted listed under `path_contents'. Note that `absent' will
                               not cause `file' to fail if the `path' does not exist as the state did
                               not change. If `directory', all intermediate subdirectories will be
                               created if they do not exist. Since Ansible 1.7 they will be created
                               with the supplied permissions. If `file', without any other options
                               this works mostly as a 'stat' and will return the current state of
                               `path'. Even with other options (i.e `mode'), the file will be
                               modified but will NOT be created if it does not exist; see the `touch'
                               value or the [copy] or [template] module if you want that behavior. If
                               `hard', the hard link will be created or changed. If `link', the
                               symbolic link will be created or changed. If `touch' (new in 1.4), an
                               empty file will be created if the `path' does not exist, while an
                               existing file or directory will receive updated file access and
                               modification times (similar to the way `touch' works from the command
                               line).
      unsafe_writes:         # Influence when to use atomic operation to prevent data corruption or inconsistent reads from the
                               target file. By default this module uses atomic operations to prevent
                               data corruption or inconsistent reads from the target files, but
                               sometimes systems are configured or just broken in ways that prevent
                               this. One example is docker mounted files, which cannot be updated
                               atomically from inside the container and can only be written in an
                               unsafe manner. This option allows Ansible to fall back to unsafe
                               methods of updating files when atomic operations fail (however, it
                               doesn't force Ansible to perform unsafe writes). IMPORTANT! Unsafe
                               writes are subject to race conditions and can lead to data corruption.
```
#### firewalld
```yaml
- name: Manage arbitrary ports/services with firewalld
  firewalld:
      icmp_block:            # The ICMP block you would like to add/remove to/from a zone in firewalld.
      icmp_block_inversion:   # Enable/Disable inversion of ICMP blocks for a zone in firewalld.
      immediate:             # Should this configuration be applied immediately, if set as permanent.
      interface:             # The interface you would like to add/remove to/from a zone in firewalld.
      masquerade:            # The masquerade setting you would like to enable/disable to/from zones within firewalld.
      offline:               # Whether to run this module even when firewalld is offline.
      permanent:             # Should this configuration be in the running firewalld configuration or persist across reboots. As of
                               Ansible 2.3, permanent operations can operate on firewalld configs
                               when it is not running (requires firewalld >= 3.0.9). Note that if
                               this is `no', immediate is assumed `yes'.
      port:                  # Name of a port or port range to add/remove to/from firewalld. Must be in the form PORT/PROTOCOL or
                               PORT-PORT/PROTOCOL for port ranges.
      rich_rule:             # Rich rule to add/remove to/from firewalld.
      service:               # Name of a service to add/remove to/from firewalld. The service must be listed in output of firewall-
                               cmd --get-services.
      source:                # The source/network you would like to add/remove to/from firewalld.
      state:                 # (required) Enable or disable a setting. For ports: Should this port accept (enabled) or reject
                               (disabled) connections. The states `present' and `absent' can only be
                               used in zone level operations (i.e. when no other parameters but zone
                               and state are set).
      timeout:               # The amount of time the rule should be in effect for when non-permanent.
      zone:                  # The firewalld zone to add/remove to/from. Note that the default zone can be configured per system but
                               `public' is default from upstream. Available choices can be extended
                               based on per-system configs, listed here are "out of the box"
                               defaults. Possible values include `block', `dmz', `drop', `external',
                               `home', `internal', `public', `trusted', `work'.
```
#### get_url
```yaml
- name: Downloads files from HTTP, HTTPS, or FTP to node
  get_url:
      attributes:            # The attributes the resulting file or directory should have. To get supported flags look at the man
                               page for `chattr' on the target system. This string should contain the
                               attributes in the same order as the one displayed by `lsattr'. The `='
                               operator is assumed as default, otherwise `+' or `-' operators need to
                               be included in the string.
      backup:                # Create a backup file including the timestamp information so you can get the original file back if you
                               somehow clobbered it incorrectly.
      checksum:              # If a checksum is passed to this parameter, the digest of the destination file will be calculated
                               after it is downloaded to ensure its integrity and verify that the
                               transfer completed successfully. Format: <algorithm>:<checksum|url>,
                               e.g. checksum="sha256:D98291AC[...]B6DC7B97",
                               checksum="sha256:http://example.com/path/sha256sum.txt" If you worry
                               about portability, only the sha1 algorithm is available on all
                               platforms and python versions. The third party hashlib library can be
                               installed for access to additional algorithms. Additionally, if a
                               checksum is passed to this parameter, and the file exist under the
                               `dest' location, the `destination_checksum' would be calculated, and
                               if checksum equals `destination_checksum', the file download would be
                               skipped (unless `force' is true). If the checksum does not equal
                               `destination_checksum', the destination file is deleted.
      client_cert:           # PEM formatted certificate chain file to be used for SSL client authentication. This file can also
                               include the key as well, and if the key is included, `client_key' is
                               not required.
      client_key:            # PEM formatted file that contains your private key to be used for SSL client authentication. If
                               `client_cert' contains both the certificate and key, this option is
                               not required.
      dest:                  # (required) Absolute path of where to download the file to. If `dest' is a directory, either the
                               server provided filename or, if none provided, the base name of the
                               URL on the remote server will be used. If a directory, `force' has no
                               effect. If `dest' is a directory, the file will always be downloaded
                               (regardless of the `force' option), but replaced only if the contents
                               changed..
      force:                 # If `yes' and `dest' is not a directory, will download the file every time and replace the file if the
                               contents change. If `no', the file will only be downloaded if the
                               destination does not exist. Generally should be `yes' only for small
                               local files. Prior to 0.6, this module behaved as if `yes' was the
                               default. Alias `thirsty' has been deprecated and will be removed in
                               2.13.
      force_basic_auth:      # Force the sending of the Basic authentication header upon initial request. httplib2, the library used
                               by the uri module only sends authentication information when a
                               webservice responds to an initial request with a 401 status. Since
                               some basic auth services do not properly send a 401, logins will fail.
      group:                 # Name of the group that should own the file/directory, as would be fed to `chown'.
      headers:               # Add custom HTTP headers to a request in hash/dict format. The hash/dict format was added in Ansible
                               2.6. Previous versions used a `"key:value,key:value"' string format.
                               The `"key:value,key:value"' string format is deprecated and will be
                               removed in version 2.10.
      http_agent:            # Header to identify as, generally appears in web server logs.
      mode:                  # The permissions the resulting file or directory should have. For those used to `/usr/bin/chmod'
                               remember that modes are actually octal numbers. You must either add a
                               leading zero so that Ansible's YAML parser knows it is an octal number
                               (like `0644' or `01777') or quote it (like `'644'' or `'1777'') so
                               Ansible receives a string and can do its own conversion from string
                               into number. Giving Ansible a number without following one of these
                               rules will end up with a decimal number which will have unexpected
                               results. As of Ansible 1.8, the mode may be specified as a symbolic
                               mode (for example, `u+rwx' or `u=rw,g=r,o=r'). As of Ansible 2.6, the
                               mode may also be the special string `preserve'. When set to `preserve'
                               the file will be given the same permissions as the source file.
      owner:                 # Name of the user that should own the file/directory, as would be fed to `chown'.
      selevel:               # The level part of the SELinux file context. This is the MLS/MCS attribute, sometimes known as the
                               `range'. When set to `_default', it will use the `level' portion of
                               the policy if available.
      serole:                # The role part of the SELinux file context. When set to `_default', it will use the `role' portion of
                               the policy if available.
      setype:                # The type part of the SELinux file context. When set to `_default', it will use the `type' portion of
                               the policy if available.
      seuser:                # The user part of the SELinux file context. By default it uses the `system' policy, where applicable.
                               When set to `_default', it will use the `user' portion of the policy
                               if available.
      sha256sum:             # If a SHA-256 checksum is passed to this parameter, the digest of the destination file will be
                               calculated after it is downloaded to ensure its integrity and verify
                               that the transfer completed successfully. This option is deprecated.
                               Use `checksum' instead.
      timeout:               # Timeout in seconds for URL request.
      tmp_dest:              # Absolute path of where temporary file is downloaded to. When run on Ansible 2.5 or greater, path
                               defaults to ansible's remote_tmp setting When run on Ansible prior to
                               2.5, it defaults to `TMPDIR', `TEMP' or `TMP' env variables or a
                               platform specific value.
                               https://docs.python.org/2/library/tempfile.html#tempfile.tempdir
      unsafe_writes:         # Influence when to use atomic operation to prevent data corruption or inconsistent reads from the
                               target file. By default this module uses atomic operations to prevent
                               data corruption or inconsistent reads from the target files, but
                               sometimes systems are configured or just broken in ways that prevent
                               this. One example is docker mounted files, which cannot be updated
                               atomically from inside the container and can only be written in an
                               unsafe manner. This option allows Ansible to fall back to unsafe
                               methods of updating files when atomic operations fail (however, it
                               doesn't force Ansible to perform unsafe writes). IMPORTANT! Unsafe
                               writes are subject to race conditions and can lead to data corruption.
      url:                   # (required) HTTP, HTTPS, or FTP URL in the form
                               (http|https|ftp)://[user[:pass]]@host.domain[:port]/path
      url_password:          # The password for use in HTTP basic authentication. If the `url_username' parameter is not specified,
                               the `url_password' parameter will not be used. Since version 2.8 you
                               can also use the 'password' alias for this option.
      url_username:          # The username for use in HTTP basic authentication. This parameter can be used without `url_password'
                               for sites that allow empty passwords. Since version 2.8 you can also
                               use the `username' alias for this option.
      use_proxy:             # if `no', it will not use a proxy, even if one is defined in an environment variable on the target
                               hosts.
      validate_certs:        # If `no', SSL certificates will not be validated. This should only be used on personally controlled
                               sites using self-signed certificates.
```
#### group
```yaml
- name: Add or remove groups
  group:
      gid:                   # Optional `GID' to set for the group.
      local:                 # Forces the use of "local" command alternatives on platforms that implement it. This is useful in
                               environments that use centralized authentication when you want to
                               manipulate the local groups. (e.g. it uses `lgroupadd' instead of
                               `groupadd'). This requires that these commands exist on the targeted
                               host, otherwise it will be a fatal error.
      name:                  # (required) Name of the group to manage.
      non_unique:            # This option allows to change the group ID to a non-unique value. Requires `gid'. Not supported on
                               macOS or BusyBox distributions.
      state:                 # Whether the group should be present or not on the remote host.
      system:                # If `yes', indicates that the group created is a system group.
```
#### htpasswd
```yaml
- name: manage user files for basic authentication
  htpasswd:
      attributes:            # The attributes the resulting file or directory should have. To get supported flags look at the man
                               page for `chattr' on the target system. This string should contain the
                               attributes in the same order as the one displayed by `lsattr'. The `='
                               operator is assumed as default, otherwise `+' or `-' operators need to
                               be included in the string.
      create:                # Used with `state=present'. If specified, the file will be created if it does not already exist. If
                               set to "no", will fail if the file does not exist
      crypt_scheme:          # Encryption scheme to be used.  As well as the four choices listed here, you can also use any other
                               hash supported by passlib, such as md5_crypt and sha256_crypt, which
                               are linux passwd hashes.  If you do so the password file will not be
                               compatible with Apache or Nginx
      group:                 # Name of the group that should own the file/directory, as would be fed to `chown'.
      mode:                  # The permissions the resulting file or directory should have. For those used to `/usr/bin/chmod'
                               remember that modes are actually octal numbers. You must either add a
                               leading zero so that Ansible's YAML parser knows it is an octal number
                               (like `0644' or `01777') or quote it (like `'644'' or `'1777'') so
                               Ansible receives a string and can do its own conversion from string
                               into number. Giving Ansible a number without following one of these
                               rules will end up with a decimal number which will have unexpected
                               results. As of Ansible 1.8, the mode may be specified as a symbolic
                               mode (for example, `u+rwx' or `u=rw,g=r,o=r'). As of Ansible 2.6, the
                               mode may also be the special string `preserve'. When set to `preserve'
                               the file will be given the same permissions as the source file.
      name:                  # (required) User name to add or remove
      owner:                 # Name of the user that should own the file/directory, as would be fed to `chown'.
      password:              # Password associated with user. Must be specified if user does not exist yet.
      path:                  # (required) Path to the file that contains the usernames and passwords
      selevel:               # The level part of the SELinux file context. This is the MLS/MCS attribute, sometimes known as the
                               `range'. When set to `_default', it will use the `level' portion of
                               the policy if available.
      serole:                # The role part of the SELinux file context. When set to `_default', it will use the `role' portion of
                               the policy if available.
      setype:                # The type part of the SELinux file context. When set to `_default', it will use the `type' portion of
                               the policy if available.
      seuser:                # The user part of the SELinux file context. By default it uses the `system' policy, where applicable.
                               When set to `_default', it will use the `user' portion of the policy
                               if available.
      state:                 # Whether the user entry should be present or not
      unsafe_writes:         # Influence when to use atomic operation to prevent data corruption or inconsistent reads from the
                               target file. By default this module uses atomic operations to prevent
                               data corruption or inconsistent reads from the target files, but
                               sometimes systems are configured or just broken in ways that prevent
                               this. One example is docker mounted files, which cannot be updated
                               atomically from inside the container and can only be written in an
                               unsafe manner. This option allows Ansible to fall back to unsafe
                               methods of updating files when atomic operations fail (however, it
                               doesn't force Ansible to perform unsafe writes). IMPORTANT! Unsafe
                               writes are subject to race conditions and can lead to data corruption.
```
#### include
```yaml
- name: Include a play or task list
  include:
      free-form:             # This module allows you to specify the name of the file directly without any other options.
```
#### include_role
```yaml
- name: Load and execute a role
  include_role:
      allow_duplicates:      # Overrides the role's metadata setting to allow using a role more than once with the same parameters.
      apply:                 # Accepts a hash of task keywords (e.g. `tags', `become') that will be applied to all tasks within the
                               included role.
      defaults_from:         # File to load from a role's `defaults/' directory.
      handlers_from:         # File to load from a role's `handlers/' directory.
      name:                  # (required) The name of the role to be executed.
      public:                # This option dictates whether the role's `vars' and `defaults' are exposed to the playbook. If set to
                               `yes' the variables will be available to tasks following the
                               `include_role' task. This functionality differs from standard variable
                               exposure for roles listed under the `roles' header or `import_role' as
                               they are exposed at playbook parsing time, and available to earlier
                               roles and tasks as well.
      tasks_from:            # File to load from a role's `tasks/' directory.
      vars_from:             # File to load from a role's `vars/' directory.
```
#### include_tasks
```yaml
- name: Dynamically include a task list
  include_tasks:
      apply:                 # Accepts a hash of task keywords (e.g. `tags', `become') that will be applied to the tasks within the
                               include.
      file:                  # The name of the imported file is specified directly without any other option. Unlike [import_tasks],
                               most keywords, including loop, with_items, and conditionals, apply to
                               this statement. The do until loop is not supported on [include_tasks].
      free-form:             # Supplying a file name via free-form `- include_tasks: file.yml' of a file to be included is the
                               equivalent of specifying an argument of `file'.
```
#### include_vars
```yaml
- name: Load variables from files, dynamically within a task
  include_vars:
      depth:                 # When using `dir', this module will, by default, recursively go through each sub directory and load up
                               the variables. By explicitly setting the depth, this module will only
                               go as deep as the depth.
      dir:                   # The directory name from which the variables should be loaded. If the path is relative and the task is
                               inside a role, it will look inside the role's vars/ subdirectory. If
                               the path is relative and not inside a role, it will be parsed relative
                               to the playbook.
      extensions:            # List of file extensions to read when using `dir'.
      file:                  # The file name from which variables should be loaded. If the path is relative, it will look for the
                               file in vars/ subdirectory of a role or relative to playbook.
      files_matching:        # Limit the files that are loaded within any directory to this regular expression.
      free-form:             # This module allows you to specify the 'file' option directly without any other options. There is no
                               'free-form' option, this is just an indicator, see example below.
      ignore_files:          # List of file names to ignore.
      ignore_unknown_extensions:   # Ignore unknown file extensions within the directory. This allows users to specify a directory
                               containing vars files that are intermingled with non-vars files
                               extension types (e.g. a directory with a README in it and vars files).
      name:                  # The name of a variable into which assign the included vars. If omitted (null) they will be made top
                               level vars.
```
#### lineinfile
```yaml
- name: Manage lines in text files
  lineinfile:
      attributes:            # The attributes the resulting file or directory should have. To get supported flags look at the man
                               page for `chattr' on the target system. This string should contain the
                               attributes in the same order as the one displayed by `lsattr'. The `='
                               operator is assumed as default, otherwise `+' or `-' operators need to
                               be included in the string.
      backrefs:              # Used with `state=present'. If set, `line' can contain backreferences (both positional and named) that
                               will get populated if the `regexp' matches. This parameter changes the
                               operation of the module slightly; `insertbefore' and `insertafter'
                               will be ignored, and if the `regexp' does not match anywhere in the
                               file, the file will be left unchanged. If the `regexp' does match, the
                               last matching line will be replaced by the expanded line parameter.
      backup:                # Create a backup file including the timestamp information so you can get the original file back if you
                               somehow clobbered it incorrectly.
      create:                # Used with `state=present'. If specified, the file will be created if it does not already exist. By
                               default it will fail if the file is missing.
      firstmatch:            # Used with `insertafter' or `insertbefore'. If set, `insertafter' and `insertbefore' will work with
                               the first line that matches the given regular expression.
      group:                 # Name of the group that should own the file/directory, as would be fed to `chown'.
      insertafter:           # Used with `state=present'. If specified, the line will be inserted after the last match of specified
                               regular expression. If the first match is required,
                               use(firstmatch=yes). A special value is available; `EOF' for inserting
                               the line at the end of the file. If specified regular expression has
                               no matches, EOF will be used instead. If `insertbefore' is set,
                               default value `EOF' will be ignored. If regular expressions are passed
                               to both `regexp' and `insertafter', `insertafter' is only honored if
                               no match for `regexp' is found. May not be used with `backrefs' or
                               `insertbefore'.
      insertbefore:          # Used with `state=present'. If specified, the line will be inserted before the last match of specified
                               regular expression. If the first match is required, use
                               `firstmatch=yes'. A value is available; `BOF' for inserting the line
                               at the beginning of the file. If specified regular expression has no
                               matches, the line will be inserted at the end of the file. If regular
                               expressions are passed to both `regexp' and `insertbefore',
                               `insertbefore' is only honored if no match for `regexp' is found. May
                               not be used with `backrefs' or `insertafter'.
      line:                  # The line to insert/replace into the file. Required for `state=present'. If `backrefs' is set, may
                               contain backreferences that will get expanded with the `regexp'
                               capture groups if the regexp matches.
      mode:                  # The permissions the resulting file or directory should have. For those used to `/usr/bin/chmod'
                               remember that modes are actually octal numbers. You must either add a
                               leading zero so that Ansible's YAML parser knows it is an octal number
                               (like `0644' or `01777') or quote it (like `'644'' or `'1777'') so
                               Ansible receives a string and can do its own conversion from string
                               into number. Giving Ansible a number without following one of these
                               rules will end up with a decimal number which will have unexpected
                               results. As of Ansible 1.8, the mode may be specified as a symbolic
                               mode (for example, `u+rwx' or `u=rw,g=r,o=r'). As of Ansible 2.6, the
                               mode may also be the special string `preserve'. When set to `preserve'
                               the file will be given the same permissions as the source file.
      others:                # All arguments accepted by the [file] module also work here.
      owner:                 # Name of the user that should own the file/directory, as would be fed to `chown'.
      path:                  # (required) The file to modify. Before Ansible 2.3 this option was only usable as `dest', `destfile'
                               and `name'.
      regexp:                # The regular expression to look for in every line of the file. For `state=present', the pattern to
                               replace if found. Only the last line found will be replaced. For
                               `state=absent', the pattern of the line(s) to remove. If the regular
                               expression is not matched, the line will be added to the file in
                               keeping with `insertbefore' or `insertafter' settings. When modifying
                               a line the regexp should typically match both the initial state of the
                               line as well as its state after replacement by `line' to ensure
                               idempotence. Uses Python regular expressions. See
                               http://docs.python.org/2/library/re.html.
      selevel:               # The level part of the SELinux file context. This is the MLS/MCS attribute, sometimes known as the
                               `range'. When set to `_default', it will use the `level' portion of
                               the policy if available.
      serole:                # The role part of the SELinux file context. When set to `_default', it will use the `role' portion of
                               the policy if available.
      setype:                # The type part of the SELinux file context. When set to `_default', it will use the `type' portion of
                               the policy if available.
      seuser:                # The user part of the SELinux file context. By default it uses the `system' policy, where applicable.
                               When set to `_default', it will use the `user' portion of the policy
                               if available.
      state:                 # Whether the line should be there or not.
      unsafe_writes:         # Influence when to use atomic operation to prevent data corruption or inconsistent reads from the
                               target file. By default this module uses atomic operations to prevent
                               data corruption or inconsistent reads from the target files, but
                               sometimes systems are configured or just broken in ways that prevent
                               this. One example is docker mounted files, which cannot be updated
                               atomically from inside the container and can only be written in an
                               unsafe manner. This option allows Ansible to fall back to unsafe
                               methods of updating files when atomic operations fail (however, it
                               doesn't force Ansible to perform unsafe writes). IMPORTANT! Unsafe
                               writes are subject to race conditions and can lead to data corruption.
      validate:              # The validation command to run before copying into place. The path to the file to validate is passed
                               in via '%s' which must be present as in the examples below. The
                               command is passed securely so shell features like expansion and pipes
                               will not work.
```
#### ping
```yaml
- name: Try to connect to host, verify a usable python and return `pong' on success
  ping:
      data:                  # Data to return for the `ping' return value. If this parameter is set to `crash', the module will
                               cause an exception.
```
#### service
```yaml
- name: Manage services
  service:
      arguments:             # Additional arguments provided on the command line.
      enabled:               # Whether the service should start on boot. *At least one of state and enabled are required.*
      name:                  # (required) Name of the service.
      pattern:               # If the service does not respond to the status command, name a substring to look for as would be found
                               in the output of the `ps' command as a stand-in for a status result.
                               If the string is found, the service will be assumed to be started.
      runlevel:              # For OpenRC init scripts (e.g. Gentoo) only. The runlevel that this service belongs to.
      sleep:                 # If the service is being `restarted' then sleep this many seconds between the stop and start command.
                               This helps to work around badly-behaving init scripts that exit
                               immediately after signaling a process to stop. Not all service
                               managers support sleep, i.e when using systemd this setting will be
                               ignored.
      state:                 # `started'/`stopped' are idempotent actions that will not run commands unless necessary. `restarted'
                               will always bounce the service. `reloaded' will always reload. *At
                               least one of state and enabled are required.* Note that reloaded will
                               start the service if it is not already started, even if your chosen
                               init system wouldn't normally.
      use:                   # The service module actually uses system specific modules, normally through auto detection, this
                               setting can force a specific module. Normally it uses the value of the
                               'ansible_service_mgr' fact and falls back to the old 'service' module
                               when none matching is found.
```
#### set_fact
```yaml
- name: Set host facts from a task
  set_fact:
      cacheable:             # This boolean converts the variable into an actual 'fact' which will also be added to the fact cache,
                               if fact caching is enabled. Normally this module creates 'host level
                               variables' and has much higher precedence, this option changes the
                               nature and precedence (by 7 steps) of the variable created. https://do
                               cs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#vari
                               able-precedence-where-should-i-put-a-variable This actually creates 2
                               copies of the variable, a normal 'set_fact' host variable with high
                               precedence and a lower 'ansible_fact' one that is available for
                               persistance via the facts cache plugin. This creates a possibly
                               confusing interaction with `meta: clear_facts' as it will remove the
                               'ansible_fact' but not the host variable.
      key_value:             # (required) The `set_fact' module takes key=value pairs as variables to set in the playbook scope. Or
                               alternatively, accepts complex arguments using the `args:' statement.
```
#### setup
```yaml
- name: Gathers facts about remote hosts
  setup:
      fact_path:             # Path used for local ansible facts (`*.fact') - files in this dir will be run (if executable) and
                               their results be added to `ansible_local' facts if a file is not
                               executable it is read. Check notes for Windows options. (from 2.1 on)
                               File/results format can be JSON or INI-format. The default `fact_path'
                               can be specified in `ansible.cfg' for when setup is automatically
                               called as part of `gather_facts'.
      filter:                # If supplied, only return facts that match this shell-style (fnmatch) wildcard.
      gather_subset:         # If supplied, restrict the additional facts collected to the given subset. Possible values: `all',
                               `min', `hardware', `network', `virtual', `ohai', and `facter'. Can
                               specify a list of values to specify a larger subset. Values can also
                               be used with an initial `!' to specify that that specific subset
                               should not be collected.  For instance:
                               `!hardware,!network,!virtual,!ohai,!facter'. If `!all' is specified
                               then only the min subset is collected. To avoid collecting even the
                               min subset, specify `!all,!min'. To collect only specific facts, use
                               `!all,!min', and specify the particular fact subsets. Use the filter
                               parameter if you do not want to display some collected facts.
      gather_timeout:        # Set the default timeout in seconds for individual fact gathering.
```
#### shell
```yaml
- name: Execute shell commands on targets
  shell:
      chdir:                 # Change into this directory before running the command.
      cmd:                   # The command to run followed by optional arguments.
      creates:               # A filename, when it already exists, this step will *not* be run.
      executable:            # Change the shell used to execute the command. This expects an absolute path to the executable.
      free_form:             # The shell module takes a free form command to run, as a string. There is no actual parameter named
                               'free form'. See the examples on how to use this module.
      removes:               # A filename, when it does not exist, this step will *not* be run.
      stdin:                 # Set the stdin of the command directly to the specified value.
      stdin_add_newline:     # Whether to append a newline to stdin data.
      warn:                  # Whether to enable task warnings.
```
#### stat
```yaml
- name: Retrieve file or file system status
  stat:
      checksum_algorithm:    # Algorithm to determine checksum of file. Will throw an error if the host is unable to use specified
                               algorithm. The remote host has to support the hashing method
                               specified, `md5' can be unavailable if the host is FIPS-140 compliant.
      follow:                # Whether to follow symlinks.
      get_attributes:        # Get file attributes using lsattr tool if present.
      get_checksum:          # Whether to return a checksum of the file.
      get_mime:              # Use file magic and return data about the nature of the file. this uses the 'file' utility found on
                               most Linux/Unix systems. This will add both `mime_type` and 'charset'
                               fields to the return, if possible. In Ansible 2.3 this option changed
                               from 'mime' to 'get_mime' and the default changed to 'Yes'.
      path:                  # (required) The full path of the file/object to get the facts of.
```
#### systemd
```yaml
- name: Manage services
  systemd:
      daemon_reexec:         # Run daemon_reexec command before doing any other operations, the systemd manager will serialize the
                               manager state.
      daemon_reload:         # Run daemon-reload before doing any other operations, to make sure systemd has read any changes. When
                               set to `yes', runs daemon-reload even if the module does not start or
                               stop anything.
      enabled:               # Whether the service should start on boot. *At least one of state and enabled are required.*
      force:                 # Whether to override existing symlinks.
      masked:                # Whether the unit should be masked or not, a masked unit is impossible to start.
      name:                  # Name of the service. This parameter takes the name of exactly one service to work with. When using in
                               a chroot environment you always need to specify the full name i.e.
                               (crond.service).
      no_block:              # Do not synchronously wait for the requested operation to finish. Enqueued job will continue without
                               Ansible blocking on its completion.
      scope:                 # run systemctl within a given service manager scope, either as the default system scope (system), the
                               current user's scope (user), or the scope of all users (global). For
                               systemd to work with 'user', the executing user must have its own
                               instance of dbus started (systemd requirement). The user dbus process
                               is normally started during normal login, but not during the run of
                               Ansible tasks. Otherwise you will probably get a 'Failed to connect to
                               bus: no such file or directory' error.
      state:                 # `started'/`stopped' are idempotent actions that will not run commands unless necessary. `restarted'
                               will always bounce the service. `reloaded' will always reload.
      user:                  # (deprecated) run ``systemctl`` talking to the service manager of the calling user, rather than the
                               service manager of the system. This option is deprecated and will
                               eventually be removed in 2.11. The ``scope`` option should be used
                               instead.
```
#### template
```yaml
- name: Template a file out to a remote server
  template:
      attributes:            # The attributes the resulting file or directory should have. To get supported flags look at the man
                               page for `chattr' on the target system. This string should contain the
                               attributes in the same order as the one displayed by `lsattr'. The `='
                               operator is assumed as default, otherwise `+' or `-' operators need to
                               be included in the string.
      backup:                # Create a backup file including the timestamp information so you can get the original file back if you
                               somehow clobbered it incorrectly.
      block_end_string:      # The string marking the end of a block.
      block_start_string:    # The string marking the beginning of a block.
      dest:                  # (required) Location to render the template to on the remote machine.
      follow:                # Determine whether symbolic links should be followed. When set to `yes' symbolic links will be
                               followed, if they exist. When set to `no' symbolic links will not be
                               followed. Previous to Ansible 2.4, this was hardcoded as `yes'.
      force:                 # Determine when the file is being transferred if the destination already exists. When set to `yes',
                               replace the remote file when contents are different than the source.
                               When set to `no', the file will only be transferred if the destination
                               does not exist.
      group:                 # Name of the group that should own the file/directory, as would be fed to `chown'.
      lstrip_blocks:         # Determine when leading spaces and tabs should be stripped. When set to `yes' leading spaces and tabs
                               are stripped from the start of a line to a block. This functionality
                               requires Jinja 2.7 or newer.
      mode:                  # The permissions the resulting file or directory should have. For those used to `/usr/bin/chmod'
                               remember that modes are actually octal numbers. You must either add a
                               leading zero so that Ansible's YAML parser knows it is an octal number
                               (like `0644' or `01777') or quote it (like `'644'' or `'1777'') so
                               Ansible receives a string and can do its own conversion from string
                               into number. Giving Ansible a number without following one of these
                               rules will end up with a decimal number which will have unexpected
                               results. As of Ansible 1.8, the mode may be specified as a symbolic
                               mode (for example, `u+rwx' or `u=rw,g=r,o=r'). As of Ansible 2.6, the
                               mode may also be the special string `preserve'. When set to `preserve'
                               the file will be given the same permissions as the source file.
      newline_sequence:      # Specify the newline sequence to use for templating files.
      output_encoding:       # Overrides the encoding used to write the template file defined by `dest'. It defaults to `utf-8', but
                               any encoding supported by python can be used. The source template file
                               must always be encoded using `utf-8', for homogeneity.
      owner:                 # Name of the user that should own the file/directory, as would be fed to `chown'.
      selevel:               # The level part of the SELinux file context. This is the MLS/MCS attribute, sometimes known as the
                               `range'. When set to `_default', it will use the `level' portion of
                               the policy if available.
      serole:                # The role part of the SELinux file context. When set to `_default', it will use the `role' portion of
                               the policy if available.
      setype:                # The type part of the SELinux file context. When set to `_default', it will use the `type' portion of
                               the policy if available.
      seuser:                # The user part of the SELinux file context. By default it uses the `system' policy, where applicable.
                               When set to `_default', it will use the `user' portion of the policy
                               if available.
      src:                   # (required) Path of a Jinja2 formatted template on the Ansible controller. This can be a relative or
                               an absolute path. The file must be encoded with `utf-8' but
                               `output_encoding' can be used to control the encoding of the output
                               template.
      trim_blocks:           # Determine when newlines should be removed from blocks. When set to `yes' the first newline after a
                               block is removed (block, not variable tag!).
      unsafe_writes:         # Influence when to use atomic operation to prevent data corruption or inconsistent reads from the
                               target file. By default this module uses atomic operations to prevent
                               data corruption or inconsistent reads from the target files, but
                               sometimes systems are configured or just broken in ways that prevent
                               this. One example is docker mounted files, which cannot be updated
                               atomically from inside the container and can only be written in an
                               unsafe manner. This option allows Ansible to fall back to unsafe
                               methods of updating files when atomic operations fail (however, it
                               doesn't force Ansible to perform unsafe writes). IMPORTANT! Unsafe
                               writes are subject to race conditions and can lead to data corruption.
      validate:              # The validation command to run before copying into place. The path to the file to validate is passed
                               in via '%s' which must be present as in the examples below. The
                               command is passed securely so shell features like expansion and pipes
                               will not work.
      variable_end_string:   # The string marking the end of a print statement.
      variable_start_string:   # The string marking the beginning of a print statement.
```
#### uri
```yaml
- name: Interacts with webservices
  uri:
      attributes:            # The attributes the resulting file or directory should have. To get supported flags look at the man
                               page for `chattr' on the target system. This string should contain the
                               attributes in the same order as the one displayed by `lsattr'. The `='
                               operator is assumed as default, otherwise `+' or `-' operators need to
                               be included in the string.
      body:                  # The body of the http request/response to the web service. If `body_format' is set to 'json' it will
                               take an already formatted JSON string or convert a data structure into
                               JSON. If `body_format' is set to 'form-urlencoded' it will convert a
                               dictionary or list of tuples into an 'application/x-www-form-
                               urlencoded' string. (Added in v2.7)
      body_format:           # The serialization format of the body. When set to `json' or `form-urlencoded', encodes the body
                               argument, if needed, and automatically sets the Content-Type header
                               accordingly. As of `2.3' it is possible to override the `Content-Type`
                               header, when set to `json' or `form-urlencoded' via the `headers'
                               option.
      client_cert:           # PEM formatted certificate chain file to be used for SSL client authentication. This file can also
                               include the key as well, and if the key is included, `client_key' is
                               not required
      client_key:            # PEM formatted file that contains your private key to be used for SSL client authentication. If
                               `client_cert' contains both the certificate and key, this option is
                               not required.
      creates:               # A filename, when it already exists, this step will not be run.
      dest:                  # A path of where to download the file to (if desired). If `dest' is a directory, the basename of the
                               file on the remote server will be used.
      follow_redirects:      # Whether or not the URI module should follow redirects. `all' will follow all redirects. `safe' will
                               follow only "safe" redirects, where "safe" means that the client is
                               only doing a GET or HEAD on the URI to which it is being redirected.
                               `none' will not follow any redirects. Note that `yes' and `no' choices
                               are accepted for backwards compatibility, where `yes' is the
                               equivalent of `all' and `no' is the equivalent of `safe'. `yes' and
                               `no' are deprecated and will be removed in some future version of
                               Ansible.
      force:                 # If `yes' do not get a cached copy. Alias `thirsty' has been deprecated and will be removed in 2.13.
      force_basic_auth:      # Force the sending of the Basic authentication header upon initial request. The library used by the
                               uri module only sends authentication information when a webservice
                               responds to an initial request with a 401 status. Since some basic
                               auth services do not properly send a 401, logins will fail.
      group:                 # Name of the group that should own the file/directory, as would be fed to `chown'.
      headers:               # Add custom HTTP headers to a request in the format of a YAML hash. As of `2.3' supplying `Content-
                               Type' here will override the header generated by supplying `json' or
                               `form-urlencoded' for `body_format'.
      http_agent:            # Header to identify as, generally appears in web server logs.
      method:                # The HTTP method of the request or response. In more recent versions we do not restrict the method at
                               the module level anymore but it still must be a valid method accepted
                               by the service handling the request.
      mode:                  # The permissions the resulting file or directory should have. For those used to `/usr/bin/chmod'
                               remember that modes are actually octal numbers. You must either add a
                               leading zero so that Ansible's YAML parser knows it is an octal number
                               (like `0644' or `01777') or quote it (like `'644'' or `'1777'') so
                               Ansible receives a string and can do its own conversion from string
                               into number. Giving Ansible a number without following one of these
                               rules will end up with a decimal number which will have unexpected
                               results. As of Ansible 1.8, the mode may be specified as a symbolic
                               mode (for example, `u+rwx' or `u=rw,g=r,o=r'). As of Ansible 2.6, the
                               mode may also be the special string `preserve'. When set to `preserve'
                               the file will be given the same permissions as the source file.
      owner:                 # Name of the user that should own the file/directory, as would be fed to `chown'.
      remote_src:            # If `no', the module will search for src on originating/master machine. If `yes' the module will use
                               the `src' path on the remote/target machine.
      removes:               # A filename, when it does not exist, this step will not be run.
      return_content:        # Whether or not to return the body of the response as a "content" key in the dictionary result.
                               Independently of this option, if the reported Content-type is
                               "application/json", then the JSON is always loaded into a key called
                               `json' in the dictionary results.
      selevel:               # The level part of the SELinux file context. This is the MLS/MCS attribute, sometimes known as the
                               `range'. When set to `_default', it will use the `level' portion of
                               the policy if available.
      serole:                # The role part of the SELinux file context. When set to `_default', it will use the `role' portion of
                               the policy if available.
      setype:                # The type part of the SELinux file context. When set to `_default', it will use the `type' portion of
                               the policy if available.
      seuser:                # The user part of the SELinux file context. By default it uses the `system' policy, where applicable.
                               When set to `_default', it will use the `user' portion of the policy
                               if available.
      src:                   # Path to file to be submitted to the remote server. Cannot be used with `body'.
      status_code:           # A list of valid, numeric, HTTP status codes that signifies success of the request.
      timeout:               # The socket level timeout in seconds
      unix_socket:           # Path to Unix domain socket to use for connection
      unsafe_writes:         # Influence when to use atomic operation to prevent data corruption or inconsistent reads from the
                               target file. By default this module uses atomic operations to prevent
                               data corruption or inconsistent reads from the target files, but
                               sometimes systems are configured or just broken in ways that prevent
                               this. One example is docker mounted files, which cannot be updated
                               atomically from inside the container and can only be written in an
                               unsafe manner. This option allows Ansible to fall back to unsafe
                               methods of updating files when atomic operations fail (however, it
                               doesn't force Ansible to perform unsafe writes). IMPORTANT! Unsafe
                               writes are subject to race conditions and can lead to data corruption.
      url:                   # (required) HTTP or HTTPS URL in the form (http|https)://host.domain[:port]/path
      url_password:          # A password for the module to use for Digest, Basic or WSSE authentication.
      url_username:          # A username for the module to use for Digest, Basic or WSSE authentication.
      use_proxy:             # If `no', it will not use a proxy, even if one is defined in an environment variable on the target
                               hosts.
      validate_certs:        # If `no', SSL certificates will not be validated. This should only set to `no' used on personally
                               controlled sites using self-signed certificates. Prior to 1.9.2 the
                               code defaulted to `no'.
```
#### user
```yaml
- name: Manage user accounts
  user:
      append:                # If `yes', add the user to the groups specified in `groups'. If `no', user will only be added to the
                               groups specified in `groups', removing them from all other groups.
                               Mutually exclusive with `local'
      authorization:         # Sets the authorization of the user. Does nothing when used with other platforms. Can set multiple
                               authorizations using comma separation. To delete all authorizations,
                               use `authorization='''. Currently supported on Illumos/Solaris.
      comment:               # Optionally sets the description (aka `GECOS') of user account.
      create_home:           # Unless set to `no', a home directory will be made for the user when the account is created or if the
                               home directory does not exist. Changed from `createhome' to
                               `create_home' in Ansible 2.5.
      expires:               # An expiry time for the user in epoch, it will be ignored on platforms that do not support this.
                               Currently supported on GNU/Linux, FreeBSD, and DragonFlyBSD. Since
                               Ansible 2.6 you can remove the expiry time specify a negative value.
                               Currently supported on GNU/Linux and FreeBSD.
      force:                 # This only affects `state=absent', it forces removal of the user and associated directories on
                               supported platforms. The behavior is the same as `userdel --force',
                               check the man page for `userdel' on your system for details and
                               support. When used with `generate_ssh_key=yes' this forces an existing
                               key to be overwritten.
      generate_ssh_key:      # Whether to generate a SSH key for the user in question. This will *not* overwrite an existing SSH key
                               unless used with `force=yes'.
      group:                 # Optionally sets the user's primary group (takes a group name).
      groups:                # List of groups user will be added to. When set to an empty string `''', the user is removed from all
                               groups except the primary group. Before Ansible 2.3, the only input
                               format allowed was a comma separated string. Mutually exclusive with
                               `local'
      hidden:                # macOS only, optionally hide the user from the login window and system preferences. The default will
                               be `yes' if the `system' option is used.
      home:                  # Optionally set the user's home directory.
      local:                 # Forces the use of "local" command alternatives on platforms that implement it. This is useful in
                               environments that use centralized authentification when you want to
                               manipulate the local users (i.e. it uses `luseradd' instead of
                               `useradd'). This will check `/etc/passwd' for an existing account
                               before invoking commands. If the local account database exists
                               somewhere other than `/etc/passwd', this setting will not work
                               properly. This requires that the above commands as well as
                               `/etc/passwd' must exist on the target host, otherwise it will be a
                               fatal error. Mutually exclusive with `groups' and `append'
      login_class:           # Optionally sets the user's login class, a feature of most BSD OSs.
      move_home:             # If set to `yes' when used with `home: ', attempt to move the user's old home directory to the
                               specified directory if it isn't there already and the old home exists.
      name:                  # (required) Name of the user to create, remove or modify.
      non_unique:            # Optionally when used with the -u option, this option allows to change the user ID to a non-unique
                               value.
      password:              # Optionally set the user's password to this crypted value. On macOS systems, this value has to be
                               cleartext. Beware of security issues. To create a disabled account on
                               Linux systems, set this to `'!'' or `'*''. To create a disabled
                               account on OpenBSD, set this to `'*************''. See
                               https://docs.ansible.com/ansible/faq.html#how-do-i-generate-encrypted-
                               passwords-for-the-user-module for details on various ways to generate
                               these password values.
      password_lock:         # Lock the password (usermod -L, pw lock, usermod -C). BUT implementation differs on different
                               platforms, this option does not always mean the user cannot login via
                               other methods. This option does not disable the user, only lock the
                               password. Do not change the password in the same task. Currently
                               supported on Linux, FreeBSD, DragonFlyBSD, NetBSD, OpenBSD.
      profile:               # Sets the profile of the user. Does nothing when used with other platforms. Can set multiple profiles
                               using comma separation. To delete all the profiles, use `profile='''.
                               Currently supported on Illumos/Solaris.
      remove:                # This only affects `state=absent', it attempts to remove directories associated with the user. The
                               behavior is the same as `userdel --remove', check the man page for
                               details and support.
      role:                  # Sets the role of the user. Does nothing when used with other platforms. Can set multiple roles using
                               comma separation. To delete all roles, use `role='''. Currently
                               supported on Illumos/Solaris.
      seuser:                # Optionally sets the seuser type (user_u) on selinux enabled systems.
      shell:                 # Optionally set the user's shell. On macOS, before Ansible 2.5, the default shell for non-system users
                               was `/usr/bin/false'. Since Ansible 2.5, the default shell for non-
                               system users on macOS is `/bin/bash'. On other operating systems, the
                               default shell is determined by the underlying tool being used. See
                               Notes for details.
      skeleton:              # Optionally set a home skeleton directory. Requires `create_home' option!
      ssh_key_bits:          # Optionally specify number of bits in SSH key to create.
      ssh_key_comment:       # Optionally define the comment for the SSH key.
      ssh_key_file:          # Optionally specify the SSH key filename. If this is a relative filename then it will be relative to
                               the user's home directory. This parameter defaults to `.ssh/id_rsa'.
      ssh_key_passphrase:    # Set a passphrase for the SSH key. If no passphrase is provided, the SSH key will default to having no
                               passphrase.
      ssh_key_type:          # Optionally specify the type of SSH key to generate. Available SSH key types will depend on
                               implementation present on target host.
      state:                 # Whether the account should exist or not, taking action if the state is different from what is stated.
      system:                # When creating an account `state=present', setting this to `yes' makes the user a system account. This
                               setting cannot be changed on existing users.
      uid:                   # Optionally sets the `UID' of the user.
      update_password:       # `always' will update passwords if they differ. `on_create' will only set the password for newly
                               created users.
```
#### yum
```yaml
- name: Manages packages with the `yum' package manager
  yum:
      allow_downgrade:       # Specify if the named package and version is allowed to downgrade a maybe already installed higher
                               version of that package. Note that setting allow_downgrade=True can
                               make this module behave in a non-idempotent way. The task could end up
                               with a set of packages that does not match the complete list of
                               specified packages to install (because dependencies between the
                               downgraded package and others can cause changes to the packages which
                               were in the earlier transaction).
      autoremove:            # If `yes', removes all "leaf" packages from the system that were originally installed as dependencies
                               of user-installed packages but which are no longer required by any
                               such package. Should be used alone or when state is `absent' NOTE:
                               This feature requires yum >= 3.4.3 (RHEL/CentOS 7+)
      bugfix:                # If set to `yes', and `state=latest' then only installs updates that have been marked bugfix related.
      conf_file:             # The remote yum configuration file to use for the transaction.
      disable_excludes:      # Disable the excludes defined in YUM config files. If set to `all', disables all excludes. If set to
                               `main', disable excludes defined in [main] in yum.conf. If set to
                               `repoid', disable excludes defined for given repo id.
      disable_gpg_check:     # Whether to disable the GPG checking of signatures of packages being installed. Has an effect only if
                               state is `present' or `latest'.
      disable_plugin:        # `Plugin' name to disable for the install/update operation. The disabled plugins will not persist
                               beyond the transaction.
      disablerepo:           # `Repoid' of repositories to disable for the install/update operation. These repos will not persist
                               beyond the transaction. When specifying multiple repos, separate them
                               with a `","'. As of Ansible 2.7, this can alternatively be a list
                               instead of `","' separated string
      download_dir:          # Specifies an alternate directory to store packages. Has an effect only if `download_only' is
                               specified.
      download_only:         # Only download the packages, do not install them.
      enable_plugin:         # `Plugin' name to enable for the install/update operation. The enabled plugin will not persist beyond
                               the transaction.
      enablerepo:            # `Repoid' of repositories to enable for the install/update operation. These repos will not persist
                               beyond the transaction. When specifying multiple repos, separate them
                               with a `","'. As of Ansible 2.7, this can alternatively be a list
                               instead of `","' separated string
      exclude:               # Package name(s) to exclude when state=present, or latest
      install_weak_deps:     # Will also install all packages linked by a weak dependency relation. NOTE: This feature requires yum
                               >= 4 (RHEL/CentOS 8+)
      installroot:           # Specifies an alternative installroot, relative to which all packages will be installed.
      list:                  # Package name to run the equivalent of yum list --show-duplicates <package> against. In addition to
                               listing packages, use can also list the following: `installed',
                               `updates', `available' and `repos'. This parameter is mutually
                               exclusive with `name'.
      lock_timeout:          # Amount of time to wait for the yum lockfile to be freed.
      name:                  # A package name or package specifier with version, like `name-1.0'. If a previous version is
                               specified, the task also needs to turn `allow_downgrade' on. See the
                               `allow_downgrade' documentation for caveats with downgrading packages.
                               When using state=latest, this can be `'*'' which means run `yum -y
                               update'. You can also pass a url or a local path to a rpm file (using
                               state=present). To operate on several packages this can accept a comma
                               separated string of packages or (as of 2.0) a list of packages.
      releasever:            # Specifies an alternative release from which all packages will be installed.
      security:              # If set to `yes', and `state=latest' then only installs updates that have been marked security
                               related.
      skip_broken:           # Skip packages with broken dependencies(devsolve) and are causing problems.
      state:                 # Whether to install (`present' or `installed', `latest'), or remove (`absent' or `removed') a package.
                               `present' and `installed' will simply ensure that a desired package is
                               installed. `latest' will update the specified package if it's not of
                               the latest available version. `absent' and `removed' will remove the
                               specified package. Default is `None', however in effect the default
                               action is `present' unless the `autoremove' option is enabled for this
                               module, then `absent' is inferred.
      update_cache:          # Force yum to check if cache is out of date and redownload if needed. Has an effect only if state is
                               `present' or `latest'.
      update_only:           # When using latest, only update installed packages. Do not install packages. Has an effect only if
                               state is `latest'
      use_backend:           # This module supports `yum' (as it always has), this is known as `yum3'/`YUM3'/`yum-deprecated' by
                               upstream yum developers. As of Ansible 2.7+, this module also supports
                               `YUM4', which is the "new yum" and it has an `dnf' backend. By
                               default, this module will select the backend based on the
                               `ansible_pkg_mgr' fact.
      validate_certs:        # This only applies if using a https url as the source of the rpm. e.g. for localinstall. If set to
                               `no', the SSL certificates will not be validated. This should only set
                               to `no' used on personally controlled sites using self-signed
                               certificates as it avoids verifying the source site. Prior to 2.1 the
                               code worked as if this was set to `yes'.
```
