From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 15 Dec 2014 14:50:29 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141215145022.GS16827@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SdvjNjn6lL3tIsv0"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <2462101.Er8OZg9N24@avalon>
 <20141211214732.GC21482@katana>
 <1729516.HWbfnj3Cpn@avalon>
 <20141215064306.GN16827@intel.com>
 <CAMuHMdWsUkQN-+h07Zf2snbD9bEw49_+rasY4zS8QcvqA+aXUQ@mail.gmail.com>
 <20141215091314.GQ16827@intel.com>
 <20141215094533.GA3510@katana>
In-Reply-To: <20141215094533.GA3510@katana>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org


--SdvjNjn6lL3tIsv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2014 at 10:45:33AM +0100, Wolfram Sang wrote:
>=20
> > Quite right, this is a good question. Today we cannot distinguish betwe=
en the
> > two. Should we improve the deferred probe to tell us when the init
> > is complete and all the modules have been initialized? If we ever have =
such
> > a mechanism to check then we know no modules are to be inserted then we=
 can
> > fall back to PIO mode.
>=20
> Well, the user can load modules from userspace. And I could imagine
> there are people wanting to defer things until they load a module
> manually. And surely there will be a case where, for some reason, the
> deferred code has to be built-in. I trust Murphy's law here...
in a dev system yes, but in a production system there wont be manual step!

--=20
~Vinod


--SdvjNjn6lL3tIsv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJUjvUuAAoJEHwUBw8lI4NHy7cP/3pjT1M3yGT0R8QZfbp9/LR/
eGFicsfJvqXvLj30adWctO/fWuirhGm3srjDN5Of2fptxEFTrEbY6L80JhY48zXo
W8eFJKNZc3GB9CAI0AXBz1B6mp7vpIOp5DtEIYrCQj/WNqww1jAsnOUpWbTtr28Q
IZtQzOyVpUtRm2drkR1fUpHzepcw8C2zbK6kWME7RbuXTjJKNMNyQbLqvLMwvr1R
ytkL9zyaGg8UYJMqFQ4q2yM/zqvj/WPShQMImhMI/hMWbf2tpe0GlQl4zjvlczrv
0E7zIHwpq58T5zqSUHgYYIQjgiJPe6GBoDOqi6W/3CpwITK33IUUdlN3bViLkltD
CS3mXeBaH2TcfFacjJs7vxLGQLgCSuGHUdS0rOQDGc42E42c0t88BDDsE8faQWzi
jeTmha90TrE4/SQ6MmnVTaXaDlX3rDHzJDrMLOqzRCt3mNjUdDziUhyCj/pas83L
5lHsFQlkWVow4Peqv647BjunwMoq8/S3Om/eQbcTFo0MLt96Osrt0aOB/qIghMjl
U+37yqI9k9yw0TvT6qZaLpOAepPE4oN/cwtSAZ8aUZXbXRnUxUEoDaVa/Vmu6vi+
iksXt8iicCNUaMI9ppupTOE0whWIxBBeCWm0008IdzAh0Zl++ie3vIoo0wILzEo0
PF4VqNtAoEdZ18ljyYgJ
=USSY
-----END PGP SIGNATURE-----

--SdvjNjn6lL3tIsv0--
