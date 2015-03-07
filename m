From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 00:09:53 +0000
Subject: Re: [PATCH 05/11] ARM: shmobile: r8a7793: add power management support
Message-Id: <20150307000953.GJ19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-6-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-6-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Mar 06, 2015 at 06:09:52PM +0100, Ulrich Hecht wrote:
> Not used yet because it depends on SMP.
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
> [uli: moved reset handling from SMP code, minor adjustments]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---

As I mentioned elsewhere there seems to be some scope for sharing code
across SoCs.

More comments below...

>  arch/arm/mach-shmobile/Makefile     |   2 +-
>  arch/arm/mach-shmobile/pm-r8a7793.c | 273 ++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/r8a7793.h    |   6 +
>  3 files changed, 280 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-shmobile/pm-r8a7793.c
>  create mode 100644 arch/arm/mach-shmobile/r8a7793.h

[snip]

> diff --git a/arch/arm/mach-shmobile/pm-r8a7793.c b/arch/arm/mach-shmobile/pm-r8a7793.c
> new file mode 100644
> index 0000000..a59ac8d
> --- /dev/null
> +++ b/arch/arm/mach-shmobile/pm-r8a7793.c
> @@ -0,0 +1,273 @@
> +/*
> + * r8a7793 Power management support
> + *
> + * Copyright (C) 2014  Renesas Electronics Corporation
> + * Copyright (C) 2015  Ulrich Hecht
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/pm_clock.h>
> +#include <linux/pm_domain.h>
> +#include <linux/smp.h>
> +#include <asm/io.h>
> +#include "common.h"
> +#include "pm-rcar.h"
> +#include "r8a7793.h"
> +
> +#define RST		0xe6160000
> +#define CA15BAR		0x0020
> +#define CA15RESCNT	0x0040
> +#define RAM		0xe63c0000
> +
> +/* SYSC */
> +#define SYSCIER 0x0c
> +#define SYSCIMR 0x10
> +
> +struct r8a7793_pm_domain {
> +	struct generic_pm_domain genpd;
> +	struct rcar_sysc_ch ch;
> +};
> +
> +static inline struct rcar_sysc_ch *to_r8a7793_ch(struct generic_pm_domain *d)
> +{
> +	return &container_of(d, struct r8a7793_pm_domain, genpd)->ch;
> +}
> +
> +#if defined(CONFIG_PM) || defined(CONFIG_SMP)
> +
> +static void __init r8a7793_sysc_init(void)
> +{
> +	void __iomem *base = rcar_sysc_init(0xe6180000);
> +
> +	/* enable all interrupt sources, but do not use interrupt handler */
> +	iowrite32(0x0131000e, base + SYSCIER);
> +	iowrite32(0, base + SYSCIMR);

There was some discussion of the value to write to SYSCIER in
response to "ARM: shmobile: r8a7794 SYSC setup code":

  >> Is it intentional that 0x00310060 differs from
  >> the value of 0x0131000e used on the r8a7790 and r8a7791?
  >
  > Yes. According to R-CAR Gen2 HW manual, interrupt bits are
  > different in each SoC. Therefore, I think the setting value
  > of SYSCIER should be set to a different value in each SoC.
  >
  > *Setting value of SYSCIER
  >  r8a7790 : 0x013111EF
  >  r8a7791 : 0x00111003
  >  r8a7794 : 0x00310060
  >
  > I don't know why the value of 0x0131000e is used on the r8a7790
  > and the r8a7791. (maybe wrong value)

  This value was most probably just copied from pm-r8a7779.c
  R-Car H1 has 4 four ARM cores, but there's no interrupt bit for ARM0,
  hence the 0xe value for the lowest nibble.

With the above in mind it seems likely to me that the use of
0x0131000e for the r8a7793 is incorrect. From my brief reading of the
above and the documentation it seems to me that as per the r8a7791,
the value should be 0x00111003.

[snip]
