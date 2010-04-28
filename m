From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Apr 2010 08:25:30 +0000
Subject: [PATCH] ARM: mach-shmobile: Set CONSISTENT_DMA_SIZE to 158 MB
Message-Id: <20100428082530.29018.50464.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch sets CONSISTENT_DMA_SIZE to 158 MB
for all SH-Mobile ARM processors.

The DMA area is mapped at 0xf6000000 - 0xffdfffff,
on top of the 256 MB I/O window at 0xe6000000.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/memory.h |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/arch/arm/mach-shmobile/include/mach/memory.h
+++ work/arch/arm/mach-shmobile/include/mach/memory.h	2010-04-28 17:17:08.000000000 +0900
@@ -4,4 +4,7 @@
 #define PHYS_OFFSET	UL(CONFIG_MEMORY_START)
 #define MEM_SIZE	UL(CONFIG_MEMORY_SIZE)
 
+/* DMA memory at 0xf6000000 - 0xffdfffff */
+#define CONSISTENT_DMA_SIZE (158 << 20)
+
 #endif /* __ASM_MACH_MEMORY_H */
