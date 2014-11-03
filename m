From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 03 Nov 2014 07:47:52 +0000
Subject: Re: [RFC 1/3] i2c: sh_mobile: add DMA support
Message-Id: <20141103074751.GA1776@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
List-Id: <linux-sh.vger.kernel.org>
References: <1414752678-26078-1-git-send-email-wsa@the-dreams.de>
 <1414752678-26078-2-git-send-email-wsa@the-dreams.de>
 <2162385.nIBTGoCL05@avalon>
In-Reply-To: <2162385.nIBTGoCL05@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > @@ -33,6 +35,9 @@
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> >  #include <linux/of_device.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/sh_dma.h>
>=20
> I would have tried to keep the headers alphabetically sorted, if they had=
 been=20
> sorted in the first place :-)

Sure, I can do that as a seperate patch.

> > +static void sh_mobile_i2c_cleanup_dma(struct sh_mobile_i2c_data *pd)
> > +{
> > +	if (pd->dma_direction =3D=3D DMA_FROM_DEVICE)
> > +		dmaengine_terminate_all(pd->dma_rx);
> > +	if (pd->dma_direction =3D=3D DMA_TO_DEVICE)
>=20
> else ?

Yes, why not.

> > +	pd->buf_mapped =3D true;
>=20
> Can't you use dma_direction !=3D DMA_NONE to detect whether the buffer ha=
s been=20
> mapped, instead of adding a new field to struct sh_mobile_i2c_data ? You =
could=20
> then simplify sh_mobile_i2c_cleanup_dma() by returning immediately at the=
=20
> beginning of the function if dma_direction =3D=3D DMA_NONE.

I thought having this explicit might be more readable. Will try your
idea though and check.

>=20
> Extra blank line here.

Yes.

Thanks for the review!


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUVzMnAAoJEBQN5MwUoCm26FMQAKqnZtJ3cJbYFPnV0FGYjqgP
+uTN2xE4S+hmfOcgPBOpdwV1CuzUovYylUmQFhp7HWLd3PpZe6vsFyudGA54T8pQ
JFecS3ULKgRK0A10OgjHPFvoEDOpHmzbzxXue26Z3J1vB9DVnKE3iuCyuf1A/mAN
ATv/Hdqwe5WKt8pYUXhBaYjS59cG363GSwuLdDeAt9HGcC3GPMLv+w2Q1c1tLI5i
3dyeKdGSvFAJSNHFvcJEGG1tpfa8ETjDANfGJSUtiY5z/v8saFQCrYtNvEj0I6z3
199bivYCH1MYSAsZiiWVqn4cCuZkD4KYW6f+LF1ffRYC7lxNqEjhc5SadMeK8IUg
lj6CmIINEmX6UCleGp7KkM3yFLqADW9OiGaLtj9hAadXdYfdKJWp3bF3ppNftHXw
mPg6JLosPUXXLOyHZlrJL1w3A7z+zBpHmtU86nHoHzzgRTEITftQlRUBdA9Hotz7
VfZYpbhI4B3iPBHIWX6z/lV9W3OHaUWYOvw0D/sYFM4GjGhDNdIubcc5vmTWMv5G
NgK1x1hGZqyjNr8LXXVsdTQK4N6Y1qrVv8ql68MXsC4gL9Kegyy++Q/3rmPB0lFI
T1LZB3yNvnOJhPzkb8Uxgsg784g+MhhD0saQFaGsZaMk+NK4v7CMU1Jo0b4V71nr
MHjcXtOnREWfyg9x4Dd0
=8rlo
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
