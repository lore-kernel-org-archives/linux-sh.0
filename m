From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 17 Oct 2012 05:54:03 +0000
Subject: Re: SH kernel boot up issue
Message-Id: <201210170154.04282.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart6753125.bau0Uv4FYV"
List-Id: <linux-sh.vger.kernel.org>
References: <507D5FD5.4050501@gcs-vn.com>
In-Reply-To: <507D5FD5.4050501@gcs-vn.com>
To: linux-sh@vger.kernel.org

--nextPart6753125.bau0Uv4FYV
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 17 October 2012 01:01:18 Tung Pham wrote:
> I'm working on custom board that uses sh-7710 cpu, and I tried to boot
> with kernel version 2.6.35.13.
>=20
> Do you have any idea for this?
> BTW: last kernel worked : 2.6.15

can you try 2.6.30 and 2.6.31 ?  your crash sounds like a PCI/DMA error i=20
reported w/7750 that shows up starting with 2.6.31.
=2Dmike

--nextPart6753125.bau0Uv4FYV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQfkf8AAoJEEFjO5/oN/WBITUP/3OcQsOFcOnkWNa7aVif4Zmn
3CrocEMTlqFopddL83ZsPi0zdUUzZmC2nV5DDmOkYy9vmz8qrS0c2Mq1EidT8s3S
w06kpMon89gQyk12yRuQGgiJox+qtQWPRMFCE3kNnQ8VmxM3xrDj55bAnAVLH0IQ
GhuXef1/h9BX+cQkvARj6OSEmPH//mTtnC8FmLdxeyG4NHj2TiZ1kbetShHu8zpJ
IShijgD7gexKKLbsqTDGKB3nn87Uz8yIITFZb2xMfUQJw9ms5nPwcYp64TVRez1D
I+1jgiAJnO5hSab1P0D47uascHWDs10t7vPFDflEVJDg1Ytu8n1HBdkAZYe8/W7I
YNfscAv7WIrLqJTr08D8i2XIcTrJAD1qxWokAildZ1tv0J5roIglzcjCteliacUW
QuCYNlmO8smv2+GY02r1iwhsPjNdrc9S6ggktYY0ARTcx0gU5j4n1Kh1TfwfDAYZ
hltglmLRlOmTTh7gTnfGACzeuamPpiP1RW+0A8KFFbl0w+1mrV+SOT2mlPpvdBVI
9OzsMUR7vPBIBR24RpJAhOvS0xNzNZnCC/u5rjpf5vEy0L0N7qblVfYfT0xeivrj
jvyWm5H2HW9H4E5ecx5UWByxY6yHO6Ci3mX12CGJyE8lr1uMu+eEycsAUg/KqKy0
ntJ3TvH1sljwHDop/M/C
=1y6+
-----END PGP SIGNATURE-----

--nextPart6753125.bau0Uv4FYV--
