From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 22 Oct 2015 11:05:05 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <20151022110505.GB1572@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <1441311613-2681-6-git-send-email-wsa@the-dreams.de>
 <131418014.1WnDGNUZcn@avalon>
In-Reply-To: <131418014.1WnDGNUZcn@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2015 at 02:10:52AM +0300, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> On Thursday 03 September 2015 22:20:09 Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > Setting up new messages was done in process context while handling a
> > message was in interrupt context. Because of the HW design, this IP core
> > is sensitive to timing, so the context switches were too expensive. Move
> > this setup to interrupt context as well.
> >=20
> > In my test setup, this fixed the occasional 'data byte sent twice' issue
> > which a number of people have seen. It also fixes to send REP_START
> > after a read message which was wrongly send as a STOP + START sequence
> > before.
>=20
> I'm afraid this patch has been found by git bisect to break HDMI on Koels=
ch=20
> :-(=20
>=20
> The regmap_read(adv7511->regmap, ADV7511_REG_CHIP_REVISION, &val) call in=
=20
> drivers/gpu/drm/i2c/adv7511.c returns -ENXIO.
>=20
> Reverting the patch on top of Geert's current drivers master branch fixes=
 the=20
> problem.

But HDMI worked on Koelsch in Dublin??


--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKMLgAAoJEBQN5MwUoCm2vrEP/iCOmhvwK1fcHkLNk/dQAL/9
Q9tvVtL2CCOPIZEBIxZHENCuJVUTxhOqx5AJtf1Nu5ZSMXkL9fajmzjZrMyN6aXA
aYORWvmqb97WXfZSzOOiQO5/0/cexnzx0eSaiNHp82jxfYP7wmgJeEjTzytg66oC
/mIdXnXeVSPlyZRw1P2RhAoHUBBcZQnD4v/sPlMy/7dUiMcyy65OsIQOqxEAJhZ8
RNLnvNufG13OQgGM9PXYKz5NZfhaKfJM+S+7/5GuMTvzO1XV/7550qEYGTv0mEMo
x5kwQBCfZTJyCUGGak0Bj++tm/x2QrwWzLe2wvy5bDrJqIeA3RP6PxDqoXXHaTcG
naxvauDppUjEWcXP54v39IXkDZr60C4cEEW56vHBHtMhJC5g0kpCf7eE7BYLaAHS
3VtWMIQSwDs3hxzc8lT1ANCWxWOk5eq5ZtO6/Z0Az1t0tOtZpcIZw7fphyXlKr1z
CMcXR1EKkEBbO8emnco279BVKRDk+tiH1HAsPWROSael5/unGzTl7CpQ/6+qPYLS
eWEDdJXCYhO9fVf3U8Oq4cxOpnCOdAHr0gC4bnscZ/tco7sSmCbhUO9fatUPasI3
f09lzUAj01SS9bRdUsxOcEFIrMnxm8bPRpATh24/m2TZddeVPMmItnVyveN6kPrm
FtmZihCii7+eicjroB2Q
=4Lcw
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
