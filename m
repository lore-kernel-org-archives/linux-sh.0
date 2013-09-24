From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Sep 2013 06:19:33 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw: tidyup select SND_SOC_xxx on Kconfig
Message-Id: <20130924061931.GD16181@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8761tqsqs7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761tqsqs7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 23, 2013 at 11:00:16PM -0700, Kuninori Morimoto wrote:
> bf622b33d6fd40f720430ec2fe3c62a8aee19ee8
> (ARM: shmobile: bockw: add R-Car sound support (PIO))
> added R-Car sound support on Bock-W, but the Kconfig
> file had comflict.
> The necessary settings (select SND_SOC_xxx) was added
> on MACH_KZM9D, but it was needed on MACH_BOCKW.
> This patch fixes it up.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Simon
> 
> This patch is based on renesas-devel-20130922 tag

Hi Morimoto-san,

is this a fix for v3.12?

>  arch/arm/mach-shmobile/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 50bab8d..eda2857 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -168,6 +168,8 @@ config MACH_BOCKW
>  	select RENESAS_INTC_IRQPIN
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select USE_OF
> +	select SND_SOC_AK4554 if SND_SIMPLE_CARD
> +	select SND_SOC_AK4642 if SND_SIMPLE_CARD
>  
>  config MACH_BOCKW_REFERENCE
>  	bool "BOCK-W  - Reference Device Tree Implementation"
> @@ -229,8 +231,6 @@ config MACH_KZM9D
>  	depends on ARCH_EMEV2
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select USE_OF
> -	select SND_SOC_AK4554 if SND_SIMPLE_CARD
> -	select SND_SOC_AK4642 if SND_SIMPLE_CARD
>  
>  config MACH_KZM9D_REFERENCE
>  	bool "KZM9D board - Reference Device Tree Implementation"
> -- 
> 1.7.9.5
> 
