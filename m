From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 04 Feb 2016 19:47:54 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: r8a7790: rework dts to use i2c demuxer
Message-Id: <20160204194754.GD1958@tetsubishi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jL2BoiuKMElzg3CS"
List-Id: <linux-sh.vger.kernel.org>
References: <1452695369-29413-1-git-send-email-wsa@the-dreams.de>
 <1452695369-29413-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1452695369-29413-4-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2016 at 03:29:29PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Create a seperate bus for HDMI related I2C slaves and assign it
> to a i2c-gpio master. It can be switched to the i2c-rcar or
> i2c-sh_mobile core at runtime.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

After some discussion with Simon (thanks!), I will replace this patch
with one which is not only simpler but also more useful ;) Stay tuned.


--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWs6rpAAoJEBQN5MwUoCm29q0P/1MDlCEN0Lo9oRItp4xMqcat
xa/wYnq+R/K+i1p7LCvzcRRGVBLDLakDNA5/XH9o5maem9S0DxRB5bu7A79bbowA
dvb+XaIRv4WS2qRJPDBJyt4kORSeCSOcJ7aaSrgwyHr58C4gV58x0rEBk9lNC5O5
B9l72H50kE1D5o+seWcf7xxXT9D81raAs4sP6d/7ATOrFz3FRR82XGcgqY5xHCS6
sSSPXIQ0Zsn+AK4+U+Qn8I4rZvk4J93OLeGHSHiJrmckFJoNJFJjPuTb6+qPAxWN
v033xl8CywXEzMEy7YIYRr99PwCkYzdCXGtNUKnCv0NKRHIyluFgKl0FqhH9jGRl
pcHEXfSoK0+8SV0tJyGH/wi7YBj0bGHtnhIoik5U2S/CJE2mB16CPhzNXTWrtYdu
qat3M4gOxPDojwSk2EQc7PcSgpEkhQ1moCXcLeoGQB6V8p4zThZEGkTilnOsZ++S
djTLjaOiVsXRIS+6rbpYXAuLECY08nH/yYX1xvRfYE6JA/t+MLAhrN4cbIS4LyO8
HcuJPBr3MaWatzw94xZXZh1839RpenXBDBJ/eC/VNDkg+R+DvsS1g7M52aLHJG5H
spWXpGiooptR3al+mtUQnUKyHysdvX3RqPNBOgr7V+EnFvNdxrsT5q7Cv3wCrR9A
VRM1N/++VCIwKaDoQRSC
=hLWU
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
