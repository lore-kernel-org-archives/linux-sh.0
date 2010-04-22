From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 22 Apr 2010 06:20:48 +0000
Subject: Re: [PATCH 6/8] SH: Add SDHI DMA support to ms7724se
Message-Id: <Pine.LNX.4.64.1004220813110.4655@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
 <Pine.LNX.4.64.1004211735180.5292@axis700.grange>
 <m2xaec7e5c31004211718t85936386k6c0f09684b17b10f@mail.gmail.com>
In-Reply-To: <m2xaec7e5c31004211718t85936386k6c0f09684b17b10f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

On Wed, 21 Apr 2010, Magnus Damm wrote:

> On Wed, Apr 21, 2010 at 11:37 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > @@ -456,11 +458,20 @@ static struct resource sdhi0_cn7_resources[] =3D {
> > =A0 =A0 =A0 =A0},
> > =A0};
> >
> > +static struct sh_mobile_sdhi_info sh7724_sdhi0_data =3D {
> > + =A0 =A0 =A0 .dma_slave_tx =A0 =3D SHDMA_SLAVE_SDHI0_TX,
> > + =A0 =A0 =A0 .dma_slave_rx =A0 =3D SHDMA_SLAVE_SDHI0_RX,
> > + =A0 =A0 =A0 .tmio_flags =A0 =A0 =3D TMIO_IMMEDIATE_RX_COMPLETE,
> > +};
> > +
> > =A0static struct platform_device sdhi0_cn7_device =3D {
> > =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "sh_mobile_sdhi",
> > =A0 =A0 =A0 =A0.id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> > =A0 =A0 =A0 =A0.num_resources =A0=3D ARRAY_SIZE(sdhi0_cn7_resources),
> > =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D sdhi0_cn7_resources,
> > + =A0 =A0 =A0 .dev =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &sh7724_sdhi0_data,
> > + =A0 =A0 =A0 },
> > =A0 =A0 =A0 =A0.archdata =3D {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.hwblk_id =3D HWBLK_SDHI0,
> > =A0 =A0 =A0 =A0},
> > @@ -479,11 +490,19 @@ static struct resource sdhi1_cn8_resources[] =3D {
> > =A0 =A0 =A0 =A0},
> > =A0};
> >
> > +static struct sh_mobile_sdhi_info sh7724_sdhi1_data =3D {
> > + =A0 =A0 =A0 .dma_slave_tx =3D SHDMA_SLAVE_SDHI1_TX,
> > + =A0 =A0 =A0 .dma_slave_rx =3D SHDMA_SLAVE_SDHI1_RX,
>=20
> And these two are the opposite of Ecovec even though both are sh7724? Hm..

Right, that's wrong. I mean, yes, they did behave differently in my tests. =

On both boards I only could test one slot, so, I just presume the other=20
one should behave equally. So, this flag should be present on SE and not=20
on ecovec. Will fix in the next revision, thanks.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
