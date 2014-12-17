From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 17 Dec 2014 08:59:07 +0000
Subject: Re: [PATCH] i2c: sh_mobile: I2C_SH_MOBILE should depend on HAS_DMA
Message-Id: <20141217085907.GB2919@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XF85m9dhOBO43t/C"
List-Id: <linux-sh.vger.kernel.org>
References: <1418650624-28174-1-git-send-email-geert@linux-m68k.org>
 <20141217065814.GB1018@katana>
 <CAMuHMdWShh+m_0c_3cnGt_2J03u0dhWytER0AqLWoLtauEh5aA@mail.gmail.com>
 <20141217083905.GA2919@katana>
 <CAMuHMdWoNxZ_gKWntANTn+oakJfVwY9np1cKs-sXoOf3vpS5Fg@mail.gmail.com>
In-Reply-To: <CAMuHMdWoNxZ_gKWntANTn+oakJfVwY9np1cKs-sXoOf3vpS5Fg@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> If ARM and SUPERH imply HAS_DMA, that formula is almost identical to
> the one I proposed in my patch?

Ehrm, true :)

>        depends on HAS_DMA
>        depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
>=20
> I just prefer to split dependencies in two lines where it makes sense ("h=
ard"
> dependencies vs. "soft" (user platform configuration) dependencies).

I prefer my version slightly. But not worth the hazzle, I'll pick yours.

Thanks!

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkUXaAAoJEBQN5MwUoCm2fy4P/Re36/47sQJzKrum7vh0nsyw
rq+JdDJXbeNhTsCPauLlzeoo5dY+d6Uan2JFR+TTy7lshMgkP2rLZK9LiOhFglSS
zNO+z5pm3PxIg/PYMlW/zo9sRScfIO1HuK0vIggLC+tCBDML592V0CNMs+Qh6d9i
kMqyLOG94G3omCbb7m3DWnovT8bAC1DW5CzZgBfmndCm3+JT9CifsMlar6kOPujv
RMuL4NZTJh58nZFCyXrUNQOWMAPcLUhfbojMk2cYzgADZKN1TiYkchjFcWelobwV
co7snDDghKkeizcXjXgq2wo8Hs1MZ3meQmUiAyNEznj9cjXAWpvywA1KBqj9KYdP
PsrkHh2TdjeCmXMBbNs2D9Q9lU1RAJqDITQPM1mGl5PX6PYjBEK38F8smTNW3sY9
Ap74mwlAxZ7LMTvkqcj3skQ1r0CauakjA2Xf/QBEiaI7G5h6fK3aSeojEvoe9INs
pFXXSKbotTwkJYtD1oDrWMuzusGDIcs586kfCC+tELoPPn5pbHcCC3AfsmYOQpOp
kcKdOpbvb1fUR6EJGLpsuBFmDy2mwB1XT+1DvsPYSSJT1OzPVzGWP+QUQYDuAQjW
SUcbn2ltnoxaC8RJ9JUVpwQJRR1FNFVi8hiFS+TLzl5fxXcaJjVpurRdxxIOMOGP
UoOhQwMs34RTa3mcFEyc
=z13R
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
