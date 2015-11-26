From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 26 Nov 2015 13:51:02 +0000
Subject: Re: [PATCH] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <20151126135102.GA537@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
List-Id: <linux-sh.vger.kernel.org>
References: <1448376627-12255-1-git-send-email-wsa@the-dreams.de>
 <20151124210501.GA1584@katana>
 <CANqRtoTAPU3zni__J2MQR+KK=SUUGYLgHz5j9s04CjEq55s3hg@mail.gmail.com>
 <20151125064851.GA1511@tetsubishi>
 <CANqRtoQMSoydbmj8W7Vjc7r-sFo5iz3_5dA2MVipsaec+BRebQ@mail.gmail.com>
 <20151125082736.GA1526@katana>
 <5656FE75.5080207@metafoo.de>
In-Reply-To: <5656FE75.5080207@metafoo.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2015 at 01:43:33PM +0100, Lars-Peter Clausen wrote:
> On 11/25/2015 09:27 AM, Wolfram Sang wrote:
> >=20
> >> I guess you mean that the GPIO callbacks include Runtime PM handling
> >> however for irq_chip Runtime PM may not be hooked up so the GPIO block
> >> is in such case is not powered on / get clock enabled?
> >=20
> > Yes. There is another drawback when GPIOs are not properly requested. It
> > is still possible to request them from userspace although a kernel
> > driver is using them. I am playing with the idea that the GPIO core
> > auto-requests GPIOs which are not already requested but still set up as
> > interrupts.
>=20
> I think the GPIO core already reserves the pins that are requested as IRQ=
s.
> See gpiochip_lock_as_irq().

I could still export them via sysfs. They were also not showing up in
/sys/kernel/debug/gpio.

> As for PM see this discussion
> http://lkml.iu.edu/hypermail/linux/kernel/1511.1/01645.html

Nice! Thanks for this pointer.


--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVw5GAAoJEBQN5MwUoCm2SrsP/3Pi+i6qNlezrGqdTe690yjB
lozmxSMCGPOsgSGEAMTrrTyv7S22gsYXymv7CEw/iasHUIYwqbdTn0RDEVXtzbVH
VO2s8JA9luGQZ4xVJNEEAZ72pHLwPySvyyAFLx0ALMXrm3UBxc2y0jy/qOgPWyFc
ZKVND1s+RNTgpzQlAkoE0r+iIQ/9kbHVbgdQIkXE/0kkYrBogaYagPyKQLQsbB+M
POFIduAVnmAVzaby1FqYk+bSU/c9Q5DklemFQwM8uNloMeX3f1x9nvRNKkfEgU33
fFkngcgHxcjka36d/YooP5XRsF71hBYQYbMTbhTTKlY7ldh+7z5yqnsS3HHb7ohS
CUH3Fb3JxVwF3nsQa3LZ28Cby4SUsbjfLGXCb36X8GHks7hbXT4wy3BcvDLX6Lfr
r+YmCN1oI/ynM2PF+bYNrLDpJCpBoApOkLa/JzUU9rconkpeior3dg1lZivJrc18
b40oA8mcx6awE+UyCb5DUfEb91e5OGLiMhUUrlr4KZ9l6lGjXbD+9pLOYNMhsoC2
IqSviHaVFgawJnf0VohNt0wQ783VcvpUS6uysgB7UvdwPbBM7hmZMVap+/K47jvw
ZMwnTggLCRPodqhMKQ2sBXW6Si7rmgWk6Po3fuy0lYXUi5ProN+MGpvt0kg3nneY
PdGzhtRl7EeLr0TehVqs
=fxdO
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
