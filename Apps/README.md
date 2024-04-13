Installing `Droidcam`:

1. Create a password for the security boot menu:

```bash
sudo update-secureboot-policy --enroll-key
```

2. Reboot the system and choose "Enter MOK key", and use the password created earlier.

3. Run `make setup-droidcam`

4. Edit the file `/etc/modprobe.d/droidcam.conf` with the following content:

```bash
width=1920 height=1080
```