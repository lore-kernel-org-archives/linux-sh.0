From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 15 Apr 2012 21:59:57 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: bonito: make sure static function
Message-Id: <201204160002.50008.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, April 09, 2012, Kuninori Morimoto wrote:
> bonito_add_early_devices() needs static
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied to the r8a7740 branch of the renesas.git tree.

Thanks,
Rafael


> ---
>  arch/arm/mach-shmobile/board-bonito.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
> index 81fd95f..63ab706 100644
> --- a/arch/arm/mach-shmobile/board-bonito.c
> +++ b/arch/arm/mach-shmobile/board-bonito.c
> @@ -486,7 +486,7 @@ static void __init bonito_earlytimer_init(void)
>  	shmobile_earlytimer_init();
>  }
>  
> -void __init bonito_add_early_devices(void)
> +static void __init bonito_add_early_devices(void)
>  {
>  	r8a7740_add_early_devices();
>  
> 

