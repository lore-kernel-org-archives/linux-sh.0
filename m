From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 14 Mar 2011 08:01:30 +0000
Subject: Re: [PATCH 3/6] mmc: tmio: convert the SDHI MMC driver from MFD to
Message-Id: <Pine.LNX.4.64.1103140857350.6125@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
 <Pine.LNX.4.64.1103110846000.23675@axis700.grange>
 <AANLkTi=ywRE0omJ1t0yxqzMS4k+PpjfFH7aLtWMW7C=3@mail.gmail.com>
In-Reply-To: <AANLkTi=ywRE0omJ1t0yxqzMS4k+PpjfFH7aLtWMW7C=3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Sun, 13 Mar 2011, Magnus Damm wrote:

> On Fri, Mar 11, 2011 at 4:52 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On sh-mobile platforms the SDHI driver was using the tmio_mmc SD/SDIO
> > MFD cell driver. Now that the tmio_mmc driver has been split into a
> > core and a separate MFD glue, we can support SDHI natively without the
> > need to emulate an MFD controller. This also allows to support systems
> > with an on-SoC SDHI controller and a separate MFD with a TMIO core.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
>=20
> Nice, I believe this is the right direction..
>=20
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -92,7 +92,7 @@ struct tmio_mmc_host {
> > =A0 =A0 =A0 =A0struct tasklet_struct =A0 dma_complete;
> > =A0 =A0 =A0 =A0struct tasklet_struct =A0 dma_issue;
> > =A0 =A0 =A0 =A0struct scatterlist =A0 =A0 =A0bounce_sg;
> > -#ifdef CONFIG_TMIO_MMC_DMA
> > +#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bounce_buf=
[PAGE_CACHE_SIZE] __attribute__((aligned(TMIO_MAX_ALIGN)));
> > =A0#else
> > =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bounce_buf=
[1]; =A0/* A dummy in no-DMA case */
>=20
> ... but it would be nice if all this #ifdeffery could be avoided somehow.
>=20
> Is it possible to use devres to allocate the bounce buffer dynamically
> in the dma portion of the code?

Well, this #ifdef has been there before, it's not new. But sure, we could=20
get rid of it. Basically, what you're suggesting, is to allocate that=20
bounce buffer dynamically - whether or not using devres. Just calling=20
__get_free_page() in tmio_mmc_request_dma() and __free_pages() in=20
tmio_mmc_release_dma() should work without any memory-leaking too. Would=20
this be ok?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
