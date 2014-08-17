From: Simon Horman <horms@verge.net.au>
Date: Sun, 17 Aug 2014 00:38:36 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
Message-Id: <20140817003836.GB7887@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408057405-10568-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1408057405-10568-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Aug 15, 2014 at 08:03:25AM +0900, Simon Horman wrote:
> "ARM: shmobile: defconfig: enable initrd and atag dtb compat" enables
> CONFIG_ARM_ATAG_DTB_COMPAT, however, empirically
> ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is also required for my kzm9d board to
> boot.
> 
> Cc: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have decided to drop the above patch and am withdrawing this
patch accordingly.

> ---
> 
> Without this change I do not see any kernel console output at all.
> ---
>  arch/arm/configs/shmobile_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index f847a9f..e343dc8 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -35,6 +35,7 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
>  CONFIG_ZBOOT_ROM_BSS=0x0
>  CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
> +CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND=y
>  CONFIG_KEXEC=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
> -- 
> 2.0.1
> 
