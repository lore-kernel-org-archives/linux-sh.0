From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 21 Apr 2019 15:21:21 +0000
Subject: Re: [PATCH] Fix allyesconfig output.
Message-Id: <ea7d2420-d5e8-ba3b-41da-9bf39f77f1bd@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20190421140016.89600-1-ysato@users.sourceforge.jp>
In-Reply-To: <20190421140016.89600-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 4/21/19 7:00 AM, Yoshinori Sato wrote:
> Conflict JCore-SoC and SolutionEngine 7619.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.


> ---
>  arch/sh/boards/Kconfig | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
> index b9a37057b77a..cee24c308337 100644
> --- a/arch/sh/boards/Kconfig
> +++ b/arch/sh/boards/Kconfig
> @@ -8,27 +8,19 @@ config SH_ALPHA_BOARD
>  	bool
>  
>  config SH_DEVICE_TREE
> -	bool "Board Described by Device Tree"
> +	bool
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select TIMER_OF
>  	select COMMON_CLK
>  	select GENERIC_CALIBRATE_DELAY
> -	help
> -	  Select Board Described by Device Tree to build a kernel that
> -	  does not hard-code any board-specific knowledge but instead uses
> -	  a device tree blob provided by the boot-loader. You must enable
> -	  drivers for any hardware you want to use separately. At this
> -	  time, only boards based on the open-hardware J-Core processors
> -	  have sufficient driver coverage to use this option; do not
> -	  select it if you are using original SuperH hardware.
>  
>  config SH_JCORE_SOC
>  	bool "J-Core SoC"
> -	depends on SH_DEVICE_TREE && (CPU_SH2 || CPU_J2)
> +	select SH_DEVICE_TREE
>  	select CLKSRC_JCORE_PIT
>  	select JCORE_AIC
> -	default y if CPU_J2
> +	depends on CPU_J2
>  	help
>  	  Select this option to include drivers core components of the
>  	  J-Core SoC, including interrupt controllers and timers.
> 


-- 
~Randy
