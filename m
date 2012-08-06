From: phil.edworthy@renesas.com
Date: Mon, 06 Aug 2012 08:51:05 +0000
Subject: Re: [PATCH 2/2] marzen: add SDHI0 support
Message-Id: <OFBF1C5F7B.37783A37-ON80257A52.0030979F-80257A52.00309F16@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1342526039-11128-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1342526039-11128-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

> I tested this patch, and it works well.
> But this is small comment from me.
Thanks for testing.

> > ---
> >  arch/arm/mach-shmobile/board-marzen.c |   48 ++++++++++++++++++++
> +++++++++++++
> >  1 files changed, 48 insertions(+), 0 deletions(-)
> 
> it is better if this patch update defconfig
Ok, will do.

> > diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/
> mach-shmobile/board-marzen.c
> > index 3a528cf..3c54a2f 100644
> > --- a/arch/arm/mach-shmobile/board-marzen.c
> > +++ b/arch/arm/mach-shmobile/board-marzen.c
> > @@ -30,6 +30,8 @@
> >  #include <linux/regulator/fixed.h>
> >  #include <linux/regulator/machine.h>
> >  #include <linux/smsc911x.h>
> > +#include <linux/mmc/sh_mobile_sdhi.h>
> > +#include <linux/mfd/tmio.h>
> >  #include <mach/hardware.h>
> >  #include <mach/r8a7779.h>
> >  #include <mach/common.h>
> > @@ -75,8 +77,44 @@ static struct platform_device eth_device = {
> >     .num_resources   = ARRAY_SIZE(smsc911x_resources),
> >  };
> > 
> > +/* Fixed 3.3V regulator to be used by SDHI0 */
> > +static struct regulator_consumer_supply fixed3v3_power_consumers[] > > +{
> > +   REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
> > +   REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
> > +};
> 
> I got warning
> 
> ${LINUX}/arch/arm/mach-shmobile/board-marzen.c:81:41: \
>    warning: 'fixed3v3_power_consumers' defined but not used [-
> Wunused-variable]
I missed the setup of the regulator, I'll fix this.

<snip>
> > +static struct sh_mobile_sdhi_info sdhi0_platform_data = {
> > +   .tmio_flags   = (TMIO_MMC_WRPROTECT_DISABLE
> > +           | TMIO_MMC_HAS_IDLE_WAIT),
> 
>    .tmio_flags =   TMIO_MMC_WRPROTECT_DISABLE |
>          TMIO_MMC_HAS_IDLE_WAIT,
> 
> is readable for me.
Ok, I'll fix.

Thanks
Phil
