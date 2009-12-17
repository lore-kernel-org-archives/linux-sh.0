From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 17 Dec 2009 07:42:39 +0000
Subject: Re: [PATCH 5/5] sh: dmaengine support for sh7724
Message-Id: <Pine.LNX.4.64.0912170841010.5991@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange> 
 <Pine.LNX.4.64.0912041942330.3981@axis700.grange>
 <e9c3a7c20912071702h1aea2026kff22db99a221f6c4@mail.gmail.com> 
 <20091208071302.GA23814@linux-sh.org> <29ab51dc0912161914w6967c9d1l79df27d670f01b6a@mail.gmail.com>
In-Reply-To: <29ab51dc0912161914w6967c9d1l79df27d670f01b6a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hi again

On Thu, 17 Dec 2009, Nobuhiro Iwamatsu wrote:

> Hi,
>=20
> 2009/12/8 Paul Mundt <lethal@linux-sh.org>:
> > On Mon, Dec 07, 2009 at 06:02:24PM -0700, Dan Williams wrote:
> >> On Fri, Dec 4, 2009 at 11:45 AM, Guennadi Liakhovetski
> >> <g.liakhovetski@gmx.de> wrote:
> >> > Add a dmaengine platform device to sh7724, fix DMA channel interrupt=
 numbers.
> >> >
> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >> > ---
> >> >
> >> > With this patch dmatest works with channels 0-5, channels 6-11 still=
 don't
> >> > work for some reason... So, feel free to discard it for now, if a co=
mplete
> >> > fix would be preferred.
> >>
> >> Does this patch limit operation to channels 0-5? =A0I leave this one f=
or
> >> Paul to disposition.
> >>
> > There are 6 channels per controller, so the fact that the second
> > controller isn't working could either be cause the driver needs more wo=
rk
> > to handle multiple controllers properly, or there could be a pinmux iss=
ue
> > that hasn't been resolved yet for DMAC1. Both of these cases require the
> > driver to be a bit smarter, but as Guennadi is presently working on the=
se
> > things, doing them incrementally is ok with me. If this gets DMAC0
> > working at least where it wasn't before, it's certainly worth applying.
> > DMAC1 seems to have more problems than just wrong interrupt numbers, so
> > this isn't going to cause any regressions there either.
> >
> > Acked-by: Paul Mundt <lethal@linux-sh.org>
>=20
> This patch can not apply Paul's git/HEAD too.
> I updated patch.
>=20
> Acked-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Same comment applies as to the other my patch. Paul, I think, you=20
indicated, that you've already merged my patch, or at least, that you have =

no problem merging it. Please, do use my original version and not this=20
one.

Thanks
Guennadi

>=20
> Best regards,
>   Nobuhiro
>=20
> -----
>=20
> Add a dmaengine platform device to sh7724, fix DMA channel interrupt numb=
ers.
>=20
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  arch/sh/include/cpu-sh4/cpu/dma-sh4a.h |    8 ++++----
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   15 +++++++++++++++
>  2 files changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
> b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
> index f0886bc..c4ed660 100644
> --- a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
> +++ b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
> @@ -19,10 +19,10 @@
>  #elif defined(CONFIG_CPU_SUBTYPE_SH7723) || \
>        defined(CONFIG_CPU_SUBTYPE_SH7724)
>  #define DMTE0_IRQ	48	/* DMAC0A*/
> -#define DMTE4_IRQ	40	/* DMAC0B */
> -#define DMTE6_IRQ	42
> -#define DMTE8_IRQ	76	/* DMAC1A */
> -#define DMTE9_IRQ	77
> +#define DMTE4_IRQ	76	/* DMAC0B */
> +#define DMTE6_IRQ	40
> +#define DMTE8_IRQ	42	/* DMAC1A */
> +#define DMTE9_IRQ	43
>  #define DMTE10_IRQ	72	/* DMAC1B */
>  #define DMTE11_IRQ	73
>  #define DMAE0_IRQ	78	/* DMA Error IRQ*/
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> index a52f351..d32f96c 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> @@ -23,9 +23,23 @@
>  #include <linux/notifier.h>
>  #include <asm/suspend.h>
>  #include <asm/clock.h>
> +#include <asm/dma-sh.h>
>  #include <asm/mmzone.h>
>  #include <cpu/sh7724.h>
>=20
> +/* DMA */
> +static struct sh_dmae_pdata dma_platform_data =3D {
> +	.mode =3D SHDMA_DMAOR1,
> +};
> +
> +static struct platform_device dma_device =3D {
> +	.name	=3D "sh-dma-engine",
> +	.id		=3D -1,
> +	.dev	=3D {
> +		.platform_data	=3D &dma_platform_data,
> +	},
> +};
> +
>  /* Serial */
>  static struct plat_sci_port scif0_platform_data =3D {
>  	.mapbase        =3D 0xffe00000,
> @@ -649,6 +663,7 @@ static struct platform_device *sh7724_devices[]
> __initdata =3D {
>  	&tmu3_device,
>  	&tmu4_device,
>  	&tmu5_device,
> +	&dma_device,
>  	&rtc_device,
>  	&iic0_device,
>  	&iic1_device,
> --=20
> 1.6.5.4
>=20

---
Guennadi Liakhovetski
