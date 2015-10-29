From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 29 Oct 2015 19:17:40 +0000
Subject: Re: [PATCH] i2c: rcar: call rcar_i2c_init() after pm_runtime_get_sync()
Message-Id: <20151029191740.GC8992@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="w7PDEPdKQumQfZlR"
List-Id: <linux-sh.vger.kernel.org>
References: <87oafiyq8y.wl%kuninori.morimoto.gx@renesas.com>
 <CAMuHMdXnMFh5umv=wJdvrcMip+DOn8rYP_3eUTufFw4q2Sr8Jw@mail.gmail.com>
In-Reply-To: <CAMuHMdXnMFh5umv=wJdvrcMip+DOn8rYP_3eUTufFw4q2Sr8Jw@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Hence now it's done again for every transfer?
>=20
> What about moving it just before the call to i2c_add_numbered_adapter(),
> and wrapping it inside pm_runtime_get_sync(dev)/pm_runtime_put()?
>=20
> Wolfram, what do you think?

I'd prefer the latter. Sending a tested patch in a second...


--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMnDUAAoJEBQN5MwUoCm2vboP/116uPGS0lb2dF4qicnIBAUe
i5X3XxFG/AZU36aglT6e/UyueyT+SwxPeub78TeXnLg9kWENFShE9DdLdP+A/5zI
CcwbFoVt6OgCiMGfFQz1QnZcoZYb/hUMHdX+qhRUpkTxwRMl4fCjbsEnYfRkw52g
+3GP3gqqbqXlfVc7myrPssm7OEio2sifJOKe1HJKOdF47dbO0OcS3YDl7BpG2fH1
cYWf073/FM0Nr3EypvpagfUblhuoN8nW57EqSiB5cS/ojbrvEsIMrtTRcmQWXPO8
zqJJvSPSc+7fLJ+D3HWgH8jHeaJtiR4G5wkJvJ7RFJE9gyxXQILiwDUWMExUvnFS
OQy0f1ovLhfk+VGp3k28FpmXE8KoiQWExCAtJS4+CVbF3ki/QcZn80imPs2qCbZk
S6/lL3bSvhqY7iS5I9UVadwkTHvXEmi9X+7r7wgxmGEmJlUlX3+dYxcggbujLAN/
0Qxyh6ayycZZ8sRzrGNWlQw4wWxVgZYibA5d8M+jzNm39gw3g9nGozRHFnWFVErH
56aCPFnEgOoYxOA4dzFkuH2hWhslowWTlmK3EVu/diHL75UNCPEs+7ytvJK+Okpy
EFivBKowd7BVUTw5suzVotaCYUTiWiYPzzzoGWVzyTTLzWDlEHlMU/2/EASysvtm
5HEEOL7SLuhFhlgeY0j5
=Ve6o
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
