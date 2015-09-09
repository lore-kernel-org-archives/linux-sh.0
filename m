From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 09 Sep 2015 08:54:28 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <20150909085428.GB1516@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Yylu36WmvOXNoKYn"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <5464456.UnsMOS3MTx@avalon>
 <20150903204000.GB1574@katana>
 <CANqRtoRo7jemt52=mcmu=mf5dGsqwWKWA5aBYd7L=vFas6d+NQ@mail.gmail.com>
 <20150905073143.GA1616@katana>
 <CANqRtoRs=f=07B=HSLCVg5G4rnhxj6Heod+spYwxHiKFLZqFWg@mail.gmail.com>
 <20150908105356.GA15793@katana>
 <CANqRtoQgVymDqv2c2jZEhrnWa4SHWxQgjiHcsVB59B8pBRrNUw@mail.gmail.com>
In-Reply-To: <CANqRtoQgVymDqv2c2jZEhrnWa4SHWxQgjiHcsVB59B8pBRrNUw@mail.gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-I2C <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > 'No EDID data' says bootlog. Also, all 0 when reading that i2c client
> > address afterwards. I don't see or sense anything suspicious with the
> > I2C transfers itself from remote.
>=20
> Did you use the DRM/KMS modetest program to display stuff on the HDMI
> monitor? To trigger the error case you need to a couple of steps -

Nope, I have to admit I assumed when the kernel says that it has no EDID
data that it would have triggered reading the data from the monitor.

> HDMI monitor and the HDMI encoder chip works ok, but the bits between
> the HDMI encoder chip and the I2C master on the SoCs may need some
> more attention.

I understood that the encoder needs a trigger to read the data. It then
provides EDID data via a special I2C device address. That is read by a
simple 64-byte I2C read transfer which I didn't have issues with here.
And reading it byte-per-byte gave the same results.


--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV7/PEAAoJEBQN5MwUoCm2s10P/RiCgN9bI8VLh+yinjAq0UIi
4H5XN2hQxEP+Rj79lJ57mnCT9ceSmQyffRZkPsL2wjelwBZ/EmGspTssW034IFFc
TwPFSUxvj3PrdLRjnX5SYU36CafHhNFTYdTVIIQbIfMqf4qEQpNvNueVlqaMlm5v
/ZNRVsEDhT0mWZ2fToQwoKxFPbk1/QeSB0FGtHrt9M/72kMYUA1K+jw8Bg6g+IGU
IxOqg6VEF5x4yWfYrZGrbv5wFaEXatJ7hCZ0E7zLktacdypPoCKJQXAAkH/FKyt+
Wlfl+rK+VJ1k9sncYvX4Y/yS4POaEdp1hAHPqsijTKsStkS+xQ9/LkGpN57hXvh8
m25v92BPtLD21Kg4c6gF+hhr8HkSRLZDH3g3vl2/QWLM2R3femqYmINrtbOQnKdb
QJY6Vh9KLwDHQ1nbwxGVp3et70r/wlEveXV0gFWrScWN3cLqlkrlUWMRQVTpjgX7
T/PQxGFdS7KtZEB8Xudg2jmtWBCdIYuqQc5e7RBdHmkqe5truGdVlLRwV5WU3vSB
yL6izZu8nCIRBDWEEM1OIMl7qdK0N331BWUphuYh+Gz8hItFZcWoBg3FEOrg6KJC
2fakN9EiAhoV41QpbG31VS3atbT0T0SN/FMgNPFBpXg6jqkGg8UbWu0m2u+dbwri
Atj+CJfOqVQK7JKW/wLv
=s/eZ
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
