From: Simon Horman <horms@verge.net.au>
Date: Wed, 04 Jun 2014 23:40:30 +0000
Subject: Re: [PATCH v2 8/8] ARM: shmobile: Enable CPUFREQ configuration
Message-Id: <20140604234030.GF27080@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <538DB996.3050101@bp.renesas.com>
In-Reply-To: <538DB996.3050101@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 03, 2014 at 09:03:34PM +0900, Gaku Inami wrote:
> This changes of configuration is multiplatform build only for r8a7790/r8a7791.
> 
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Thanks, I have queued this up with Magnus's ack.

> ---
> 
> Changes since version 1:
> - added CONFIG_REGULATOR_DA9210
> 
>  arch/arm/configs/shmobile_defconfig |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 94d7736..c4b72aa 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -147,3 +147,16 @@ CONFIG_NLS_ISO8859_1=y
>  # CONFIG_ENABLE_WARN_DEPRECATED is not set
>  # CONFIG_ENABLE_MUST_CHECK is not set
>  # CONFIG_ARM_UNWIND is not set
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_GOV_COMMON=y
> +CONFIG_CPU_FREQ_STAT=y
> +CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=y
> +CONFIG_CPU_FREQ_GOV_USERSPACE=y
> +CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
> +CONFIG_CPU_THERMAL=y
> +CONFIG_GENERIC_CPUFREQ_CPU0=y
> +CONFIG_REGULATOR_DA9210=y
> -- 
> 1.7.9.5
> 
