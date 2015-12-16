From: Felipe Balbi <balbi@ti.com>
Date: Wed, 16 Dec 2015 16:23:25 +0000
Subject: Re: [PATCH v3 0/3] usb: renesas_usbhs: More compat strings
Message-Id: <87lh8ufjlu.fsf@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Simon Horman <horms+renesas@verge.net.au> writes:
> Hi,
>
> this short series adds generic, and soc-specific r8a7792 and r8a7793 comp=
at
> strings to the Renesas USBHS driver. The intention is to provide a comple=
te
> set of compat strings for known R-Car SoCs.
>
> Changes since v2:
> * Split documentation of SoC names into separate patch
> * Use correct fallback compatibility string in example
>
> Changes since v1:
> * Add R-Car Gen2 and Gen3 fallback compatibility strings rather than
>   a single compatibility string for all of R-Car.
>
> Simon Horman (3):
>   usb: renesas_usbhs: add SoC names to compatibility string
>     documentation
>   usb: renesas_usbhs: add fallback compatibility strings
>   usb: renesas_usbhs: add device tree support for r8a779[23]

since patch 2 got a few comments, I'll wait a new series. While
resending, please collect all Acks to ease my life a bit ;-)

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcY/+AAoJEIaOsuA1yqREg8EP/RMuQ0Pj33dWUY9E+6JpEiV8
5EjqusLpQ6+rnlSNBE8zHCrg26gdCUSlDgFKJo/wtIYib7BOh5Mx87PB/G55GWZl
lDDFKBPftZbCYTcTV9mhTbyWe/H3kzLYBBP9ruR3YJc5F8JQpTl55ZJ341rFSLrL
rD2dCqTIPFT1TIqwKiWYNayHbJg5sNR6+EL5OV/c1d1aSPrqmhenhu4kGAwXuKXo
/2Li0yAJTqf3JTeMt+8VfoVEnhCd3bLGsTFm2Ill4cb9LLIN9b68jpS/f58wgby/
1jpUS0qjf0CMBzEN4gWd8AXcE6U2AenWDR+GoPIllYEh4A8NrjQdatpY88StT7XP
Lh+RwxIl+CHfFRiu3nio2/oVZNAIMujVYLBvLss5aQSvaOM3clwhXZxuteVgKYis
qtubW9o+odkcVox/H+iGIoM3Ezfwhra3FfOPMU9GdZrRl4cg8zvzI/lMnC1M7Bbt
/5vgOZzqVYzKF5Rbfuberke32DOe3ABBfi0fTpp6Nk2RTQmU4q/b7slD8KEJtjnA
J9Ea0o7WG+PLt+eeAgQcqDftWxX33XINjpjmQ5X2pRaEOojdyEmir7jk+qf6eet5
7zfSInlyTo5PvgB7qaIuFL/1BQX9e/j4fK6EKIVtMfKvWPCSlPbtPY/wJW0YLkAV
g/vXqDot7p7as+EMbPX6
=mjJY
-----END PGP SIGNATURE-----
--=-=-=--
