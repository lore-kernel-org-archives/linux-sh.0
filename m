From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 09 Jan 2014 17:42:38 +0000
Subject: Re: [PATCH] ARM: shmobile: clk_get() returns error code on failure
Message-Id: <1608206.pzDrTMclkD@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389281623-10253-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389281623-10253-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

Thank you for the patch.

On Thursday 09 January 2014 15:33:43 Ben Dooks wrote:
> The lager_add_standard_devices() function calls clk_get() but then fails
> to check that it returns an error pointer instead of NULL on failure.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Do you plan to submit a similar patch for board-koelsch-reference.c ? I don't 
mind doing it.

> ---
>  arch/arm/mach-shmobile/board-lager-reference.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-lager-reference.c
> b/arch/arm/mach-shmobile/board-lager-reference.c index a6e271d..dc8d76b
> 100644
> --- a/arch/arm/mach-shmobile/board-lager-reference.c
> +++ b/arch/arm/mach-shmobile/board-lager-reference.c
> @@ -44,14 +44,14 @@ static void __init lager_add_standard_devices(void)
> 
>  	for (i = 0; i < ARRAY_SIZE(scif_names); ++i) {
>  		clk = clk_get(NULL, scif_names[i]);
> -		if (clk) {
> +		if (!IS_ERR(clk)) {
>  			clk_register_clkdev(clk, NULL, "sh-sci.%u", i);
>  			clk_put(clk);
>  		}
>  	}
> 
>  	clk = clk_get(NULL, "cmt0");
> -	if (clk) {
> +	if (!IS_ERR(clk)) {
>  		clk_register_clkdev(clk, NULL, "sh_cmt.0");
>  		clk_put(clk);
>  	}
-- 
Regards,

Laurent Pinchart

