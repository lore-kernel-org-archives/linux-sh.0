From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 13:35:49 +0000
Subject: [PATCH 07/12] dma-mapping: move CONFIG_DMA_CMA to kernel/dma/Kconfig
Message-Id: <20190211133554.30055-8-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

This is where all the related code already lives.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/Kconfig | 77 --------------------------------------------
 kernel/dma/Kconfig   | 77 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 3e63a900b330..059700ea3521 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -191,83 +191,6 @@ config DMA_FENCE_TRACE
 	  lockup related problems for dma-buffers shared across multiple
 	  devices.
 
-config DMA_CMA
-	bool "DMA Contiguous Memory Allocator"
-	depends on HAVE_DMA_CONTIGUOUS && CMA
-	help
-	  This enables the Contiguous Memory Allocator which allows drivers
-	  to allocate big physically-contiguous blocks of memory for use with
-	  hardware components that do not support I/O map nor scatter-gather.
-
-	  You can disable CMA by specifying "cma=0" on the kernel's command
-	  line.
-
-	  For more information see <include/linux/dma-contiguous.h>.
-	  If unsure, say "n".
-
-if  DMA_CMA
-comment "Default contiguous memory area size:"
-
-config CMA_SIZE_MBYTES
-	int "Size in Mega Bytes"
-	depends on !CMA_SIZE_SEL_PERCENTAGE
-	default 0 if X86
-	default 16
-	help
-	  Defines the size (in MiB) of the default memory area for Contiguous
-	  Memory Allocator.  If the size of 0 is selected, CMA is disabled by
-	  default, but it can be enabled by passing cma=size[MG] to the kernel.
-
-
-config CMA_SIZE_PERCENTAGE
-	int "Percentage of total memory"
-	depends on !CMA_SIZE_SEL_MBYTES
-	default 0 if X86
-	default 10
-	help
-	  Defines the size of the default memory area for Contiguous Memory
-	  Allocator as a percentage of the total memory in the system.
-	  If 0 percent is selected, CMA is disabled by default, but it can be
-	  enabled by passing cma=size[MG] to the kernel.
-
-choice
-	prompt "Selected region size"
-	default CMA_SIZE_SEL_MBYTES
-
-config CMA_SIZE_SEL_MBYTES
-	bool "Use mega bytes value only"
-
-config CMA_SIZE_SEL_PERCENTAGE
-	bool "Use percentage value only"
-
-config CMA_SIZE_SEL_MIN
-	bool "Use lower value (minimum)"
-
-config CMA_SIZE_SEL_MAX
-	bool "Use higher value (maximum)"
-
-endchoice
-
-config CMA_ALIGNMENT
-	int "Maximum PAGE_SIZE order of alignment for contiguous buffers"
-	range 4 12
-	default 8
-	help
-	  DMA mapping framework by default aligns all buffers to the smallest
-	  PAGE_SIZE order which is greater than or equal to the requested buffer
-	  size. This works well for buffers up to a few hundreds kilobytes, but
-	  for larger buffers it just a memory waste. With this parameter you can
-	  specify the maximum PAGE_SIZE order for contiguous buffers. Larger
-	  buffers will be aligned only to this specified order. The order is
-	  expressed as a power of two multiplied by the PAGE_SIZE.
-
-	  For example, if your system defaults to 4KiB pages, the order value
-	  of 8 means that the buffers will be aligned up to 1MiB only.
-
-	  If unsure, leave the default value "8".
-
-endif
-
 config GENERIC_ARCH_TOPOLOGY
 	bool
 	help
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index b122ab100d66..d785286ad868 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -53,3 +53,80 @@ config DMA_REMAP
 config DMA_DIRECT_REMAP
 	bool
 	select DMA_REMAP
+
+config DMA_CMA
+	bool "DMA Contiguous Memory Allocator"
+	depends on HAVE_DMA_CONTIGUOUS && CMA
+	help
+	  This enables the Contiguous Memory Allocator which allows drivers
+	  to allocate big physically-contiguous blocks of memory for use with
+	  hardware components that do not support I/O map nor scatter-gather.
+
+	  You can disable CMA by specifying "cma=0" on the kernel's command
+	  line.
+
+	  For more information see <include/linux/dma-contiguous.h>.
+	  If unsure, say "n".
+
+if  DMA_CMA
+comment "Default contiguous memory area size:"
+
+config CMA_SIZE_MBYTES
+	int "Size in Mega Bytes"
+	depends on !CMA_SIZE_SEL_PERCENTAGE
+	default 0 if X86
+	default 16
+	help
+	  Defines the size (in MiB) of the default memory area for Contiguous
+	  Memory Allocator.  If the size of 0 is selected, CMA is disabled by
+	  default, but it can be enabled by passing cma=size[MG] to the kernel.
+
+
+config CMA_SIZE_PERCENTAGE
+	int "Percentage of total memory"
+	depends on !CMA_SIZE_SEL_MBYTES
+	default 0 if X86
+	default 10
+	help
+	  Defines the size of the default memory area for Contiguous Memory
+	  Allocator as a percentage of the total memory in the system.
+	  If 0 percent is selected, CMA is disabled by default, but it can be
+	  enabled by passing cma=size[MG] to the kernel.
+
+choice
+	prompt "Selected region size"
+	default CMA_SIZE_SEL_MBYTES
+
+config CMA_SIZE_SEL_MBYTES
+	bool "Use mega bytes value only"
+
+config CMA_SIZE_SEL_PERCENTAGE
+	bool "Use percentage value only"
+
+config CMA_SIZE_SEL_MIN
+	bool "Use lower value (minimum)"
+
+config CMA_SIZE_SEL_MAX
+	bool "Use higher value (maximum)"
+
+endchoice
+
+config CMA_ALIGNMENT
+	int "Maximum PAGE_SIZE order of alignment for contiguous buffers"
+	range 4 12
+	default 8
+	help
+	  DMA mapping framework by default aligns all buffers to the smallest
+	  PAGE_SIZE order which is greater than or equal to the requested buffer
+	  size. This works well for buffers up to a few hundreds kilobytes, but
+	  for larger buffers it just a memory waste. With this parameter you can
+	  specify the maximum PAGE_SIZE order for contiguous buffers. Larger
+	  buffers will be aligned only to this specified order. The order is
+	  expressed as a power of two multiplied by the PAGE_SIZE.
+
+	  For example, if your system defaults to 4KiB pages, the order value
+	  of 8 means that the buffers will be aligned up to 1MiB only.
+
+	  If unsure, leave the default value "8".
+
+endif
-- 
2.20.1
