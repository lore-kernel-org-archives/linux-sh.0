From: Simon Horman <horms@verge.net.au>
Date: Fri, 22 Feb 2013 23:04:54 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: armadillo800eva: enable branch prediction on defconfig
Message-Id: <20130222230442.GF4737@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1351731731-8435-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1351731731-8435-3-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 21, 2013 at 08:46:19PM -0800, Kuninori Morimoto wrote:
> Because defconfig disabled ARM branch prediction
> by CONFIG_CPU_BPREDICT_DISABLE,
> Armadillo800eva's Bogomips and Loop were not good performance.
> This patch enabled Arm branch prediction.
> Special thanks to Ishiyama-san
> 
> Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks,

should this change also be made to ag5evm_defconfig and kota2_defconfig?

Or alternatively, should we remove those boards from upstream?
* Since the following commit added for 3.8-rc1 kota2 does not appear to boot:
  - b8b499c86be58cb309964fcab5b62ac4a240a878
    "ARM: 7602/1: Pass real "__machine_arch_type" variable to
    setup_machine_tags() procedure"
* I have no way to test ag5evm nor am I aware of anyone who is testing
  that board

> ---
>  arch/arm/configs/armadillo800eva_defconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> index 891318e..dd1592b 100644
> --- a/arch/arm/configs/armadillo800eva_defconfig
> +++ b/arch/arm/configs/armadillo800eva_defconfig
> @@ -20,7 +20,6 @@ CONFIG_ARCH_R8A7740=y
>  CONFIG_MACH_ARMADILLO800EVA=y
>  # CONFIG_SH_TIMER_TMU is not set
>  CONFIG_ARM_THUMB=y
> -CONFIG_CPU_BPREDICT_DISABLE=y
>  CONFIG_CACHE_L2X0=y
>  CONFIG_ARM_ERRATA_430973=y
>  CONFIG_ARM_ERRATA_458693=y
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
