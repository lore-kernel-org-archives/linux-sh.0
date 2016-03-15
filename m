From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Mar 2016 04:22:13 +0000
Subject: [PATCH v2 04/04] iommu/ipmmu-vmsa: Drop LPAE Kconfig dependency
Message-Id: <20160315042213.22103.15860.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20160315042136.22103.26570.sendpatchset@little-apple>
In-Reply-To: <20160315042136.22103.26570.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org

From: Magnus Damm <damm+renesas@opensource.se>

Neither the ARM page table code enabled by IOMMU_IO_PGTABLE_LPAE
nor the IPMMU_VMSA driver actually depends on ARM_LPAE, so get
rid of the dependency.

Tested with ipmmu-vmsa on r8a7794 ALT and a kernel config using:
 # CONFIG_ARM_LPAE is not set

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

 Changes since V1:
 - Rebased on top of ARCH_RENESAS change
 - Added Acked-by from Laurent

 This time the result also compiles on x86. Need to be
 applied as last patch in the following series:
 [PATCH v2 00/04] iommu/ipmmu-vmsa: IPMMU multi-arch update V2
 
 drivers/iommu/Kconfig |    1 -
 1 file changed, 1 deletion(-)

--- 0001/drivers/iommu/Kconfig
+++ work/drivers/iommu/Kconfig	2016-03-15 12:28:45.210513000 +0900
@@ -284,7 +284,6 @@ config EXYNOS_IOMMU_DEBUG
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
-	depends on ARM_LPAE
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
