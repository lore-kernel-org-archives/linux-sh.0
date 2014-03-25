From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 25 Mar 2014 16:48:12 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: r8a7790: add IIC(B) clocks to dtsi
Message-Id: <20140325164812.GE6374@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XuV1QlJbYrcVoo+x"
List-Id: <linux-sh.vger.kernel.org>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
 <1394573078-20767-5-git-send-email-wsa@the-dreams.de>
 <CANqRtoQhi=vgLkYQciJska6XogyiJ1REO6HBOHNsPP3ajbq+Ag@mail.gmail.com>
In-Reply-To: <CANqRtoQhi=vgLkYQciJska6XogyiJ1REO6HBOHNsPP3ajbq+Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2014 at 08:05:26PM +0900, Magnus Damm wrote:
> Hi Wolfram,
>=20
> On Wed, Mar 12, 2014 at 6:24 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > From: Wolfram Sang <wsa@sang-engineering.com>
> >
> > Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> > ---
> > Note: Adding clocks whilst keeping the current sorting is very likely to
> > break a previously working clock IMO. Imagine adding PCIEC clock inbetw=
een IIC0
> > and IIC1 here. Adding chronologically and grouped by similar function b=
locks is
> > easier to track. An example addition could then look like:
> >
> >         R8A7790_CLK_TPU0
> >         R8A7790_CLK_SDHI3 R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_C=
LK_SDHI0
> >         R8A7790_CLK_MMCIF1 R8A7790_CLK_MMCIF0
> >         R8A7790_CLK_CMT1
> >         R8A7790_CLK_IIC2 R8A7790_CLK_IIC1 R8A7790_CLK_IIC0
> > +       R8A7790_CLK_PCIEC
>=20
> Can you please care to explain a bit more about why you see a risk
> here? Is it a risk for typo or something else?

The risk here is if you put something in the "middle" then there is a
chance you might be off, and, for example, mix up parent clocks.
Especially when you need to reformat paragraphs because of too long
lines. Yeah, all this can be avoided by careful review, but this review
really needs to be careful.

> It looks to me that this is just a matter about adding the entry at
> the right position in several places.

Yes. IMO adding it with the pattern I sketched above will make it a
piece of cake since the diff is a lot more simple than the patch I
originally submitted.

That being said, I will keep the current sorting for consistency reasons
but I personally made up my mind ;)


--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTMbNLAAoJEBQN5MwUoCm2McgP/0aYsiHYjWjgYC9DZvxX0le6
tbF6IZjpRlbeEJR8v76oXTISmF7zlYMy5j3bhdm/wrqdI7YTIYOqa94qKKEnAitg
fYqjCJkfRkqDpKk3icObJUC3ev0a3OwHk9gOM+mM3NTnVsHB+BiW90vBUdaNuvj6
d5s7cXqc7O3FAfVszBQ+lwD0EgBZ21QIqe7hRRoXrwZKMa7ZslFeWsC+bJD1ie0W
7Q3NZDsyM0ihvc2xyDa2ehXxifaKZOiDDAUbZ3WoVWEzt3V47jQVBRjX6pc1CZqm
Oab6PYoKiROh+fzwWZn6PMAdYFJgmCnOb/8IzB9W9mV5IrIa7euHD2qDuQBt4rH7
FyXHsLRJgmepl4/H2T/BtudOmSH/QzWPdjvrPm68Kl+C/9rXlH617cJcczjBxSO3
/2SCNs6Kq1iNwm01dBRWIms80Z1A9NxFMtZW2e9BN0SH7FNFeGLKrMbIlgP/xSTm
A6k8ECeJcly98n+SruPXq0KwbVyX8jlatiLmSxk3lHxYTYKoNQVGR8lNyIdvI62s
RFaRnvxgQpFyfEo7Qhlok/Izef9I7Hj74BarILGzMl3ywyfN0oD0+zHbe7tvs15T
LX7rJOCnJ/hT4hG9NKjjUhtbHo45bpG/DhkPP+NIhiuCNu6dggks4WOD80NA1nGu
jjCIR1ZLqO7D1pZn2EFt
=NlP+
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
