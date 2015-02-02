From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Feb 2015 13:24:44 +0000
Subject: Re: [RFC 5/5] watchdog: sh_mobile: add driver
Message-Id: <20150202132443.GA1994@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	sh_wdt_start(&priv->wdev);
> > +	sh_wdt_write(priv, 0xfff0, RWTCNT);
>=20
> Is there a reason to set the counter to 0xfff0 instead of 0xffff ?

Giving serial console some time to push out FIFOs. But yeah, it is an
arbitrary value.

> > +	priv->restart_handler.notifier_call =3D sh_mobile_wdt_restart_handler;
> > +	priv->restart_handler.priority =3D 192;
>=20
> Just for my information, how did you choose 192 for the priority ?

Assuming DA9063 is 128, then I wanted to give this priority since it
doesn't need I2C access which might be stalled.


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz3qbAAoJEBQN5MwUoCm2tm4P/0Y0BdRN4JDubwQK75RzAnDZ
+z2hh2uL6juLmWpDCdcLTSyRiqIT8s+cuttXewl7cQrXhkuVmtvDDgYZrfgcTJ/g
XipY2sn0/GDs8IdlrDB1HrXe9/0eOGdgSI1SW/5sYAbpUoVFmYqG0CBalm+MiQm3
xkaFehy3wWiUz90sdXraYom3itIUHhuuNfaHzvAuO6EI893Jmnyu1MY+cb6N+rlZ
s1CYgN4i05GUzPD5F2HGn1fE4Iw3EvOrV83YEVxlxkpyuqjLJuxwiKY0m37VQBgA
GXpWkCGq+FxQZMzLJVDlgNVEt4ztbRDAfrlVa3M8qsRvmke3XSOVGTYY+qWT5Pds
6+aYMAuL2HnMhdov4v0SEiiFB6Q9W0IhnGnkH5GlDygIK1RzURE9CHZdmYIamMq+
e/WZ2CgWmT/oLaIa1X9EL66GS1aDHQgJFC9zuNjwUVtATjYrVSdCxN+RoHy9aHT0
T9n/nRRElTmfqau5cVxCZBd26QH6nMlV+4m3cRGJ9ImxBNmAZiOVl3abwKWDcumF
9BDK2dPuVuygYeBDgWYuIl7VvuceS5ZWJBl3/v6UeiNGX7i+FE+mrh0RwLXQWwUo
HfWZRN89bULngOWG+hpI0xVdl8AyZNQIgg8RcWBa84qYQjH9kJjsFBbQIRQO8L9w
BLfQgnCdx/3cSgY/jxbr
=Twnf
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
