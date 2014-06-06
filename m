From: Nishanth Menon <nm@ti.com>
Date: Fri, 06 Jun 2014 14:33:19 +0000
Subject: Re: [PATCH] PM / OPP: Remove ARCH_HAS_OPP
Message-Id: <5391D12F.4020501@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1402051016-28853-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1402051016-28853-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 06/06/2014 05:36 AM, Mark Brown wrote:
[...]
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 0ba4826..524b027 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -12,7 +12,6 @@ config ARCH_OMAP3
>  	bool "TI OMAP3"
>  	depends on ARCH_MULTI_V7
>  	select ARCH_OMAP2PLUS
> -	select ARCH_HAS_OPP
>  	select ARM_CPU_SUSPEND if PM
>  	select OMAP_INTERCONNECT
>  	select PM_OPP if PM

For OMAP portion:
Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
