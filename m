From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 18 Mar 2014 13:25:53 +0000
Subject: Re: [PATCH] ARM: shmobile: Add Lager clock workarounds for SDHI and MMCIF
Message-Id: <1920956.JQLZtHPQVp@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20140318125247.21670.94176.sendpatchset@w520>
In-Reply-To: <20140318125247.21670.94176.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tuesday 18 March 2014 21:52:47 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add MMCIF1, SDHI0 and SDHI2 to the clock workaround list for
> Lager multiplatform. Without these additional lines wakeup
> from Suspend-to-RAM never happens.

What about fixing the root cause instead of piling up hacks ?

> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Written against renesas-devel-v3.14-rc7-20140318
> 
>  arch/arm/mach-shmobile/board-lager-reference.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- 0001/arch/arm/mach-shmobile/board-lager-reference.c
> +++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-03-18
> 19:36:34.000000000 +0900 @@ -114,7 +114,10 @@ static const struct clk_name
> clk_names[]
>  static const struct clk_name clk_enables[] __initconst = {
>  	{ "ether", NULL, "ee700000.ethernet" },
>  	{ "msiof1", NULL, "e6e10000.spi" },
> +	{ "mmcif1", NULL, "ee220000.mmc" },
>  	{ "qspi_mod", NULL, "e6b10000.spi" },
> +	{ "sdhi0", NULL, "ee100000.sd" },
> +	{ "sdhi2", NULL, "ee140000.sd" },
>  	{ "thermal", NULL, "e61f0000.thermal" },
>  };

-- 
Regards,

Laurent Pinchart

