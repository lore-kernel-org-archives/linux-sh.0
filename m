From: Mark Brown <broonie@kernel.org>
Date: Mon, 17 Mar 2014 20:32:25 +0000
Subject: Re: [RFC] spi: Using Trigger number to transmit/receive data
Message-Id: <20140317203225.GZ11706@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nktOf83SvqltY3iw"
List-Id: <linux-sh.vger.kernel.org>
References: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>
 <1394699364-5669-2-git-send-email-cm-hiep@jinso.co.jp>
 <CAMuHMdUpm_4f7LynObRA+NDn4vqeUc0a2XZW-E=4LKL_Ro3XZw@mail.gmail.com>
 <53264BA4.3000401@jinso.co.jp>
 <CAMuHMdWP-tNCtnwP6=XZ1BNacWretVYjrpbT3R+KTEO=047+Nw@mail.gmail.com>
 <5326E424.9040709@jinso.co.jp>
 <CAMuHMdWbxCDGBsBo-QfFheVQFCvhWaTan2yejqSsZByrmsmjCQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWbxCDGBsBo-QfFheVQFCvhWaTan2yejqSsZByrmsmjCQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Cao Minh Hiep <cm-hiep@jinso.co.jp>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>


--nktOf83SvqltY3iw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 17, 2014 at 08:48:43PM +0100, Geert Uytterhoeven wrote:

> I gave your patch a try on a v3.14-rc5 kernel on r8a7791/Koelsch,
> and it increased Single SPI read transfer speed from ca. 1 Mbps to 11 Mbps.
> So I'm looking forward to an updated version.

Nice!

--nktOf83SvqltY3iw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTJ1vWAAoJELSic+t+oim94I8QAII4J0SNej94Tvn2b1RJhlwZ
2mmb6VPl6x8yJotMxTp8RGhVFVIbvVCgvJ2kDbKMuCI6TKfmV6TzBiSK/kxWgDSa
ZFFYJT3yV3AL/XSsc3+3UedJLq1FNDKxedcv/Be3cCo4ywHAnuz0rbHhCKDorpqA
FHY2FtsgS51m3XvX7wHr3qUk/S65ENq6H5vL9LN+HyO2jF2g1dhrusRmP5OJ/OL2
1krIY5nV1sZzrTRiFzGjQCrda1eoU3MCzXdGenjM3zvD73b9bH7qsjtYkdbMGNCs
4T5ogtY92VNdjSc8dwjFG3ZV8/qL8/e7mZ+3BcTicOwA6mEWbzC7qcc3122vUUC0
+BAWiKX7nh7CBVNP6Znv+ppnySWa+rersoDRBisVxadzC4se+8f0BQnoPYaZWRIE
NmNarM9EFMZxeqlOHuIewAO+M3VhIujfzMc6G+L9sSWSXKhYrn3VySCYZY3vLytn
Srr2Y0LCVaYXMuY07FoGgQu1+4FNiDMZBmZRihzHBDX/sznYfZqL463LwaVsc8na
s5HoiQJ7zhMWhYR/BEt28o43VfUElK+pVegR5kCbpmM8mRLPifj8/7w6tUxRcXkN
RJU3citjZqN8ONLJg1HvDKnqAOrji3q1KRRalV1AUPk239tv+z4oQZgaf9stxwCk
lxrGtnpqDyIK8lbcGkfr
=h97d
-----END PGP SIGNATURE-----

--nktOf83SvqltY3iw--
