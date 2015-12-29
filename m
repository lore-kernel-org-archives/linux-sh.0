From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 29 Dec 2015 00:26:32 +0000
Subject: Re: [PATCH 06/06] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
Message-Id: <2937538.nzTTWYnTym@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215120212.26216.61530.sendpatchset@little-apple>
	<20151215120308.26216.38754.sendpatchset@little-apple>
In-Reply-To: <20151215120308.26216.38754.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org

Hi Magnus,

Thank you for the patch.

On Tuesday 15 December 2015 21:03:08 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Neither the ARM page table code enabled by IOMMU_IO_PGTABLE_LPAE
> nor the IPMMU_VMSA driver actually depends on ARM_LPAE, so get
> rid of the dependency.
> 
> Tested with ipmmu-vmsa on r8a7794 ALT and a kernel config using:
>  # CONFIG_ARM_LPAE is not set
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  This time the result also compiles on x86. Need to be
>  applied as last patch in the following series:
>  [PATCH 00/06] iommu/ipmmu-vmsa: IPMMU multi-arch update
> 
>  drivers/iommu/Kconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> --- 0001/drivers/iommu/Kconfig
> +++ work/drivers/iommu/Kconfig	2015-10-18 14:58:09.080513000 +0900
> @@ -324,7 +324,6 @@ config SHMOBILE_IOMMU_L1SIZE
> 
>  config IPMMU_VMSA
>  	bool "Renesas VMSA-compatible IPMMU"
> -	depends on ARM_LPAE
>  	depends on ARCH_SHMOBILE || COMPILE_TEST
>  	select IOMMU_API
>  	select IOMMU_IO_PGTABLE_LPAE

-- 
Regards,

Laurent Pinchart

