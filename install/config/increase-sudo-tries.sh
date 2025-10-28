# Give the user 10 instead of 3 tries to fat finger their password before lockout
echo "Defaults passwd_tries=10" | tee /etc/sudoers.d/passwd-tries
chmod 440 /etc/sudoers.d/passwd-tries
