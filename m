From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 29 Dec 2008 21:36:34 +0000
Subject: Re: [PATCH] sh: maple: add support for the Maple mouse on the SEGA Dreamcast
Message-Id: <200812291636.36303.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4704389.aT7T707mOG"
List-Id: <linux-sh.vger.kernel.org>
References: <1230578246.6496.25.camel@localhost.localdomain> <200812291602.18572.vapier@gentoo.org> <1230586215.6496.28.camel@localhost.localdomain>
In-Reply-To: <1230586215.6496.28.camel@localhost.localdomain>
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: LKML <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Paul Mundt <lethal@linux-sh.org>

--nextPart4704389.aT7T707mOG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 29 December 2008 16:30:14 Adrian McMenamin wrote:
> +static int __devexit remove_maple_mouse(struct device *dev)
> +static struct maple_driver dc_mouse_driver =3D {
> +	.drv =3D {
> +		.remove =3D remove_maple_mouse,

does that really build warning free ?  usually you need __devexit_p() in th=
e=20
=2Eremove assignment ...
=2Dmike

--nextPart4704389.aT7T707mOG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iQIcBAABAgAGBQJJWULkAAoJEEFjO5/oN/WBiEMP/AiKIeT3N/TrTcJPgYeUfBex
qVLMOq+4N+tuVlgV9RdqX//1feVWM2EKJ9gVAx8+zwOLkuZgPmAKSqVPfYxni04q
2jBFIcvzMMFpfqo7GbKv9c/kRJFNg2Ec8BTiIqYsHtlGPhQvSCLxkMib8up8GHX9
Acerdx3C/rTnWdz5PofgfrDGgMtE8qmYnPurJJCoDCBWMaOQw3tSRaAZhvQ3DPdG
QxoPL7xPdBH+Mt3QcAeN1+/LduiM8l8tXq+Om/awpo/8VcWUrulZaMUpLb0094M5
H1alPqGfghw9oE9RGPfnI/VEkz+70vcIEJ7Z5eQjEdDMN7mcSW4cPo+IpnqpVgKy
rxDG18SPeOk6hgOqi3nQU1LV6OVWa2leOHpct2w9T2ODG9Pw/ipT7p1USBs9vBui
yf/kXl2MUbsRdPqcwWDwo7CHiRJhlf5WvLkJ+QyEourtgMRdCZDn1OJAoe0U6b+v
0A7fq5sZaqRDFZF8mto6MRhLmTu4gpRdv+TPk4xt8FuDJYEcXVMDT3kk0/WU92mF
VIugXPYdGlC+T7XV2nUc8GMYxIixX0SuSYw0EmJT4qg9L18CyGsnzuYTegvknhk7
VTbu/rT4dhQ9hsIdSWMeMdm+AVvyAAohzvblPDRnAVovBP95cq7C18YeyrIzkjDP
ecLO9Kxi25iTvsOZxZzw
=Hcx1
-----END PGP SIGNATURE-----

--nextPart4704389.aT7T707mOG--
