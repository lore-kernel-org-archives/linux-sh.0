From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 23 Aug 2014 03:08:50 +0000
Subject: Re: [PATCH 08/11] i2c: rcar: remove spinlock
Message-Id: <20140823030849.GA1305@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
 <1401263086-13720-9-git-send-email-wsa@the-dreams.de>
 <53F7D83A.5030903@cogentembedded.com>
In-Reply-To: <53F7D83A.5030903@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >The i2c core has per-adapter locks, so no need to protect again.
>=20
>    The core's lock is unable to protect from the IRQs. So I'm proposing to
> revert this patch. It's a pity I hadn't noticed this issue when the patch
> was posted.

Yes, you are right. I noticed a while ago, too, but then got
side-tracked :(

>    I'm afraid this unlock is misplaced, the code continues to access the
> registers.
>=20
> >  	ret =3D rcar_i2c_bus_barrier(priv);
>=20
>    Should probably unlock here instead?

I can check details next week earliest. If you are confident with your
suggestions, feel free to send one patch with the revert and the updates
you mentioned.

Thanks,

   Wolfram


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT+AXBAAoJEBQN5MwUoCm2vLYP/1mjkHo2Bq/AWmDe5ZbLAAqI
J7fhRDrr8u0xMWjAJ1FC/UVO+MyP/OVsA6dIoIT/SYs/D64qNmJf21j6pteoXsHm
bT04EtW6patH+sRTWZfqXpS/k9I/EYEL9bqjcbT/35nTAvBYZwFZJfeANBvDk3Eu
SZdjzEyeV5/kYYYzJWm+ZDTwpNGyy7Yrx9W7lirF20rCOWZW+LGFxheagvrG6puC
m+G3aHg9+V2yXDuRQIb47PicmbI4UCsi3+PRaud4A5+aI1l2hJ2bxbrlxciSExVK
1iH/TRTXFrbjSDzuW1KYB0Y1IFnCYryyLGhRrNJDo+m87wdTJYugYKqJO8Cwqcse
eB03JqYe+RIZztsUISO1FwGng+jUIkBEecB5rUmJD5pyop0XM943EVjXkxe20IS1
m6XNy9nbQ13XP8tfsyP6V6Usjjgnq4HeJAQ4hukRv+YXAmJlv/7b1GrD8u0/6iUP
B+VqnhJjpw1jaxhyNckY6I4xRGotR2T6ZQVSGmhdonIfT/MfxI/3pn01CGWnFQIE
gdS7mDEr80ik8qMPmejXb2RJWrOYAU7jf2Ud02bptxLEuXuxqQ9Tt1PDNDSWpSXX
qyjSn5gPcGWwKvL18TTvfcEavVLqghtZg1uF2a/LSBBq4Kc30xBlUAkKeK16nSW0
E+0uukKh+jwLlVXY58M8
=djJC
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
