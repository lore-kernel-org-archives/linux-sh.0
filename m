From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 11 Jul 2015 10:03:13 +0000
Subject: Re: [PATCH v2 3/5] i2c: emev2: add driver
Message-Id: <20150711100312.GA1536@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
List-Id: <linux-sh.vger.kernel.org>
References: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
 <1436600786-3068-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436600786-3068-4-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ian Molton <ian.molton@codethink.co.uk>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +	dev_info(&pdev->dev, "Added i2c controller %d irq %d @ 0x%zx\n",
> +		priv->adap.nr, irq, r->start);

I removed the address printout entirely. It is part of the dev_*
printout already and I got a format warning from buildbot.


--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVoOngAAoJEBQN5MwUoCm2EbAP/jQWP53m1ymeQJuf6KGHOuIc
JkfcFySdoCOT2HrH2Pw7TtV/jj5Dp7nTkgIYZ9dNCLRXukNrp6l2aooosjHtFmtY
xWu+z4dd55nSm9CAuk5dohvq0I047bL42OZT+whPX5fVzXBBM2fq22LWkJSHg/ZP
bAYIPljFHTtT3CNrNTZp3cuZpAt+jyXXLiaVnlYCpoZbXAnzmVHru28BswL245iH
XVbvKpFLqfQAvfsHOl1HzblFR7S+HHbqipTdvVN5EUTa1oY/uvbO78Wpj3gb4RaE
CDHeLz3hi9iN1uW2xFueyfU+kn+c6nJRgcIfK5AHFBBwUjAaDRk364REJlkEcJjY
jM43d4m5HpXBjE5DAOn30LURC6uYJHiO+OqLErL75dPQKYrfcn1gqexc4JWfbrz0
sa84U7YzzjU618UHBeFRfK90/EzGnEwwwCvm4+LDjDq0/sSJ62Yqa0l8wkLS2fUl
yFbKsiKg0mKZ9VyUtbd3jKPAI59TXiYclJ6yuXjx8gz3P+YarVqWy8Dobuu3A4ma
R9QqTdCqPqWmFi9CDD2QNWWYdoZsvkadJLr9MI1KqKNNZ3FMqUqKxQpFNXvDonR2
LQJGcRE9lwtDGlEtq5xd66rkgZ5H/TJ7SLkaRzA+iWuCSd7IX7uh9a7MkxcDaQFJ
GZWwjEHg9Jycs8bchAjg
=V7FV
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
