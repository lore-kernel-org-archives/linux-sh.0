From: Simon Horman <horms@verge.net.au>
Date: Wed, 04 Mar 2015 01:36:42 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: Add r8a7794 reset code for SMP
Message-Id: <20150304013640.GB29532@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <54F50C76.2060803@bp.renesas.com>
In-Reply-To: <54F50C76.2060803@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Inami-san,

On Tue, Mar 03, 2015 at 10:20:54AM +0900, Gaku Inami wrote:
> Since reset vector settings is controlled by SYSC
> register, this code is added to pm-r8a7794.c.

As both this and the previous patch, which appears to create a stub
pm-r8a7794.c, are quite small I think it would make sense to squash these
two patches into one.

Moreover, I see significant overlap between pm-r8a7794.c, pm-r8a7791.c and
pm-r8a7790.c. I would like some consideration given to consolidating these.

> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> ---
>  arch/arm/mach-shmobile/pm-r8a7794.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/pm-r8a7794.c b/arch/arm/mach-shmobile/pm-r8a7794.c
> index a8a94cf..b990839 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7794.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7794.c
> @@ -9,9 +9,17 @@
>   */
>  
>  #include <asm/io.h>
> +#include "common.h"
>  #include "pm-rcar.h"
>  #include "r8a7794.h"
>  
> +/* RST */
> +#define RST		0xe6160000
> +#define CA7BAR		0x0030
> +#define CA7RESCNT	0x0044
> +
> +#define RAM		0xe63c0000
> +
>  /* SYSC */
>  #define SYSCIER 0x0c
>  #define SYSCIMR 0x10
> @@ -35,10 +43,28 @@ static inline void r8a7794_sysc_init(void) {}
>  
>  void __init r8a7794_pm_init(void)
>  {
> +	void __iomem *p;
> +	u32 bar;
>  	static int once;
>  
>  	if (once++)
>  		return;
>  
> +	/* RAM for jump stub, because BAR requires 256KB aligned address */
> +	p = ioremap_nocache(RAM, shmobile_boot_size);
> +	memcpy_toio(p, shmobile_boot_vector, shmobile_boot_size);
> +	iounmap(p);
> +
> +	/* setup reset vectors */
> +	p = ioremap_nocache(RST, 0x63);
> +	bar = (RAM >> 8) & 0xfffffc00;
> +	writel_relaxed(bar, p + CA7BAR);
> +	writel_relaxed(bar | 0x10, p + CA7BAR);
> +
> +	/* de-assert reset for all CPUs */
> +	writel_relaxed((readl_relaxed(p + CA7RESCNT) & ~0x0f) | 0x5a5a0000,
> +		       p + CA7RESCNT);
> +	iounmap(p);
> +
>  	r8a7794_sysc_init();
>  }
> -- 
> 1.7.9.5
> 
