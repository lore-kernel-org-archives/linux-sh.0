From: Felipe Balbi <balbi@ti.com>
Date: Thu, 10 Oct 2013 15:15:23 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <20131010151523.GD28375@radagast>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="hxkXGo8AKqTJ+9QI"
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
To: linux-sh@vger.kernel.org

--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 10, 2013 at 01:47:26AM +0400, Valentine wrote:
> >>>I would use either
> >>>
> >>>	depends on ARM
> >>>
> >>>or
> >>>
> >>>	depends on ARCH_R8A7790 || ARCH_R8A7791 || COMPILE_TEST
> >>>
> >>>(assuming the driver can compile on non-ARM platforms, otherwise the a=
bove
> >>>line could be changed to ARCH_R8A7790 || ARCH_R8A7791 || (ARM &&
> >>>COMPILE_TEST)).
> >>
> >>OK, I'll take a look.
> >>Do all the drivers have to support COMPILE_TEST?
> >
> >There's currently no rule, but if the driver can only be compiled for a
> >restricted set of platforms, I would say that supporting COMPILE_TEST wo=
uld be
> >a good practice. It of course needs to be restricted to the platforms on=
 which
> >the driver will actually compile :-)
>=20
> OK thanks.
> I'll probably go with the safest option:
> ARCH_R8A7790 || ARCH_R8A7791 || (ARM && COMPILE_TEST)
>=20
> It does compile on x86 though, and may compile on other platforms as well.

why not ? What's the reason for not building under x86 ? Drivers are
supposed to be just plain C, completely portable.

--=20
balbi

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSVsSLAAoJEIaOsuA1yqRESn4P+wQWuKwGLBSqWJOANogo6xOd
NU4SnRCe9wcAvoRH9Rfwl2M2QlkdUsXIjTgAsNaSJQXl98RVdB8VJhpwSOxT5zDX
gjtVbk7beMbazMij90DZIvjD1DwVOoxe7l+LdQ2q6fnmAd/QvBBbboOIxzpmVNe6
5ydWV82b2eTWUZjiDxbH+F/ywRgnzEvgLX6XAoUnhMotJMFMj2RC9+EU4r++wTp3
UvVn6UeR4Hf664XE6g6uk4Gbxz/G8ePt+kouAFXuE5ucCz86tbYnWOXiMcuIpA89
XKObKPOZ9n4lD1dPW/9MBbMquqtHFQR2DwMH/fOaHlTCiGHV63AlgdFDjneKU4zE
QMnbL1hhLTXLqxXAU+flXFIZqox9fQU5N7VgCzYsR2hFecwFG15YcmkJoHj2Gmq5
oknYiLbjdd2m4QbV31EHDxkc48BafANlaz25WLHR494FYDufwsWdCE5yrgOwC6Dl
mr0IoHYr8kqhghsyjS/w0Ww67NEfBpbLHcbicter29B+nZp5Ib1nCSeGEDCHiNq8
nkmW7m4ZNWCiyGZIiwau1hPw/snqnkKTrq0MFYRg74hF6jDfQqPWg8ilNDZCIQwW
hf38Bgnyas89pgh6Kg7AsDc37nZer+fsPsJ2pDrcl4JdUj1s1kFSASgbizoN7Syv
0yW3sWpOkGKNeIojJcpq
=1oPk
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
