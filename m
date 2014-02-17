From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Feb 2014 09:31:26 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
Message-Id: <20140217093126.GE2633@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="maH1Gajj2nflutpK"
List-Id: <linux-sh.vger.kernel.org>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
 <20140217091900.GD2633@katana>
 <CAMuHMdV5KNBcFh5E0bKaLNboZUbuXmMkzdYozqWLvro7Kwjhjw@mail.gmail.com>
In-Reply-To: <CAMuHMdV5KNBcFh5E0bKaLNboZUbuXmMkzdYozqWLvro7Kwjhjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--maH1Gajj2nflutpK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2014 at 10:23:31AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Mon, Feb 17, 2014 at 10:19 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> I think the tricky part is when a driver for "renesas,i2c-r8a7790" is =
updated
> >> with a new feature for r8a7790, which doesn't necessarily exist in r8a=
7791.
> >> Then the compatible entry above will cause breakage.
> >
> > If the driver is updated in that way, then it MUST introduce an r8a7791
> > compatible entry and make sure the new feature is only used on r8a7790.
> > Otherwise it is a bug. If this is adhered, we won't have a breakage
> > because the specific entry (here r8a7791) always comes first. Or?
>=20
> That will indeed prevent breakage. But in the distributed development wor=
ld,
> the person who modifies the driver may not be aware of the r8a7791.

Then it will break even with a seperate r8a7791 compatible entry as
well, sadly. Currently, the only thing encoded in the .data field of all
compatibles, is which generation of the core is used. This is the same
for r8a7790 and r8a7791 (this is why they ARE compatible ;)). So, even
in the unlikely case of an r8a7790-only-feature, some code/reactoring to
make the distinction is absolutely necessary.


--maH1Gajj2nflutpK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTAdbuAAoJEBQN5MwUoCm2DtwP/jbtWEpwm8Hnm3Lv0SP77Ro1
uwN7jw1j6HzDcO7sSCXEOKaIUi7O/63SKq3n2JYFqh+q92rg25FoLCv9AoxEbtBL
zc1LHnwwGu3YKudaJ3et0BUspPOUdEHRbRTr/lFbdpKXyzWBt8eobHr2ASCn/4IC
Ru/VOGzp3ejHze4wKB/p70kylMRdg4bD+HWeK9N3MBO9Mxp6McHn/D8ExDcxQDus
fkoEY4yD2eAKdbj6EQNmVbudR5K9RhavI7N3gFhPFUHrRQFRzr7H0jk+9Gto2HgM
4rGC6wJQsO93GtiRz/Hps5NDohP2zv2lIZG++j5YYJvjlE/gpYBOVo+Ffx9+XYfy
NeW6haAoz9uGIVEK6mMAuRdtY1WfL8Wt8p4Yf85Xgb9Xqm/ntFhexGWvFLy+ZR0g
PVLYsuyW048aOAmPFC4oi7E/wXKoWMta9GtLzoLaofrOnpFu9kz0qR+OC4cIyO5g
g0dNfBnd8X+fpVlIe/wu3WXhrfFv9QsCabOvh9Lx0QtC1NSs5pzOJxQr3Ng3MZCY
78HZSv1InjFgzHMytwPz8Z3eidGpjSeOTp1hG338+BhjU2YlMeNM/+cOPEbFMhT6
Iq7jgvG5wy/PAYGL/Mhz/+laX3ckC2yxW8JviPJveGoXJk+g/O1kW8Ibwkh1Ru3V
oiqblnJOa8zscjwklEs7
=4bUY
-----END PGP SIGNATURE-----

--maH1Gajj2nflutpK--
