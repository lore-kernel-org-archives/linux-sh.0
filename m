From: Mark Brown <broonie@kernel.org>
Date: Tue, 04 Feb 2014 18:43:27 +0000
Subject: Re: [PATCH] regulator: gpio: bugfix: add gpios-status for DT
Message-Id: <20140204184327.GS22609@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0Cw7BmXaMEMLlkEt"
List-Id: <linux-sh.vger.kernel.org>
References: <87eh3o7mfc.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87eh3o7mfc.wl%kuninori.morimoto.gx@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org


--0Cw7BmXaMEMLlkEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2014 at 09:25:14PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> config->gpios[x].flags indicates initial pin status,
> and it will be used for drvdata->state
> on gpio_regulator_probe().

I've applied this, thanks.  However, a couple of things that it'd be
nice to improve with followup patches:

> +- gpios-states		: gpios pin's initial states. 1 means HIGH

A mention that this is an array of values would be good (it's clear from
the code but not from the document), as would saying that the defualt is
low if nothing is specified.

> +		if (proplen !=3D config->nr_gpios) {
> +			/* gpios <-> gpios-states mismatch */
> +			prop =3D NULL;
> +		}
> +	}

It's probably worth printing a warning here.

--0Cw7BmXaMEMLlkEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8TTMAAoJELSic+t+oim9W6UP/3PDE+LPAIdzs3IBanyL823M
/+Jty5iOx7QATH17C5e/RDvk3CKFTGHE+8AqtJnF3GogJzQ8DGI4kjJ41ZshxSNA
6b6d3QhLU71DWYc1VBINqpFIJEIZricE/wNTsgLDLvhwVjYd4ujwds+YSLLHIcSG
s6V2bkll5owymtibpYZteAr7wbTOt9/yZSuysxTYX/Ry0AUA7xvTn0UEy0nJ7gv+
BbinLY2tLqoR6fjdiEZZDbosZb1MSj09bKpAL5cAgukTkqZFyJtvfhEkrOxMZgml
X4EfbcihiPIijpFeeRPhyuj9dyY5SflfgWkVjdLaDpLeAIM/lMhA+cONj/i8SnPM
wmUiIVcm8el99YrjXTup9M2f7qRsan+TeEAsM5RVwZTU8A4CGdVh1BRVMG2gsSE4
3ucfPXyL0eea+aOWDUfKD3UGWomm6d6gXZ+tjve85Z5ZhJPNon0mI+VYinVSLKPu
K7FoUraohY9ZKbBMwqyhIHAf5Hr265T2a2/q0zRms5wMm8XLdb7y8vHfSns9DdIz
WXA/cdKYJ+ogeyeI8Ymw25Py4Gsedlddi4k7lwN4KIJ8JjKmogneDpuaQCvTv3UL
3QymemnNj9ttgDVXryQXTSUfWmTQvEgfjyJrlMUmPy8tyBUvjM2oiuq8dGcLjaFl
ZR1DBIay4JW9EWNPcz7N
=yvkP
-----END PGP SIGNATURE-----

--0Cw7BmXaMEMLlkEt--
