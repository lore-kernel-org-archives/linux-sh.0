From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 11 Dec 2013 15:15:46 +0000
Subject: Re: [PATCH 0/4] Fix backlight on Armadillo 800 EVA
Message-Id: <20131211151545.GB31617@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MfFXiAuoTsnnDAfZ"
List-Id: <linux-sh.vger.kernel.org>
References: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2013 at 03:48:14AM +0100, Laurent Pinchart wrote:
> Hello,
>=20
> Commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9 ("pwm-backlight: Add power
> supply support") added a mandatory power supply for the PWM backlight,
> resulting in broken backlight on the Armadillo board. This patch set fixe=
s the
> issue by adding power supplies to board code and DT, and adds proper hand=
ling
> of the panel enable signal through the PWM backlight enable GPIO.
>=20
> Patch 1/4 fixes a v3.13 regression.

Actually there should be no regression at all here. The regulator core
handles this case by providing a dummy if the property hasn't been
specified in DT.

> Strictly speaking patch 3/4 is as well, but the backlight was broken
> anyway with DT due to the enable GPIO not being handled at all, so
> there's no need to push it to v3.13.

If the backlight was broken anyway with DT, how could this new patch
break it I wonder.

Thierry

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqIGhAAoJEN0jrNd/PrOh2nsP/0HqQpXMhasR+TnBLlcotzSb
Y5ie9mj7t2DMWjdYbf+8l+jmHaqm8BEx0r53usSYT06MsolfOtwd3ZQGWKqC3xEc
rSMfiYKJHyfb+0hmHWzC3mjEc8WyHc3c86erHNXOFAOu6XRzeemtbcNDZMNc+s2d
/LhaSzJhofdxebXLRomoB9QzyTw+TolN4z5T4SYNvj/vcRjclzny2zixdSGkKb1p
/GTx8pSHw6zhwZcQBYi/Wf47a5kZWZ6AVPD3+gPc5tLPo9TOyINhpOrc8otkAp0J
n7E57OMiIlY5jx/L7caQZsYc+hL1TLmOmi8z5qxLwsd4oHt3fVvZi+6ZeNIDUK7b
8NMbbDquVqZQ1YEDeLn6b1WRHpb4xJmuk6uAn+vFa8gz+8zF4vuBpaHMVxFoEY5k
qaqMfUoHcGnuCnPcjnHfB+zpSl9GGVCrMUnZYtFn3YGjIJ8G9gDpwcQ7UdOyUOyL
Q4DsW+BuD+zguiXd3DgiMK2WidFe2QiIv+/pCetwc1lbWvSw5CtB1hAWU7l03mRO
GgT4oZGiTU/oayHZ6Pts3RrykLWIfq6JX4nNRVGMARVnp1G9rX4mBIoqOM6NkiX8
t0CxTaTt1B8D/bZw9xquajHHetzgqEBa1SC6et/Mz18e37yTU1H0RQo0UkBGIDj2
nMLcvq6PmBqPCOGUYuTV
=C57N
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
