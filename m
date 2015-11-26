From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 26 Nov 2015 12:43:33 +0000
Subject: Re: [PATCH] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <5656FE75.5080207@metafoo.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RwOrCAH1i5kdFVEoxxDXGtGWJJ2mgWHvj"
List-Id: <linux-sh.vger.kernel.org>
References: <1448376627-12255-1-git-send-email-wsa@the-dreams.de> <20151124210501.GA1584@katana> <CANqRtoTAPU3zni__J2MQR+KK=SUUGYLgHz5j9s04CjEq55s3hg@mail.gmail.com> <20151125064851.GA1511@tetsubishi> <CANqRtoQMSoydbmj8W7Vjc7r-sFo5iz3_5dA2MVipsaec+BRebQ@mail.gmail.com> <20151125082736.GA1526@katana>
In-Reply-To: <20151125082736.GA1526@katana>
To: Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RwOrCAH1i5kdFVEoxxDXGtGWJJ2mgWHvj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/25/2015 09:27 AM, Wolfram Sang wrote:
>=20
>> I guess you mean that the GPIO callbacks include Runtime PM handling
>> however for irq_chip Runtime PM may not be hooked up so the GPIO block=

>> is in such case is not powered on / get clock enabled?
>=20
> Yes. There is another drawback when GPIOs are not properly requested. I=
t
> is still possible to request them from userspace although a kernel
> driver is using them. I am playing with the idea that the GPIO core
> auto-requests GPIOs which are not already requested but still set up as=

> interrupts.

I think the GPIO core already reserves the pins that are requested as IRQ=
s.
See gpiochip_lock_as_irq().

As for PM see this discussion
http://lkml.iu.edu/hypermail/linux/kernel/1511.1/01645.html

- Lars



--RwOrCAH1i5kdFVEoxxDXGtGWJJ2mgWHvj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVv51AAoJEOj3aLScRbOZAiAP/1SVG+++Utd/w6X1rOj/v8nC
R2KjfsT+RrMBGWcuJnVxKQL8QSy1Ga3QL2CYEJtZhpWQrGx+pPBs5un81OP0xqJa
2jp0dnIVURaDS3V1yxe/hIuaSoYUwvcGed5NpbbhdWu/qsTGz7Bc68TPq7aGqGJP
qOY/l9pzBmQlmXWvHyTVT7endj14PfsPo54pGbJnX6AFCexSe8mJ3xaVE7eHho12
SGgmtOrjGmghgvnMjkk5xNY1aIz/F5PA/4tjZaNXxkYxmfgooOFZH6OgFP1yhxtp
mV+k8t3NMXDZovTkLQI6IZ5n/3WGu6fwNjFNEjlzoX7t45/cN6tvB6jJm5RPu7NO
+Mfu19sNbW8nJ9cWhNhk/2/2MFmY+43xxanXPF3dsPARc34ZumLF7m7914PWLt4U
RvMEFzjD5X5IP8M8IwdG6wOhfmFHKWA/c2Q9FnTj7qLm+t2DVXNqpiawC6i9nO+m
bFODfUuWqeK6dLG7ZeTzufd0qCK6RvmiPs6/to0Di2ojk45YU2FgV7XfPn8pz8yK
H4hUQ9RWZk6CKCytMtdEwVD+1DRAt3h5l4oihY/mwArERKACZYVebF0S0QyB2e6g
1+qMTATUBvEt9ftHww8vxWHDDsfBHW1sVL25a1VEY3hh2HV3FW1aYQq/tb7aaDZ6
l4og2PLlHKxaPBTuLFKV
=DEU/
-----END PGP SIGNATURE-----

--RwOrCAH1i5kdFVEoxxDXGtGWJJ2mgWHvj--
