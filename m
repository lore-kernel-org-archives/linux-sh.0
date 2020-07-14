From: Christoph Hellwig <hch@lst.de>
Date: Tue, 14 Jul 2020 12:18:47 +0000
Subject: [PATCH 01/10] sh: remove -Werror from Makefiles
Message-Id: <20200714121856.955680-2-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
In-Reply-To: <20200714121856.955680-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The sh build is full of warnings when building with gcc 9.2.1.  While
fixing those would be great, at least avoid failing the build.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/kernel/Makefile | 2 --
 arch/sh/lib/Makefile    | 2 --
 arch/sh/mm/Makefile     | 2 --
 3 files changed, 6 deletions(-)

diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index b0f5574b6228b3..aa0fbc9202b14e 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -47,5 +47,3 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
 obj-$(CONFIG_DMA_NONCOHERENT)	+= dma-coherent.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
-
-ccflags-y := -Werror
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index d0abbe5e38b0f3..eb473d373ca43a 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -30,5 +30,3 @@ memset-$(CONFIG_CPU_SH4)	:= memset-sh4.o
 lib-$(CONFIG_MMU)		+= copy_page.o __clear_user.o
 lib-$(CONFIG_MCOUNT)		+= mcount.o
 lib-y				+= $(memcpy-y) $(memset-y) $(udivsi3-y)
-
-ccflags-y := -Werror
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index 487da0ff03b3a7..f69ddc70b14658 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -43,5 +43,3 @@ obj-$(CONFIG_UNCACHED_MAPPING)	+= uncached.o
 obj-$(CONFIG_HAVE_SRAM_POOL)	+= sram.o
 
 GCOV_PROFILE_pmb.o := n
-
-ccflags-y := -Werror
-- 
2.26.2
