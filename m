From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 27 Mar 2015 08:55:00 +0000
Subject: Re: [PATCH v2 0/4] i2c: slave: API updates
Message-Id: <20150327085500.GA18521@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
List-Id: <linux-sh.vger.kernel.org>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1427099199-3628-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2015 at 09:26:35AM +0100, Wolfram Sang wrote:
> So, after some more thoughts and people using the slave framework, some A=
PI
> updates seemed in place. Also, the documentation is now here. Please read=
 the
> patch description for details. Thanks to all people joining the discussio=
n,
> especially Uwe and Geert!
>=20
> Changes since V1:
>=20
> * added acks, except for patch 2 which has too many changes to keep them =
IMO
> * reworded/updated the issues found in patch 2
> * added patch 4
>=20
> Wolfram Sang (4):
>   i2c: slave: rework the slave API
>   Documentation: i2c: describe the new slave mode
>   i2c: slave: add documentation for i2c-slave-eeprom
>   i2c: slave-eeprom: add more info when to increase the pointer

Applied to for-next, thanks!


--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVFRrkAAoJEBQN5MwUoCm2GssQAKe/v5HUUFCBjpTpMnahv1lV
BALWrBT27eahMHAUx2QLcuCpcsUSG9jC47gZcDG/eS+sU10QWxl4c0uj40Gh+QIh
/ZBoOKuwGDuvd8b28T32/lJ3DGP93gF4ghD+Jp6QNNq4fpxcY4rri8pVwE4v3tJr
71/828Gw8n9sc4c3NgbIpQUicOgLnO+ljfRE+Rsdv1u+AdNUvQ2rSh+RBieIZfRX
PAZNRi7sx76MiejzFJUgL29kplpayX4dXkYuFvH+jY3QtY6vo/MEWcdr+NJWOxhl
2rniDfqXJOmdryVpWKwyLUhjUIHypHTR2ueJ+VjRJh85fp5+klmcUr6W9Tf01etU
a0WPowTBgxHEcl2FceJLfePKlkn3WdPEU0eFolW/f+sjtX6YLD+fselxj7BKZ2oe
cnZjC5LU6TJPwfSW2A44l4r8bCeDH07aVTYfcCdooaFUzmvuobF5QThIQTdCdaJX
YcyWJb67gCgNkkq8Am9H5p0Mzg7vPNA8+ys62QGIeOMo4gVX/46V5atWpeFMYlRH
1qiwQe8cD8mFj20mNomMNBADDOjJCACtgM0ttwb/6CuDRWn/VybVXnS1pne0Z8I+
HjBxeiD4gxCyvHUkVZ2WIIqi5bCM1DK4fLraz5uLjqPKgTPzQM9+feK6x7lwsQxX
KW0jnfaFeZeDdv2dfhku
=GSaV
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
