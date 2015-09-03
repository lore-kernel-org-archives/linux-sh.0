From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Sep 2015 20:40:00 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <20150903204000.GB1574@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7ZAtKRhVyVSsbBD2"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <5464456.UnsMOS3MTx@avalon>
In-Reply-To: <5464456.UnsMOS3MTx@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > So I refactored the driver to setup new messages in interrupt context, =
too.
> > This avoids the race for b) because we are now setting up the new messa=
ge
> > before we release the i2c bus clock (before we released the clock and s=
et up
> > the message in process context).
>=20
> Could this fix the HDMI EDID read issue on Koelsch ?

I surely hope so. I can't test because I don't have Koelsch.

> > c) is also fixed, this was not a race but a bug in the state handling. =
a)
> > however is not fixed 100% :( We have the race window as small as possib=
le
> > now when utilizing interrupts, so it is an improvement and worked for my
> > test cases well. There were experiments by me and Renesas engineers to =
use
> > polling to prevent the issue but this caused other side effects, sadly.=
 So,
> > let's improve the situation now and let's see where we get.
>=20
> Does that mean that, due to hardware design, it's impossible to use I2C=
=20
> interrupts in a race-free way ? It would be interesting to document why i=
n a=20
> commit log message, or possibly in the code itself.

It can maybe be done when polling. However, this might need busy looping
for ~1us. Also, the repeated start handling needs to be rewritten and I
am not sure this goes well with polling.


--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6LAgAAoJEBQN5MwUoCm2ftgQAKaxH3dDVFo5mbyEvWD+AO9c
U6aw+syi1QV0K6mQ5jMvu1Bt139LYwyiCLEOvPNpSndDTi7Kudj9jNCNqvppS7dU
QLphoMiWpdBONutX8UqvO4tyQymKv6afQGb1wwUA1cF652N1L8LHuQFLPyqe9eoP
3F7kyzOnvg3Hmf/y7KjX/kZtEVrEZxtJzL0jqar14sMIfc8bXbl7saCsA9f7jMg+
ASqUEqdQrqrp0FeIa7iLuHMCSn/rgtVURkF8FecjXj/XnyPWi3hOHBOGeDJJZrkK
1GmOMsWAkvruTDqqRDKcq6Kju2iqSVncBWezUs4wWS29RmlkEBhXd4vKXflSPjVC
NyZuLQy2qr8CEp/VX4wMmZPbTCJedcko0Nc2O7xQA6yFhQW+kSyFM3SHP/pMV3el
PyLSRbnQpXJTMswuaFWgNkvCoDjBieyba8cumqDEPBZ1ecyoOyaBZPpOZwhN5Irf
sJeLi1pcsDodSs6tupPkXERRut8JXkHjOc4DjDHV6E6ZG6Oc7uln0BSZTbztPZAU
QA0F+Zyj0KvA4oIaXl5irOt6IM4jK6+46JShAjfFQHpEZ/ENZUGnuJ9TztKIVDcD
h6x4UqKXaUt1NMqYtWvdiu9RIGZfTftcuXNqns0HGn0c+3dXDvsDHxRYNkD+z3TI
Ln7UPJk2rt+39LPkyyIX
=bfBW
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
