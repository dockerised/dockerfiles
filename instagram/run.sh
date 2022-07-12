username=$1
sudo -i
pip3 install instaloader==4.7.1
~/.local/bin/instaloader --login=$username --dirname-pattern={profile} --filename-pattern={date_utc:%Y}/{shortcode} ":saved"
