From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jun 2015 23:49:03 +0000
Subject: Re: [PATCH 2/2] clocksource: sh_cmt: Remove obsolete sh-cmt-48-gen2 platform_device_id entry
Message-Id: <20150623234903.GD9988@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064189-10889-1-git-send-email-geert+renesas@glider.be>
 <1435064189-10889-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064189-10889-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Jun 23, 2015 at 02:56:29PM +0200, Geert Uytterhoeven wrote:
> Since commit 914d7d148411997c ("ARM: shmobile: r8a73a4: Remove legacy
> code"), all former users of the "sh-cmt-48-gen2" platform device name
> are only supported in generic DT-only ARM multi-platform builds.  The
> driver doesn't need to match platform devices by name anymore, hence
> remove the corresponding platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/clocksource/sh_cmt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
> index c123eb5c3e28c868..ef799532a7a7963e 100644
> --- a/drivers/clocksource/sh_cmt.c
> +++ b/drivers/clocksource/sh_cmt.c
> @@ -936,7 +936,6 @@ static const struct platform_device_id sh_cmt_id_table[] = {
>  	{ "sh-cmt-16", (kernel_ulong_t)&sh_cmt_info[SH_CMT_16BIT] },
>  	{ "sh-cmt-32", (kernel_ulong_t)&sh_cmt_info[SH_CMT_32BIT] },
>  	{ "sh-cmt-48", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT] },
> -	{ "sh-cmt-48-gen2", (kernel_ulong_t)&sh_cmt_info[SH_CMT_48BIT_GEN2] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, sh_cmt_id_table);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
