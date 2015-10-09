From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 09 Oct 2015 09:21:36 +0000
Subject: Re: [PATCH 2/4] i2c: rcar: enable RuntimePM before registering to the core
Message-Id: <20151009092136.GB3834@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FkmkrVfFsRoUs1wW"
List-Id: <linux-sh.vger.kernel.org>
References: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
 <1444373693-2372-2-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWaeuxxuWOvEUbyBC3QOEH4rFS9ah=WnZWJVv330gDGMw@mail.gmail.com>
In-Reply-To: <CAMuHMdWaeuxxuWOvEUbyBC3QOEH4rFS9ah=WnZWJVv330gDGMw@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> You forgot to call pm_runtime_disable() in the error path.
> I think some of your other patches suffer from the same issue.

Ouch! Thanks a lot, Geert!


--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWF4cfAAoJEBQN5MwUoCm2LbMP/RI1Y62KD5EltjbpVrUzEl1N
8rhmHngen2rjWvzl/k/gu6Tb+rvivUeYC6H2wMW0QPslvOL1rdIhT2ZQaX8kiSiK
LS9hqP+yfuE8ifvZKG3UojYbvKA1iVrt8lKrnebBUTuZqMU75UZehaFKq4Gn3Cdq
gjE4O28f+RFqQ+MYJhpE5ersgnp7py2/xJx2ufgRk4movecpdSuNkbfQHxiWjAhA
cDogubX1ZM3NGOctaegMTDQvW9BJ9e3S8uz849S9W3Z1djHkjXisSCguKQs4BjzL
roOjayacnh7/wd9ByS+dvaHpMZ2Cn0QmW32bAGyC48sTk44gby1um/Eu7Yxs6wpi
cb4V2Ua0p8PJ7fCmxuy/hZnwmecytxGthguKjz7pqUwLin0Rp+VChROSmIW3WURE
bGXrdBBMxRO2qI8By4iPGA18NSnaui9kbSLYN/OzlYDQrlyr9il9gd+hCmr8GVum
dapR3FagkDY9UXh98hMuXhflg9LtlfYUHT4tv1uvTc0fjuyxybFre3G0tGVfrQKJ
0rlLtSBAw5UVi6UY2QuHLZT4fOwigL3FFFEmB3wXcmoNixeIcidHV+AGEwV8UeCb
dlu8djIKMBl4fCsOZGyd+G8wcSJy0fXNLH2SPwpYJ37Dg/13ZcLHxmOZBfB1PAoB
kkD23kW+tZj2tMBGkZ18
=q311
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
