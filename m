From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Aug 2014 23:39:55 +0000
Subject: Re: [PATCH 1/8] clk: shmobile: Add r8a7794 support
Message-Id: <20140818233955.GG1623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377107-3822-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1408377107-3822-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 18, 2014 at 05:51:40PM +0200, Ulrich Hecht wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> 
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/clk/shmobile/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> index e002923..531d4f6 100644
> --- a/drivers/clk/shmobile/Makefile
> +++ b/drivers/clk/shmobile/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
>  obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
>  obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
>  obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
> +obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o
>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
>  # for emply built-in.o
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
