From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Sat, 28 Apr 2012 15:30:43 +0000
Subject: Re: [PATCH v2 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <1335627043.1917.4.camel@koala>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-r9+4jDIelZ3xpBckAsQb"
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
 <1335626773.1917.3.camel@koala>
In-Reply-To: <1335626773.1917.3.camel@koala>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org


--=-r9+4jDIelZ3xpBckAsQb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-04-28 at 18:26 +0300, Artem Bityutskiy wrote:
> On Wed, 2012-04-25 at 16:03 +0200, Bastian Hecht wrote:
> > changelog:
> >   - extract the iounmap calls from patch "Add support for error IRQ" in=
to a new patch.
> >   - swapped patches "Add support for error IRQ" and "Add error IRQ reso=
urce"
> >   - corrected an indentation mistake
>=20
> Unfortunantely, I cannot build-test your patches because mackerel
> defconfig still does not build (mackerel_defconfig). Any suggestions how
> to work this around or any other defconfig to use?

If you send me a temprorary work-around patch for the build failure -
would be fine. This patch does  not have to work, just make the tree
compile.

--=20
Best Regards,
Artem Bityutskiy

--=-r9+4jDIelZ3xpBckAsQb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPnA0jAAoJECmIfjd9wqK0h8cQAIk3h5uxfHajo9yFVWnXVv4t
15IoqLPCsjC8nsHvK9iZEXF1dXEG5qG6+lzi5wFveqZH4/69DezWjtOJqxk0STth
XNegXhkXN4g4GGrCeMXgEQNEOHIav+yyLqJNl8S08ahoIFujbEtaIsa2jDIZlW5R
qweLhKkJI24Y/9wH2iaIZpvbswAsmBE6bokn+wFjRtW5bjJRFVu9yVNwzos3VIhc
odrT67Tgg7cMKJC4/bN00eWJykhYsxg2HNHBBDyiM75QLtHTf665A8Xp4FjxyWd0
vSKWmjeT5HcAZd3IH4/rhqy3COmY+zO1LXbeVAlq8ilXgoGzuEnm0WQDFLqrOrKR
URMLomwhoxVLpNCuJoCI8AyTzbkbFV3IrSII5+JmeCbrUF9tdl0Hutl4FFC1SPpE
tq6yYe4CLRjCcSPms+xnWLHL9TMi0aWct1HgMnRoim2dMuOH7PP9YgRQ/iKidBNV
QMyoJ09x95BY638zxwpnjCZrkf8UvZfoX3Czt28v1HrMBbWGozGfNfobfeR+p2lS
gtwoR48L38h/N6cpIS9vuOHOkOpJKh/BU+gMTP7IwP87vWuuL4dqykNgLcqqM58U
heFnPwseUJv9Kq5IA9ZwrItmqkAd5I7DmhE6nl345I3e0lxMfUXFuKdjAHv5KoFn
+9yQp9Oy6d5ORi8M+S4e
=c9YV
-----END PGP SIGNATURE-----

--=-r9+4jDIelZ3xpBckAsQb--

