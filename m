From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Sep 2014 00:22:09 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740 legacy: Fix copied bug in comment
Message-Id: <20140917002208.GB27426@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410897483-28164-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1410897483-28164-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 16, 2014 at 09:58:03PM +0200, Geert Uytterhoeven wrote:
> The corresponding bug in pm-sh7372.c was fixed in commit
> 70fe7b24672a988f ("ARM: shmobile: Do not access sh7372 A4S domain
> internals directly").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
>  arch/arm/mach-shmobile/pm-r8a7740.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
> index 23254c31efd98a77..17ec649f0bbf3dd7 100644
> --- a/arch/arm/mach-shmobile/pm-r8a7740.c
> +++ b/arch/arm/mach-shmobile/pm-r8a7740.c
> @@ -18,7 +18,7 @@ static int r8a7740_pd_a4s_suspend(void)
>  {
>  	/*
>  	 * The A4S domain contains the CPU core and therefore it should
> -	 * only be turned off if the CPU is in use.
> +	 * only be turned off if the CPU is not in use.
>  	 */
>  	return -EBUSY;
>  }
> -- 
> 1.9.1
> 
