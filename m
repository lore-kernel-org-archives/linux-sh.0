From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 07:23:03 +0000
Subject: Re: [PATCH 4/6] i2c: sh_mobile: add devicetree documentation
Message-Id: <20140502072303.GB2647@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JYK4vJDZwFMowpUq"
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
 <1398896470-24663-5-git-send-email-wsa@the-dreams.de>
 <CAMuHMdWP8KH=6OKmBbA5UqixV7mdKZdEhFw8Tq_XZLaJCOQ07w@mail.gmail.com>
 <CAL_JsqKgwKjag2hRSaDwoejuXRDxDgWwtpnS1gijQbVo0h_MjQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKgwKjag2hRSaDwoejuXRDxDgWwtpnS1gijQbVo0h_MjQ@mail.gmail.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2014 at 08:02:10PM -0500, Rob Herring wrote:
> On Wed, Apr 30, 2014 at 5:32 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Hi Wolfram,
> >
> > CC devicetree

Yes. Thanks, Geert.

> >> +Required properties:
> >> +- compatible      : "renesas,iic-<soctype>". "renesas,rmobile-iic" as=
 fallback
> >
> > Please also list all supported values, so checkpatch can validate DTS c=
ompatible
> > properties against this binding document.
>=20
> You could add this pattern to checkpatch as well. I really wish
> Renesas would follow normal convention of <vendor>,<chip>-<device>.

The binding is already applied and this patch just adds forgotten
documentation. Can we keep this documentation describing the current
state for now and discuss the binding convention seperately?


--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTY0fWAAoJEBQN5MwUoCm2RyoP/2L+CoXhmUTPaniA9VXP2Ldo
IKXVEsNGg3TGB4OsZxJ/uAAM8fji/IJ+a9ls2IZRLj1msHa8f5M511l9LinyWdhS
c4wVhaUp0Rh/wV2YPSPWYDqOTYU6X9nRy0Wqumavt12xYoquruh+Xb80gFOVmLyT
tMX5xgml5W/sjBAGubXOi0Yk8/9ZmUar5dOUdbvs848QHDPKQ48gMM77hAksjerm
2IaseiB+uV95WGjhwXx8blfz33qrFkUEGeNl1PLJSy8/ekn7wiKOSi7BuDKSqjaq
qTQl+7TD3ukXHEMovqX6sqC/kiCsNHa4FsiWVUyCV7rh2c9EOU4aG/TtPI+NpKK2
ZwxetR2WFKmkFIqnikYhZD+0OjSl5Edb3ivuV1IMmY8gyBSuZZJTDzUgcuDF/Xt5
NDK3I5/JsQ1BnlVkw9WhUbBM1To22XTvEyt1bHHK5fqLKJIrBC2hEPs5vbCfyP/f
bnomsR0zk7mX8ZJ+ag+3M862Fd72Yq8FMQNjtorRny3d4oH5lLO42Y9cg+709EHd
pMui2Mstvy7ScOIiNDh2AXxUTuMSSxV9GYtV5EYILHFLttIRAirgglgETEllCnVt
jfleswZSC9yJeQQiBrEC/uoMr004ZIRoJTZ7Y/xU0/IV+8iQ0Z4BGbAhYcP5R52c
75CqO1pPPREA06g9MUNx
=lQun
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
