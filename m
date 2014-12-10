From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 10 Dec 2014 14:23:15 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141210142314.GB8247@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vGgW1X5XWziG23Ko"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <CANqRtoTs52ORCqY43OyPJ2ME7BBcQr3+RVGURjteFQAztDSZjg@mail.gmail.com>
 <20141210080155.GA1148@katana>
 <10746939.zT8Pinqvll@avalon>
In-Reply-To: <10746939.zT8Pinqvll@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 04:19:36PM +0200, Laurent Pinchart wrote:
> (CC'ing the dmaengine mailing list)

Thanks!

> On Wednesday 10 December 2014 09:01:55 Wolfram Sang wrote:
> > On Wed, Dec 10, 2014 at 02:44:01PM +0900, Magnus Damm wrote:
> > > On Tue, Dec 9, 2014 at 11:09 PM, Wolfram Sang <wsa@the-dreams.de> wro=
te:
> > >> On Tue, Dec 09, 2014 at 11:53:45AM +0100, Geert Uytterhoeven wrote:
> > >>> On Fri, Nov 7, 2014 at 11:11 AM, Wolfram Sang wrote:
> > >>>> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> > >>>> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> > >>>> @@ -727,6 +886,21 @@ static int sh_mobile_i2c_probe(struct
> > >>>> platform_device *dev)
> > >>>>         if (ret)
> > >>>>                 return ret;
> > >>>>=20
> > >>>> +       /* Init DMA */
> > >>>> +       sg_init_table(&pd->sg, 1);
> > >>>> +       pd->dma_direction =3D DMA_NONE;
> > >>>> +       ret =3D sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO=
_MEM,
> > >>>> +                                            res->start + ICDR,
> > >>>> &pd->dma_rx);
> > >>>> +       if (ret =3D=3D -EPROBE_DEFER)
> > >>>> +               return ret;
> > >>>> +
> > >>>> +       ret =3D sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO=
_DEV,
> > >>>> +                                            res->start + ICDR,
> > >>>> &pd->dma_tx);
> > >>>> +       if (ret =3D=3D -EPROBE_DEFER) {
> > >>>> +               sh_mobile_i2c_release_dma(pd);
> > >>>> +               return ret;
> > >>>> +       }
> > >>>> +
> > >>>=20
> > >>> If the DTS contains "dma" and "dma-names" properties, but
> > >>> CONFIG_RCAR_DMAC is disabled, sh_mobile_i2c_request_dma_chan() retu=
rns
> > >>> -EPROBE_DEFER, and the driver fails to initialize.
> > >>>=20
> > >>> If I remove the "dma" and "dma-names" properties, the driver does f=
all
> > >>> back to PIO mode.
> > >>>=20
> > >>> I think this is a regression.
> > >>=20
> > >> The only solution I can think of is to not bail out here and retry a=
gain
> > >> before every transfer? Doesn't sound elegant, though...
> > >=20
> > > I think we have to request for each and every transfer. And fall back
> > > to PIO as default in a transparent way. This because the number of DMA
> > > channels are limited compared to number of potential consumers, so
> > > request failure may happen at any time.
> >=20
> > AFAIR this scenario happens when submitting the transfer. The check
> > for this is already in place. Requesting the channel is a different
> > matter. Still, I'll cook up a patch and we will see what it looks
> > like...
>=20
> We could fix part of the issue by using virtual dma channels. In that cas=
e=20
> channel requests wouldn't fail anymore due to resource starvation with a =
large=20
> number of consumers. However, the request could still fail with -EPROBE_D=
EFER.=20
> For a driver that wants to fall back to PIO when DMA is unavailable I=20
> currently don't see another way than moving the channel request at the ti=
me of=20
> the transfer.

Note that the I2C drives uses subsys_initcall() for historic reasons,
while the DMA driver uses module_init(). This is hard to revert without
introducing potential regressions on older boards. So, the I2C DMA
support needs to handle deferred probe definately. I am with Laurent, I
don't see any other way, but I'd be glad to be enlightened...


--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiFdSAAoJEBQN5MwUoCm2fR4P/ixJ2eIf0mc5RHsZoAel/0oS
ep/yHfq4pxGv71YYLoAKhKGcnH/X3xsGS3XVx46gQfmvT64ChNDvlarSJMuBIq0m
SSN22hbpds0GJy1zVu+RR7BFTGH4/xI+O3EkMcqOX9gRC3oEzw3GI4bUwFo6DzWJ
lKUVB02T0/8jmevWOipbdxDm6jLkr5U2NlTNYIJ4m37thvfvD8G0g4CJJ3raLSIo
+ZOoCRMDabiFOfPjZw9uJg8leQJKFoF1ucZncznZY/ReXXUkv0n8/UFEBOQSri6V
0JXV8xDOeCLhHD89/bR7B98T6tTd3Ifj+2jycW0ScBNnKjY+Ej9WPI+u5XIg5yzm
EjusyQFZw77V8jrEN9QR31dRE8Trr31HK1VH7YR8WmzEsIZTsqww8mOdBguYMQaE
6kO0tpWV8lG5gOU4t035F1m3wF+51Raw6x6qhAtz2m1cevCtORMjCxz71UlN3maY
2NPSyD5Ui7lwTEr/NHZLWf+7GWvt5blO/N+12hpvUJCsMp5BKzLBMrpL1nzNq7Sd
tJtRt53dViZijUijCzmVOKD1rDNnktKMW88Q1zGexlK3RZL0ESwbzBD/+j4d54sD
SIij3GQ29k2nag0RoeUUnTSrJBlg9wva6McpbGmQpasZusuSdHFs71faly6RF0LR
cdd3v+pAQz78h1tIYUuZ
=rM4O
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
