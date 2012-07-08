From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 08 Jul 2012 22:24:51 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: armadillo800eva: defconfig Allow use of armhf userspace
Message-Id: <201207090024.51339.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday, July 06, 2012, Simon Horman wrote:
> This allows use a Debian armhf usespace
> as well as the existing ability to use a Debian armel userspace.
> 
> Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

Applied to the armadillo branch of the renesas.git tree.

Thanks,
Rafael


> ---
>  arch/arm/configs/armadillo800eva_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> index 16bbb3f..7d87184 100644
> --- a/arch/arm/configs/armadillo800eva_defconfig
> +++ b/arch/arm/configs/armadillo800eva_defconfig
> @@ -18,7 +18,7 @@ CONFIG_ARCH_SHMOBILE=y
>  CONFIG_ARCH_R8A7740=y
>  CONFIG_MACH_ARMADILLO800EVA=y
>  # CONFIG_SH_TIMER_TMU is not set
> -# CONFIG_ARM_THUMB is not set
> +CONFIG_ARM_THUMB=y
>  CONFIG_CPU_BPREDICT_DISABLE=y
>  # CONFIG_CACHE_L2X0 is not set
>  CONFIG_ARM_ERRATA_430973=y
> @@ -36,6 +36,7 @@ CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96"
>  CONFIG_CMDLINE_FORCE=y
>  CONFIG_KEXEC=y
> +CONFIG_VFP=y
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  # CONFIG_SUSPEND is not set
>  CONFIG_NET=y
> 

