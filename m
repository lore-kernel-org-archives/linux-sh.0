From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 11 Dec 2014 05:14:26 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141211050226.GJ16827@intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QXO0/MSS4VvK6f+D"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <CANqRtoTs52ORCqY43OyPJ2ME7BBcQr3+RVGURjteFQAztDSZjg@mail.gmail.com>
 <20141210080155.GA1148@katana>
 <10746939.zT8Pinqvll@avalon>
 <20141210142314.GB8247@katana>
In-Reply-To: <20141210142314.GB8247@katana>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 03:23:15PM +0100, Wolfram Sang wrote:
> On Wed, Dec 10, 2014 at 04:19:36PM +0200, Laurent Pinchart wrote:
> > (CC'ing the dmaengine mailing list)
>=20
> Thanks!
>=20
> > On Wednesday 10 December 2014 09:01:55 Wolfram Sang wrote:
> > > On Wed, Dec 10, 2014 at 02:44:01PM +0900, Magnus Damm wrote:
> > > > On Tue, Dec 9, 2014 at 11:09 PM, Wolfram Sang <wsa@the-dreams.de> w=
rote:
> > > >> On Tue, Dec 09, 2014 at 11:53:45AM +0100, Geert Uytterhoeven wrote:
> > > >>> On Fri, Nov 7, 2014 at 11:11 AM, Wolfram Sang wrote:
> > > >>>> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> > > >>>> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> > > >>>> @@ -727,6 +886,21 @@ static int sh_mobile_i2c_probe(struct
> > > >>>> platform_device *dev)
> > > >>>>         if (ret)
> > > >>>>                 return ret;
> > > >>>>=20
> > > >>>> +       /* Init DMA */
> > > >>>> +       sg_init_table(&pd->sg, 1);
> > > >>>> +       pd->dma_direction =3D DMA_NONE;
> > > >>>> +       ret =3D sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_=
TO_MEM,
> > > >>>> +                                            res->start + ICDR,
> > > >>>> &pd->dma_rx);
> > > >>>> +       if (ret =3D=3D -EPROBE_DEFER)
> > > >>>> +               return ret;
> > > >>>> +
> > > >>>> +       ret =3D sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_=
TO_DEV,
> > > >>>> +                                            res->start + ICDR,
> > > >>>> &pd->dma_tx);
> > > >>>> +       if (ret =3D=3D -EPROBE_DEFER) {
> > > >>>> +               sh_mobile_i2c_release_dma(pd);
> > > >>>> +               return ret;
> > > >>>> +       }
> > > >>>> +
> > > >>>=20
> > > >>> If the DTS contains "dma" and "dma-names" properties, but
> > > >>> CONFIG_RCAR_DMAC is disabled, sh_mobile_i2c_request_dma_chan() re=
turns
> > > >>> -EPROBE_DEFER, and the driver fails to initialize.
> > > >>>=20
> > > >>> If I remove the "dma" and "dma-names" properties, the driver does=
 fall
> > > >>> back to PIO mode.
> > > >>>=20
> > > >>> I think this is a regression.
> > > >>=20
> > > >> The only solution I can think of is to not bail out here and retry=
 again
> > > >> before every transfer? Doesn't sound elegant, though...
> > > >=20
> > > > I think we have to request for each and every transfer. And fall ba=
ck
> > > > to PIO as default in a transparent way. This because the number of =
DMA
> > > > channels are limited compared to number of potential consumers, so
> > > > request failure may happen at any time.
> > >=20
> > > AFAIR this scenario happens when submitting the transfer. The check
> > > for this is already in place. Requesting the channel is a different
> > > matter. Still, I'll cook up a patch and we will see what it looks
> > > like...
I think this is a limitation of driver may not be for HW. The right model f=
or
dma_chan is to be viewed as SW channels and not the ones of HW (yes that is
how most of the drivers use that, but we can improve upon)

If we rework the driver to view dma_chan as SW channels, then you can accept
multiple channel requests and accept based on if we are able link the chann=
el to
that peripheral or not. Here one txn maybe for peripheral A, subsequent one
for peripheral B. The driver needs to ensure the proper mux registers etc a=
re
programmed while issuing next descriptor.

--=20
~Vinod

> >=20
> > We could fix part of the issue by using virtual dma channels. In that c=
ase=20
> > channel requests wouldn't fail anymore due to resource starvation with =
a large=20
> > number of consumers. However, the request could still fail with -EPROBE=
_DEFER.=20
> > For a driver that wants to fall back to PIO when DMA is unavailable I=
=20
> > currently don't see another way than moving the channel request at the =
time of=20
> > the transfer.
>=20
> Note that the I2C drives uses subsys_initcall() for historic reasons,
> while the DMA driver uses module_init(). This is hard to revert without
> introducing potential regressions on older boards. So, the I2C DMA
> support needs to handle deferred probe definately. I am with Laurent, I
> don't see any other way, but I'd be glad to be enlightened...
>=20



--=20

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJUiSViAAoJEHwUBw8lI4NHTXAQAJSc+71Hk5pf4rYhiHwxFaCw
FdqnDlDoSpb/Sf74siChO08XKAsf0s8z6F/L0U1heasvwJ7d33PnoBVwwM4MKzEi
2ot0EXgloQdNJsJgQaOo2UVXi9I2bGRW1S0h/I74eqQJx6YUKByhz/41Defa37/Y
Wkv4WNhun8x8aXOX4dMrjbPG5QNdgPPmG7KD66BYouh1PKnSzy+3E3ZdowdQKlzA
OEVmXR9CFnIfXeOeuN8gNDXDY767J3y/fW3s6kI0rNM23ih8Ne6+Lyvn/jkR8Gk+
TDJgq1wLIWUaErrwRRDz64Y6yssYUkq/BTl1fWSSH22DaaVKP17vCKIqYSYYpBlZ
9j9qB5h7zcKgOBZkEWpD84H+RD0R3GAnBKpztYRQaLirV2rPFHV+rLYxfcvnH42+
tVYBIfOmQPuB86lfYb1e+ZVPlPOZ6dkExOCQTUyo/EmsQVS+pGwiGTpNPvfQxZwE
/ZbG935KvxRxmn5aEbFlcryhWVj+MbXXKias2Buu7rs8k5tut7ZGgJN0A6crJrwb
yi2OLG/hnc5B1+EBeVTTdJvpnlNGuKYIF7h3tyUOKh0IbGKrkeXPCCMV4tbtPPlR
Br16+3NRAVHEINkEZ6Cjjsa5lBtUQwV6diWNOkjZARyMzP0PFj5gozzb3ucg6YYa
KugSN/v6V1zRsLaFTa5U
=cNk3
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
