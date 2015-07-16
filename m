From: Stephen Boyd <sboyd@codeaurora.org>
Date: Thu, 16 Jul 2015 00:08:19 +0000
Subject: Re: [PATCH] clk: shmobile: Remove unneeded #include <linux/clkdev.h>
Message-Id: <20150716000819.GU30412@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064967-12299-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064967-12299-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-sh@vger.kernel.org

On 06/23, Geert Uytterhoeven wrote:
> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
> index 9612e3145b7ea370..745496f7ee9c7402 100644
> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
> @@ -11,15 +11,13 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
>  #include <linux/clk/shmobile.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/math64.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/pm_clock.h>
> -#include <linux/pm_domain.h>
> +#include <linux/slab.h>

Is this the right diff? I wanted to apply this to clk-next but it
fails here because we don't have the pm_clock.h and pm_domain.h
includes in this file.

>  #include <linux/spinlock.h>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
