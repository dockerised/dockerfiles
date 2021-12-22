sudo -i
pip3 install instaloader==4.7.1
/home/george/.local/bin/instaloader --login=miller11_2019 --dirname-pattern={profile} --filename-pattern={date_utc:%Y}/{shortcode} ":saved"