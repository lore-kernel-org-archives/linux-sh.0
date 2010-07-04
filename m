From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 04 Jul 2010 21:24:43 +0000
Subject: Re: upgrading u-boot from linux for SH7785LCR board
Message-Id: <201007041724.44595.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2612966.b0svW2nlPB"
List-Id: <linux-sh.vger.kernel.org>
References: <4C30CEC3.1050003@naoi.ca>
In-Reply-To: <4C30CEC3.1050003@naoi.ca>
To: linux-sh@vger.kernel.org

--nextPart2612966.b0svW2nlPB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday, July 04, 2010 14:11:15 Bill Traynor wrote:
> I've compiled and tested u-boot from git for the 7785lcr board.  I'd
> like to write the u-boot.bin to flash but do not have a JTAG to be able
> to recover if the write fails.
>=20
> Given the MTD layout:
> dev:    size   erasesize  name
> mtd0: 00080000 00040000 "loader"
> mtd1: 00080000 00040000 "bootenv"
> mtd2: 00400000 00040000 "kernel"
> mtd3: 03b00000 00040000 "data"
>=20
> Is it reasonable to do the following:
>=20
> flash_erase /dev/mtd[0]
> dd if=3D/tmp/u-boot.bin of=3D/dev/mtd0 bs=3D128k conv=3Dsync

why dont you just use the mtdblock interface ?  it will take care of all th=
e=20
weird flash issues like erasing/etc...

all i do is:
cat u-boot.bin > /dev/mtdblock0
=2Dmike

--nextPart2612966.b0svW2nlPB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMMPwcAAoJEEFjO5/oN/WBkQEQAIk14L0GPQPOPh00Ek+pqkiW
0qwNt3R2sEUyktHteYUBQNa5pEpYvZw4Ha4V/Prbm3RGvOUzYRmW/YxdCjDq+WFx
HAynahHJP82vT1cFub3nJV7HgRusD3H1YdF77Mi/JvcM3pKH3gb59M/wprW367uH
xY8wR79L51QIyOctLPiX6AQUtznVHKMxwDoqUTiH+FetyJSBwCI87qfhPOUirzhk
cFIWg8t1n+1apR4yZXOWF1lwAnnn/ReeEz2cpvCzFmfiy5P1vRVfqTpjy+rn3jwu
XSIvPNnDRXK8pVqAG8+NSNvIkQM69qV8K/cBDypkyWJKBTGH0LY3Dxh48O5VMfAM
GXPCT+Jx3PSlh36pCgESTY12MgmZIEAain1YDqfA9VClxF+bgMX7Q9dIuxJkbl/2
rZf6eGWSdaRIQ6o2Ghs7p3MinnKiwxvWeREaZW2MHyX2nbwKKUZAddDozyqm8r1p
CEojiZsi7j2zVWJ5DpRPaN6BfsRmgNNAb5o0ihqSHGeNvT/BCRbu2SEzbWgJ7Ft6
3StMOCohqq51sYWxpwLG5EIl8AS5aarKZoF56bpIZvQ1wLpUWv3biEjQPCiQXgWG
lnsSZf5S3PGcCEMzBv3PTfR1F4Ak4s2T3+00TqJRGne1CtpWoYBfa8nODVPgdE5o
2B3/lqx6RGPoaUB4dBsU
=uS3M
-----END PGP SIGNATURE-----

--nextPart2612966.b0svW2nlPB--
