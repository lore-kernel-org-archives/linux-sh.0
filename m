From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 25 Nov 2015 08:27:36 +0000
Subject: Re: [PATCH] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <20151125082736.GA1526@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
List-Id: <linux-sh.vger.kernel.org>
References: <1448376627-12255-1-git-send-email-wsa@the-dreams.de>
 <20151124210501.GA1584@katana>
 <CANqRtoTAPU3zni__J2MQR+KK=SUUGYLgHz5j9s04CjEq55s3hg@mail.gmail.com>
 <20151125064851.GA1511@tetsubishi>
 <CANqRtoQMSoydbmj8W7Vjc7r-sFo5iz3_5dA2MVipsaec+BRebQ@mail.gmail.com>
In-Reply-To: <CANqRtoQMSoydbmj8W7Vjc7r-sFo5iz3_5dA2MVipsaec+BRebQ@mail.gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I guess you mean that the GPIO callbacks include Runtime PM handling
> however for irq_chip Runtime PM may not be hooked up so the GPIO block
> is in such case is not powered on / get clock enabled?

Yes. There is another drawback when GPIOs are not properly requested. It
is still possible to request them from userspace although a kernel
driver is using them. I am playing with the idea that the GPIO core
auto-requests GPIOs which are not already requested but still set up as
interrupts.


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVXD4AAoJEBQN5MwUoCm2ZdcP/jkLEKHff0T3VKJarcmcTHmR
5VfQNooH++QSOqBLi1zK/kUHGLNggpZswRqmy6phcXusWu76wb8jX1bME3+2bjZa
ITmx221hTiV5MmNsdVwthSogFcN3GFkJy9xvyjKlIIlXkjePz2hWiYr9/e+i3C7y
PxtrvIGVLkdunopfzaKvuIAA8ngkyrG5HtVqDBDbmIoACWJGhQbC5FoRnsxz87b1
SBFDQao58V4YbWyOFEyZGP+Rqj95//RVhqKIeNXggDOjgZygWH8a+tmWtAIcH/qZ
anfWfvT3ryfno8RGGGlTboJb0oA/gMj+rvUK6yEPxwR06vJo/R2w6ZNsaGsvElg2
CSVyDXeWY9kolSwXzJXl/J1n5ghrQEskMUknTRyYadCEKZqVK2zpisV4zoDGwSKC
4TszLcd/uCC9fIrd6Pw8fnb3P2q0mkprv/fZSsn2YVTKSJ9OpLKYW5VI+uiCDAik
Ml9+I6SEXoOYkWXd2yY57wZHsvSimXmlOKednic4JtzsQN50v/kOul4qRSbFpkef
19/1PwpqAV2mVFd+HBp3IuUpglPGhCbE0B5xf3efyllhsaPNxBU3mbch5kdFBulK
FXwnLOL4b+C71tkHjVNSLeAB5BQiQ8Db0gnqnd0gXlrtMGWaeoYHRVbbR8H6JtL4
sQL+WiLGVfoddr0uN8Ak
=wx56
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
