From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 09 Dec 2014 14:09:18 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141209140917.GA3386@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <1415355104-2031-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdW7Y_OXWySwxDch82gcGv0fyFPQAxXwSFKQz-QbDN4cPQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW7Y_OXWySwxDch82gcGv0fyFPQAxXwSFKQz-QbDN4cPQ@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 09, 2014 at 11:53:45AM +0100, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Fri, Nov 7, 2014 at 11:11 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > --- a/drivers/i2c/busses/i2c-sh_mobile.c
> > +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> > @@ -727,6 +886,21 @@ static int sh_mobile_i2c_probe(struct platform_dev=
ice *dev)
> >         if (ret)
> >                 return ret;
> >
> > +       /* Init DMA */
> > +       sg_init_table(&pd->sg, 1);
> > +       pd->dma_direction =3D DMA_NONE;
> > +       ret =3D sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
> > +                                            res->start + ICDR, &pd->dm=
a_rx);
> > +       if (ret =3D=3D -EPROBE_DEFER)
> > +               return ret;
> > +
> > +       ret =3D sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
> > +                                            res->start + ICDR, &pd->dm=
a_tx);
> > +       if (ret =3D=3D -EPROBE_DEFER) {
> > +               sh_mobile_i2c_release_dma(pd);
> > +               return ret;
> > +       }
> > +
>=20
> If the DTS contains "dma" and "dma-names" properties, but CONFIG_RCAR_DMAC
> is disabled, sh_mobile_i2c_request_dma_chan() returns -EPROBE_DEFER,
> and the driver fails to initialize.
>=20
> If I remove the "dma" and "dma-names" properties, the driver does fall ba=
ck
> to PIO mode.
>=20
> I think this is a regression.

The only solution I can think of is to not bail out here and retry again
before every transfer? Doesn't sound elegant, though...


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUhwKNAAoJEBQN5MwUoCm28dwP/0II5XHxsvw9AVQzugSlKeBJ
01YljEw9bzvDjjey8qvAPtiETMZC/FYKSHuQVuEXRJWwFTaFgB6Q21QI5P/IqPFh
DkHDkIzgYD7Fba29qhuiHUQB8uvMrWux2ZGnThL6W5b++6jQstVlAY1oz9M7KwCx
Lc1xuSArRw6UEKDytlaV1avEAmaWboLYHoSho3Noch0AH80dyUATdi+xSdZGfXCB
VPXKooAZey2U3m7vBUj144yjh2YKsXXZTqvhmFqGQwYXLnw57XUXXpNyvMnvEbcw
3tlpLrdgmbMYTz8F+fZ3mOfVn9+TtIBrdzLenaFc/mHZKC6kqJwD29VlUThpsrgy
V13WqKFGGTsHR/tDlno6QWvb3dfKgdm7HXmDJQappRizhxc4Jh3Z2wZThW0r53tb
rSoRpeHmEwEFHH2R2fffj1LjemkxZCWiY+JpzZ5ID+OLu6+hOZPYBKel4KnREGaK
YhoZEDp7+oQnvsOfsC0l4nr/sUmaSgjowYiO4j+rKSTvtGwjCdrNxQ0V2bXhQngC
cP6pvTxfcoGe4wOssmKpsbK9+hGipAm2DrRCnhSq58Dr4LR8ta7dgily/bieKa7d
B5gQ5tW4YRrhfdjbkVYqcrUU++BZLgmUwsHQJVf/5oH7VIfcHSEzBWhw6OGU4gO/
z9Mij5IGmBb/IolRUNBl
=R0l2
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
