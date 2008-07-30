From: Manuel Lauss <mlau@msc-ge.com>
Date: Wed, 30 Jul 2008 14:31:09 +0000
Subject: Re: i2c_board_info use
Message-Id: <48907B2D.4080406@msc-ge.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48906795.9040101@spesonline.com>
In-Reply-To: <48906795.9040101@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Luca Santini wrote:
>=20
> can you suggest a new-style driver for inspiration?

This might help. I wrote an AD1939 driver a year ago
which went into the ASoC tree with old-style I2C probe code.

Here's the version with old-style probing:
http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=3Dlinux-2.6-asoc.gi=
t;a=3Dblob;f=3Dsound/soc/codecs/ad1939.c;h=EEe858acddcb5a414a52f862204a6a2c=
4d519239;hb=15fbaddfbb16309c37f02341425b13046af3f215

And here's a version with new-style probing.
http://mlau.at/files/ad1939.c

You should be able to use the differences in the i2c probe
of the 2 versions as a template for wm8731 conversion.

(I once had a patch to i2c-sh7760.c which implemented SMBus quick
  in a crude, non-i2c-maintainer-compatible way, let me see if I
  can dig it up again...)

Good luck!
	Manuel Lauss

