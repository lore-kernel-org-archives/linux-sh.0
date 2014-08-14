From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Aug 2014 05:25:57 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable initrd and atag dtb compat
Message-Id: <20140814052557.GA27045@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 05:07:15PM -0700, Kevin Hilman wrote:
> Enable ATAG_DTB_COMPAT support for passing commandline from bootloader.
> Enable initrd support.
> 
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
> With this, I can finally integrate the kzm9d into the board farm because I use
> initrafms for the primary rootfs, and set the command-line from u-boot.
> 
> Tested on next-20140813

Thanks, I will queue this up for v3.18 and push it to next
once v3.17-rc1 has been released.

> 
>  arch/arm/configs/shmobile_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index 3b136144cc83..d655f088ac58 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -3,6 +3,7 @@ CONFIG_NO_HZ=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT
> +CONFIG_BLK_DEV_INITRD=y
>  CONFIG_CC_OPTIMIZE_FOR_SIZE=y
>  CONFIG_SYSCTL_SYSCALL=y
>  CONFIG_EMBEDDED=y
> @@ -33,6 +34,7 @@ CONFIG_HIGHMEM=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
> +CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_KEXEC=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
> -- 
> 1.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
