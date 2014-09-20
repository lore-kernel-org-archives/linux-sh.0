From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Sep 2014 09:51:30 +0000
Subject: Re: [PATCH] i2c-rcar: fix RCAR_IRQ_ACK_{RECV|SEND}
Message-Id: <20140920095130.GK1612@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x+RZeZVNR8VILNfK"
List-Id: <linux-sh.vger.kernel.org>
References: <2641177.jdYX8POT82@wasted.cogentembedded.com>
In-Reply-To: <2641177.jdYX8POT82-gHKXc3Y1Z8zGSmamagVegGFoWSdPRAKMAL8bYrjMMd8@public.gmane.org>
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--x+RZeZVNR8VILNfK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 06, 2014 at 03:34:32AM +0400, Sergei Shtylyov wrote:
> Bits 8-31 of all registers reflect the value of bits 0-7 on reads and sho=
uld be
> 0 on writes, according to the manuals. RCAR_IRQ_ACK_{RECV|SEND} macros ha=
ve all
> 1's in bits 8-31, thus going against the manuals, so fix them.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Cc: stable@vger.kernel.org
>=20

Applied to for-current, thanks!


--x+RZeZVNR8VILNfK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHU4iAAoJEBQN5MwUoCm2pWgP/jH0veGgeNakfNRbja0r7PI8
FKnBpHBZEvoEqZYm5dmN5xxSZCfXKyjKDb/iO3n5otFZMfvNW1LPA9uOR+TUjAgd
qDIwELE4shyjsKXQ3ag9hjrhvN5WcuxcvsSoJ0nilqcGspHutadsyftIzWxa8qzo
ZbB7XpCQj6N8ygoOZLLzdGgdBT+TDUboSrIw8SB1dKpPl2ecZMMb5bWSSL1T1w2t
N4ZoO+5Hki26WJKKCItROpbSZZIdV2O3Y47taB8ujQpBkxQQwTEHzMYPqTCti3hN
qXypSTeBAC3WwuFIRTv7mymOhnYDUJCnDcqc1ZDz83KkSvTMHSF6n/kluJjQJeQI
8J4ZSfMo2Hzctm/ag8R/rjH7teeftCQN1jlmTKmmdZPLW2nn0dIO74Qsrl8hsMFK
7hGUAdflzop7iC61H3vxB3EOM1J8mJH8+/c5F7NZqI/vbcDMw7I1g3nXGPGdvUW+
5zSze3FSajUJ9lHE6s3ZZCR0dOIpYgZTJVn26DHagempXIHsVhY80G+5hvFGXhhV
s/rV/3/blzKx/sJv6fMEfsLyIt03VyZjP1ThoWjRcf6emB5pfsx/VpxLkT1GmYsk
OI2jviWYyroLi16Vv8oWQuOkG2ndnQLxIllnWyLSMJboW+FNoyC9huTb2XWe/s9j
+QWLMTBHlQYtRSBROylN
=NgBB
-----END PGP SIGNATURE-----

--x+RZeZVNR8VILNfK--
