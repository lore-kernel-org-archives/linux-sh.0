From: Mark Brown <broonie@kernel.org>
Date: Thu, 13 Mar 2014 14:17:22 +0000
Subject: Re: [RFC] spi: Using Trigger number to transmit/receive data
Message-Id: <20140313141722.GY366@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ONmcTkPhtkbQYSLg"
List-Id: <linux-sh.vger.kernel.org>
References: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>
To: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, kuninori.morimoto.gx@renesas.com, geert+renesas@linux-m68k.org


--ONmcTkPhtkbQYSLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 05:29:23PM +0900, Cao Minh Hiep wrote:
> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>=20
> Hi,
>=20
> This is the patch of QSPI that support for r8a7790 SOC. The pupose of=20
> this patch is to transmit and receive the 32 bytes of data when the data=
=20
> already has prepared on Transmit/Receive Buffer. Using Transmit/Receive=
=20
> Buffer Data Trigger Number to do that instead transmits/receives a byte=
=20
> of data. With this patch will improve the speed of transfer data.

Please don't send cover letters for single patches, if there's anything
that needs to be said put it in the changelog or after the --- in the
patch.  That way important information won't get lost from history.

--ONmcTkPhtkbQYSLg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIb3uAAoJELSic+t+oim9RwcQAJvpZGFxK0dCIzajs6kAKr1P
xqE7H0Odu4+OlFyw85SOiFdbYGHSA2GDzfy/rfxma1FXvyg7cK6nCRyj/bfqyefC
Sx9xIzacU577t5VqVbh1xROt6utyOsr67xKbPcOfB0yiZUttxkNz5L4EAj7IpVN3
uIipgEEp1aX9xMEYRpNjaVbNYmKi/wWpsTRc2/P16i8qrKS8wBwWl81G2ONCJW24
PJoKgwawE297F7pbBWCuIlF8PipA+Kjh/fP4rKUgrsejhnS/xV8j+diEEbR7YRFI
w70L/bvm/HuyAhRr1KFGK2+BWJ+cTLePYZLs9hi6+fst8aOIx2My50mBmlkQJj/7
JAyv7fIdKEsEgIShkyyFXtrh7B1Ykmo+l1ky+Sjve0sKvJwOL+V1C1Ix8Lfstqas
TnKF+rcvHwFNDZPLTZj/q9G7HR6LyF7D8pFkJfj4NPYrFY91nDacXL+CKvvIXXry
pDYaU0+cDebYBVLQjrvPZvEf83CJ21gUIKhiXexIiMJpldxMoj8Mw1trixXHCX9c
10hKJ7vqwPD1dBpkBO0bfCs23VD6omF9IZ/6P0OAHSZ6FW8AKRMLF6M+SdMfwCah
BQL4INrMWylhV2MJ8hn/P/rSrR8SzUxP+S6uHOe8Y5DyPJwAKVjbNmPbsL0F4jfO
O7faZr6ZVoOmYbjgYGNY
=s7E4
-----END PGP SIGNATURE-----

--ONmcTkPhtkbQYSLg--
