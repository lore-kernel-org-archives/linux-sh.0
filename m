From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 02 Apr 2014 11:42:20 +0000
Subject: Re: [PATCH 0/4] r8a779[01] I2C clocks fixes
Message-Id: <20140402114219.GA4704@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
List-Id: <linux-sh.vger.kernel.org>
References: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 01, 2014 at 01:02:14PM +0200, Laurent Pinchart wrote:
> Hello,
>=20
> The I2C clocks select an incorrect parent on r8a7790 and r8a7791, both in=
 the
> legacy C code and in DT. This patch set fixes that.
>=20
> Laurent Pinchart (4):
>   ARM: shmobile: r8a7790: Fix the I2C clocks parents in legacy code
>   ARM: shmobile: r8a7791: Fix the I2C clocks parents in legacy code
>   ARM: shmobile: r8a7790: Fix the I2C clocks parents in DT
>   ARM: shmobile: r8a7791: Fix the I2C clocks parents in DT

Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>

CC on I2C patches would be appreciated.

Thanks!


--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTO/ebAAoJEBQN5MwUoCm2WIwP/3mtrWimuPHjvBIBfTCfeMAv
39zgmpdNe2RjQeWAdEfy4uN9VsZU25maVSHc7xMgGTrzFhFznhhK+dysDOz/Qv4e
+WO/n50JazhHZO8J7EnwZm1LSowVNfXrHIoLBDbil5RAPJvmpmTf8lle0OWGorZm
heyGegx/3P4PC966E2NijVe+DxGgQc9GB9hc6Q1tTZlPUKUqlxJIyOtxuI/UlmcZ
pFP2mKdqOC0t/iFj9G5T1tb55bs5cnk/a1RpSsHsjr6bwE2Ph+py4rKYphcRfaE9
liHLLDNarKRZ7sKBFLAt43ZSXc191rT6eWTAgGhffWsJYujFF9LW5ntUa8ebVjBU
Cb/k0B4mdpGMWZnvglhTcPES9tizmyaJOA4WNL80tgljWeNaUEttzvKIgUCzlNCC
sd/EQBtnjn6cFvTh1g07usqJSh8twgV/LVg4r8VWYmYABq9kIT6e9Q4tJfqfr+zy
EoCDC5zJo/Jr5U6zoRRZ2RFWxEjDQv52W+5sweT3b1SAneVTSgQrS1x/fpOmxoBz
+THrMtZeQfoeH1Fb236wyFUl2smtpYQG7D8GWj7Lpr36/4RZE1kocCcnGeP52OfM
ixHXO040zBY9A7R1f1IrcyUDS/w7oS2MTsy5AHNn/Zq7xaYA+Oj4kQoiIW5P8FSL
fAAuXEujWgqovjD6uYFk
=5tkp
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
