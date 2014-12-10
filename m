From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 10 Dec 2014 08:01:55 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141210080155.GA1148@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <1415355104-2031-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdW7Y_OXWySwxDch82gcGv0fyFPQAxXwSFKQz-QbDN4cPQ@mail.gmail.com>
 <20141209140917.GA3386@katana>
 <CANqRtoTs52ORCqY43OyPJ2ME7BBcQr3+RVGURjteFQAztDSZjg@mail.gmail.com>
In-Reply-To: <CANqRtoTs52ORCqY43OyPJ2ME7BBcQr3+RVGURjteFQAztDSZjg@mail.gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 02:44:01PM +0900, Magnus Damm wrote:
> Hi Wolfram, Geert,
>=20
> On Tue, Dec 9, 2014 at 11:09 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > On Tue, Dec 09, 2014 at 11:53:45AM +0100, Geert Uytterhoeven wrote:
> >> Hi Wolfram,
> >>
> >> On Fri, Nov 7, 2014 at 11:11 AM, Wolfram Sang <wsa@the-dreams.de> wrot=
e:
> >> > --- a/drivers/i2c/busses/i2c-sh_mobile.c
> >> > +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> >> > @@ -727,6 +886,21 @@ static int sh_mobile_i2c_probe(struct platform_=
device *dev)
> >> >         if (ret)
> >> >                 return ret;
> >> >
> >> > +       /* Init DMA */
> >> > +       sg_init_table(&pd->sg, 1);
> >> > +       pd->dma_direction =3D DMA_NONE;
> >> > +       ret =3D sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_M=
EM,
> >> > +                                            res->start + ICDR, &pd-=
>dma_rx);
> >> > +       if (ret =3D=3D -EPROBE_DEFER)
> >> > +               return ret;
> >> > +
> >> > +       ret =3D sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_D=
EV,
> >> > +                                            res->start + ICDR, &pd-=
>dma_tx);
> >> > +       if (ret =3D=3D -EPROBE_DEFER) {
> >> > +               sh_mobile_i2c_release_dma(pd);
> >> > +               return ret;
> >> > +       }
> >> > +
> >>
> >> If the DTS contains "dma" and "dma-names" properties, but CONFIG_RCAR_=
DMAC
> >> is disabled, sh_mobile_i2c_request_dma_chan() returns -EPROBE_DEFER,
> >> and the driver fails to initialize.
> >>
> >> If I remove the "dma" and "dma-names" properties, the driver does fall=
 back
> >> to PIO mode.
> >>
> >> I think this is a regression.
> >
> > The only solution I can think of is to not bail out here and retry again
> > before every transfer? Doesn't sound elegant, though...
>=20
> I think we have to request for each and every transfer. And fall back
> to PIO as default in a transparent way. This because the number of DMA
> channels are limited compared to number of potential consumers, so
> request failure may happen at any time.

AFAIR this scenario happens when submitting the transfer. The check
for this is already in place. Requesting the channel is a different
matter. Still, I'll cook up a patch and we will see what it looks
like...


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUh/3zAAoJEBQN5MwUoCm2Op8QAKuvmMAG0ho61bT0fOAx+Nm/
BKh2p7nIJXzc0T3vYoYL/uh9wdG42nMxAphcXCCLrjAAUw6/+fFSqiWuHMe8tZPj
Qwqw6l3Q3sakL43B7CRkm9YKpUgIV+d/I2dNTJaS+dkiRQPOsxrXR1ATBN/uiP1j
RmeQEuMzobvU4XlMMTJ61hXvsPFyLLFw1tmKvB72pUWOEN5lRvBU+Q7IOsyo8iM5
c59eVwqf6z4er8ObIutnXPvQ0CLoXjy+y+JxcdPi/BN8OPGFOm1PaS1dwYjEdiF/
+VKeJSjV1eV8RU6pmLV8zBzd6btCnkxzDA9U1XRid5BPmoQR8xFXHVch9ybYTxd9
aTvZWlogLlWeYojkADAQ+AjP3BfDV1/LbToiAeTgvKwTo7ANXSf+1b4i17ENk5O0
NMdtNjK4G7CAysxCJ5K+zIxkPiJhqIP2f3evRxWreocKxvi17yNKvyE5VVEGH3t6
GZgB3jgNUVBxca/dEaN+RurgXldsRZTKuD/H5VBZf2tYpxmC0JgToztzO5BhI/r6
UDkQxliGw2ahc7QInXoslKrhP5gaLllcNPbUz7EY33e5OJBbci8WEijHFFDiXzmC
OEFleo3MhTxU7QL6D5wrod2/vOt27pZu2UoOfy34HKm9LfKKabj8tbKeV2EAQFXx
aythhnZ2ahgZLW6Y72Qy
=xo2X
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
