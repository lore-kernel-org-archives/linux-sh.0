From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Feb 2015 18:14:29 +0000
Subject: Re: [PATCH] drivers: sh: Remove test for now unsupported sh7372
Message-Id: <20150219181428.GG18262@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424368006-21430-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1424368006-21430-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 19, 2015 at 06:46:46PM +0100, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends contextually on "[PATCH v3 0/2] ARM: shmobile: sh73a0: Enable DT PM
> domain support".

Thanks, applied.

> ---
>  drivers/sh/pm_runtime.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
> index 89b7785de1fcf5b7..fe8875f0d7be1155 100644
> --- a/drivers/sh/pm_runtime.c
> +++ b/drivers/sh/pm_runtime.c
> @@ -91,8 +91,7 @@ static int __init sh_pm_runtime_init(void)
>  		    !of_machine_is_compatible("renesas,r8a7791") &&
>  		    !of_machine_is_compatible("renesas,r8a7792") &&
>  		    !of_machine_is_compatible("renesas,r8a7793") &&
> -		    !of_machine_is_compatible("renesas,r8a7794") &&
> -		    !of_machine_is_compatible("renesas,sh7372"))
> +		    !of_machine_is_compatible("renesas,r8a7794"))
>  			return 0;
>  	}
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
