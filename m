From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Mar 2014 19:31:28 +0000
Subject: Re: [PATCH 1/2 v2] ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <20140314193128.GE366@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Mpco6AjI66RzYq4w"
List-Id: <linux-sh.vger.kernel.org>
References: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
 <87d2hpppk3.wl%kuninori.morimoto.gx@gmail.com>
 <87bnx9pphk.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87bnx9pphk.wl%kuninori.morimoto.gx@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon <horms@verge.net.au>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>


--Mpco6AjI66RzYq4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 05:56:25PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> SND_SOC_DAIFMT_CBx_CFx means "codec" side master/slave mode.
> Then, FSI will be master mode if it was SND_SOC_DAIFMT_CBS_CFS.

Applied, thanks.

--Mpco6AjI66RzYq4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTI1kNAAoJELSic+t+oim96lwP92HLRuGhtiSxkLwu5vbKd/Kb
IHCpRoDom1xnys0h4YVxhrrHNfh1lYSnqjQmwwwY4IvUoWzW3qlJ/Es3CNL9P4qs
eh/ard4iDQaUMck8Lpadfdiy83ZxypNZr2S+P07MUblWn3/lQKOAuj4oSPetIXzj
hN24jiPY6WfoDfEt09YvPaL2N/88v8StJxvYvXeo/84Cu6DOpOMCzh0n2M4/PsbX
Ww4YBLQLzaj8UoxkQ9a7pNRcuGBIjReOFn0tcEwPFRXxmqJ0BRKocZzloCGTYaCJ
tF/HbuukUvuXG+1ksRP2UOEfpO7jaCcWfts4ckMbxFGXAssdKKhWy8yik19MXYO6
mD6zdYWb+EPn3gJZVRFG1o1VdHJyiu6atFvwx042VdMJcRCaYYox7CScy/rmCSqb
TS6r9vs8IaF70ENDkRYjZQcbGyKzhdZ7+8rZYkESPsnvx7fa66qRmYt4t+890XTM
WdtWCBD9DKfrbOB7v3jA+pzZD6NItD9Vit2PCD4wEBjVrRIUH6P9NRoPQblXFUas
BWHFXW5liRrLqIr6YqJ/TRZPNKjfBUTyCzm6MPsaN8WICJ9phS1hgJtveNQimE28
zReLKTNj0mfkPud5o1RE2GQl/ZefnaegpCKJbS3bZzO81Z4r9tcC0KZKkja81bVZ
sUwjNddNXtOqzVzaNMA=
=/cbw
-----END PGP SIGNATURE-----

--Mpco6AjI66RzYq4w--
