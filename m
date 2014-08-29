From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 29 Aug 2014 10:20:54 +0000
Subject: Re: ARM: shmobile: "i2c<m>" vs. "iic<n>" DT nodes and pinmux
Message-Id: <20140829102053.GA3366@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com>
 <20140812214723.GA3443@katana>
 <CAMuHMdVVKOS=o-KSx1q05y_sRx5RcOMiUg8mN4fGM=UyGv1uog@mail.gmail.com>
In-Reply-To: <CAMuHMdVVKOS=o-KSx1q05y_sRx5RcOMiUg8mN4fGM=UyGv1uog-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2014 at 09:19:43AM +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Tue, Aug 12, 2014 at 11:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Tue, Aug 12, 2014 at 03:11:18PM +0200, Geert Uytterhoeven wrote:
> >> On r8a7790, DT device nodes and C/DT pinmux data for IIC<n> are called
> >> "iic<n>", with DT aliases from "i2c<m>" to the "iic<n>" DT nodes.
> >> On r8a7791, DT device nodes and C/DT pinmux data for IIC<n> are called
> >> "i2c<m>", with DT aliases from "i2c<m>" to the "i2c<m>" DT nodes.
> >>
> >> In light of the proliferation of other members of the R-Car Gen 2 fami=
lies, is
> >> there a plan to make this consistent?
> >
> > The 'i2c'-prefix describes the IP core handled by the rcar driver. This
> > core is named i2c in the datasheets.
> >
> > The 'iic'-prefix describes the IP core handled by the sh-mobile-driver.
> > This core is named iic(b) in the datasheets.
>=20
> I know the difference between i2c and iic(b).
>=20
> However, the DT device nodes and C/DT pinmux data for iic(b) on r8a7791
> are called i2c, too, instead of iic.

Ah, yes, now I remember. They are called like this in the datasheet. If
we would stick to the IIC ones, it becomes even more confusing, because:

IIC3 is I2C6
IIC0 is I2C7
IIC1 is I2C8

and there is no IIC2. Plus, in the Koelsch board schematics, the DVFS
bus is also named I2C6, not IIC3. So, I went for that.

On Lager, I also wanted to go for i2c4-7, yet I was convinced to use iic
there. I forgot about this inconsistency. And I have to admit, if we
look at it per-SoC, I think the current solutions make most sense. They
are just not consistent :(


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUAFQFAAoJEBQN5MwUoCm2F/sP/2Zs8FXzSQ7tQhXI7jxz9g5e
wwxr5ySd064Z5NRoaPL1oWLtOdEBvi6Ax/T3SYs4w/xZbRes/S/Weg+LEWZdxpHJ
aG9RvpyVamKmYb1wYM0yr5Dith+SiOgMjBadip/0nKjw0TJRTui8jx3OKu8lesHb
pJtQ5YAHl0QTlrKsRugeqgrh9ceJ/60TSQkrgGsgO2Cn4/o2RI2R93ND6u7o3zU1
G/8uvn8SyJh7wqMYKABn3Ic+EZO22bF/EjAG9ipRs59mzNwIczWfib+9TNMx8EjB
1eMhX+l1hHIOiRkGVuCeoEjdJ4QmJUISp0TSsh+zcoj6hvxIx32wq29LocB0oNcf
sKuoCEkElTqB3lK+YdIJSf64QGcu+5HWc3o5Fl6oVYBnk7G9RsIBCFAlDLiL+nkQ
crmocZFQJHoRwk26QJYc151WGNWEO7VBdxrJ1t4PRqgjjYsmarpA5OmnGCRGmNvy
Q+s+QGb+cNjK3ly1Jfc8OM6d1CNOe+qUjkRRrVGabR3QeFD8vUcz6pjAJ5gKoC1v
GYicEzq/9ByM60ZRqu8ey3OxACgKPAYsipXm4Rd03zYLW+C22CWi1BLcx07fonBj
7fcgDKRDqRaofncjw+3HhER8v8p7G7MZWc/SZBDLJzp5wNqwgiwkd8lvsnwjcDoQ
Wu2kPgBIWPSbwkvZCJkV
=+kYP
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
