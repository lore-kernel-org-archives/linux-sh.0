From: Stephen Boyd <sboyd@codeaurora.org>
Date: Tue, 23 Jun 2015 21:23:15 +0000
Subject: Re: [PATCH] clk: shmobile: Remove unneeded #include <linux/clkdev.h>
Message-Id: <5589CE43.3000508@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064967-12299-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064967-12299-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org, linux-sh@vger.kernel.org

On 06/23/2015 06:09 AM, Geert Uytterhoeven wrote:
> The CCF implementations for the various shmobile SoCs don't use clkdev
> functionality, hence drop the inclusion of <linux/clkdev.h>.
>
> Add the missing #include <linux/slab.h>, which was included implicitly
> through <asm/clkdev.h> before.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks. I've been making a sweep of all clkdev.h and clk.h includes to
properly split the API. Hopefully send it out tomorrow. I'll throw this
patch into that series.

>  drivers/clk/shmobile/clk-div6.c      | 2 +-
>  drivers/clk/shmobile/clk-r8a73a4.c   | 2 +-
>  drivers/clk/shmobile/clk-r8a7740.c   | 2 +-
>  drivers/clk/shmobile/clk-r8a7778.c   | 2 +-
>  drivers/clk/shmobile/clk-r8a7779.c   | 2 +-
>  drivers/clk/shmobile/clk-rcar-gen2.c | 4 +---
>  drivers/clk/shmobile/clk-sh73a0.c    | 2 +-
>  7 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
> index 036a692c72195db9..6810bfb6ef5e09d1 100644
> --- a/drivers/clk/shmobile/clk-div6.c
> +++ b/drivers/clk/shmobile/clk-div6.c
> @@ -11,12 +11,12 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/slab.h>
>  
>  #define CPG_DIV6_CKSTP		BIT(8)
>  #define CPG_DIV6_DIV(d)		((d) & 0x3f)
> diff --git a/drivers/clk/shmobile/clk-r8a73a4.c b/drivers/clk/shmobile/clk-r8a73a4.c
> index 29b9a0b0012ad326..9326204bed9d6cb7 100644
> --- a/drivers/clk/shmobile/clk-r8a73a4.c
> +++ b/drivers/clk/shmobile/clk-r8a73a4.c
> @@ -9,10 +9,10 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
>  #include <linux/clk/shmobile.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/spinlock.h>
> diff --git a/drivers/clk/shmobile/clk-r8a7740.c b/drivers/clk/shmobile/clk-r8a7740.c
> index 1e2eaae21e01947b..1e6b1da580658f46 100644
> --- a/drivers/clk/shmobile/clk-r8a7740.c
> +++ b/drivers/clk/shmobile/clk-r8a7740.c
> @@ -9,10 +9,10 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
>  #include <linux/clk/shmobile.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> +#include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/spinlock.h>
> diff --git a/drivers/clk/shmobile/clk-r8a7778.c b/drivers/clk/shmobile/clk-r8a7778.c
> index fa45684e220c78ae..87c1d2f2fb57a46c 100644
> --- a/drivers/clk/shmobile/clk-r8a7778.c
> +++ b/drivers/clk/shmobile/clk-r8a7778.c
> @@ -9,9 +9,9 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
>  #include <linux/clk/shmobile.h>
>  #include <linux/of_address.h>
> +#include <linux/slab.h>
>  
>  struct r8a7778_cpg {
>  	struct clk_onecell_data data;
> diff --git a/drivers/clk/shmobile/clk-r8a7779.c b/drivers/clk/shmobile/clk-r8a7779.c
> index e42a63a2ad251de2..92275c5f2c60303e 100644
> --- a/drivers/clk/shmobile/clk-r8a7779.c
> +++ b/drivers/clk/shmobile/clk-r8a7779.c
> @@ -11,12 +11,12 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
>  #include <linux/clk/shmobile.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
>  #include <dt-bindings/clock/r8a7779-clock.h>
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
>  #include <linux/spinlock.h>
>  
>  struct rcar_gen2_cpg {
> diff --git a/drivers/clk/shmobile/clk-sh73a0.c b/drivers/clk/shmobile/clk-sh73a0.c
> index cd529cfe412f1d18..8966f8bbfd726e62 100644
> --- a/drivers/clk/shmobile/clk-sh73a0.c
> +++ b/drivers/clk/shmobile/clk-sh73a0.c
> @@ -9,12 +9,12 @@
>   */
>  
>  #include <linux/clk-provider.h>
> -#include <linux/clkdev.h>
>  #include <linux/clk/shmobile.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
>  struct sh73a0_cpg {


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

