From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jun 2015 23:48:44 +0000
Subject: Re: [PATCH 1/2] clocksource: sh_cmt: Remove obsolete sh-cmt-32-fast platform_device_id entry
Message-Id: <20150623234843.GC9988@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064189-10889-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064189-10889-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Jun 23, 2015 at 02:56:28PM +0200, Geert Uytterhoeven wrote:
> Since commit 59b89af1d5551c12 ("ARM: shmobile: sh7372: Remove Legacy C
> SoC code"), there are no more users left of the "sh-cmt-32-fast"
> platform device name. Hence remove the corresponding platform_device_id
> entry from the driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/clocksource/sh_cmt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
> index c96de14036a0adeb..c123eb5c3e28c868 100644
> --- a/drivers/clocksource/sh_cmt.c
> +++ b/drivers/clocksource/sh_cmt.c
> @@ -935,7 +935,6 @@ static int sh_cmt_map_memory(struct sh_cmt_device *cmt)
>  static const struct platform_device_id sh_cmt_id_table[] = {
>  	{ "sh-cmt-16", (kernel_ulong_t)&sh_cmt_info[SH_CMT_16BIT] },
>  	{ "sh-cmt-32", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT] },
> -	{ "sh-cmt-32-fast", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT_FAST] },
>  	{ "sh-cmt-48", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT] },
>  	{ "sh-cmt-48-gen2", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT_GEN2] },
>  	{ }
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
