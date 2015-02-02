From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Feb 2015 09:37:29 +0000
Subject: Re: [RFC 2/5] ARM: shmobile: r8a7790: add node for rwdt
Message-Id: <20150202093729.GD1058@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="uxuisgdDHaNETlh8"
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-3-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 10:34:52AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Mon, Feb 2, 2015 at 10:15 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Mon, Feb 02, 2015 at 10:05:37AM +0100, Geert Uytterhoeven wrote:
> >> On Sun, Feb 1, 2015 at 3:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> >> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> >> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> >> > @@ -123,6 +123,13 @@
> >> >                 interrupts =3D <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TY=
PE_LEVEL_HIGH)>;
> >> >         };
> >> >
> >> > +       wdt0: wdt@e6020000 {
> >> > +               compatible =3D "renesas,rwdt-r8a7790", "renesas,rwdt=
-rcar";
> >> > +               reg =3D <0 0xe6020000 0 0x0c>;
> >>
> >> The RWDT hardware block also has an interrupt:
> >>
> >>         interrupts =3D <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> >
> > Well, it is not used in the driver. I'd suggest to skip until it is
> > really needed.
>=20
> That doesn't matter. DT should describe the hardware.... perfectly (stabl=
e DT
> ABI etc.). And as it's a standard property, we don't have to think hard a=
nd
> invent a good way to describe the presence of the interrupt.

OK, will add.


--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUz0VZAAoJEBQN5MwUoCm2lRoQALFrioa+Ug6zbbY7MwQO7Yuc
3ogWyc+Zlvy+9Y+NOHun7P/okW7RNmh8Sq1V7XW3tWNudCh8rNen+J+oGaZyd9Gx
FstVXqxyKhQ1HDF+56z8HoM7Ok0t8gBOi7/WHKO6e1p4iJ7kWmjD9XZy+u5CbLPc
s22c9cGdg6fi0Oum63IWAXhlT4OvkrA/a2sKjGzgOlCC75Kv7d90BayKDPQUJgkP
0AEhV9Rg+q1P+vky+nBukaexHUxtQxwthC0Cub8VptV8nrrFXYi3qsvyRc5xn2lQ
Gc0CSwhplyopVMex7KHehq+9k5St5HYuFPIaa4hoCPOzbllEC8BCtJYN7zm1UtYx
l8uNEWStfVFEM4FU6tmrFfIa4ivgrP9EKuMg2YpApVXvloIgc0xSlMGXnL9lch2x
F0N0OPMeWbG0jhqkIB7WMKU0ImIHgIj8srtem+TLTOY0iC18jMOkdSua7+KnQMju
w/z+7KOAjsB2MMes9JcIwqQymDpD+k9MFHV4Wd+hhqnK9V9ukMRkj0oJTQmg7EiL
C2joMgP1SODdII8iu55ZzPBDTTwQOWZRGTMGEnEzwDUamGUdBW5lfDoNwQxhE7fj
i+CYdYa7vQ02a8zNjiCHrRiBiB0vGPXGZH/LqolBZ+9IkGkrjQvHRxTbaioepRMS
qvzBBklKRgDUiL+qeXzW
=yf79
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
