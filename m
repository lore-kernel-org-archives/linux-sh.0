From: Simon Horman <horms@verge.net.au>
Date: Tue, 25 Mar 2014 21:02:04 +0000
Subject: Re: [PATCH v5 9/9] ARM: koelsch: Add HAVE_ARM_ARCH_TIMER to defconfig
Message-Id: <20140325210204.GD27673@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com>
 <1395766604-30926-10-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1395766604-30926-10-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Please update the subject of this patch to:

ARM: shmobile: koelsch: Add HAVE_ARM_ARCH_TIMER to defconfig

On Tue, Mar 25, 2014 at 04:56:44PM +0000, Phil Edworthy wrote:
> This is fixes a boot problem when the R-Car PCIe driver is enabled.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/arm/configs/koelsch_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> index ec14547..67666b6 100644
> --- a/arch/arm/configs/koelsch_defconfig
> +++ b/arch/arm/configs/koelsch_defconfig
> @@ -15,6 +15,7 @@ CONFIG_MACH_KOELSCH=y
>  CONFIG_CPU_BPREDICT_DISABLE=y
>  CONFIG_PL310_ERRATA_588369=y
>  CONFIG_ARM_ERRATA_754322=y
> +CONFIG_HAVE_ARM_ARCH_TIMER=y
>  CONFIG_PCI=y
>  CONFIG_PCI_MSI=y
>  CONFIG_PCI_RCAR_GEN2_PCIE=y
> -- 
> 1.9.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
