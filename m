From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Apr 2010 08:36:57 +0000
Subject: [PATCH] ARM: mach-shmobile: Update VMALLOC_END
Message-Id: <20100428083657.11917.20411.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend VMALLOC_END to the I/O Window at 0xe6000000.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/vmalloc.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/vmalloc.h
+++ work/arch/arm/mach-shmobile/include/mach/vmalloc.h	2010-04-28 17:32:37.000000000 +0900
@@ -1,6 +1,7 @@
 #ifndef __ASM_MACH_VMALLOC_H
 #define __ASM_MACH_VMALLOC_H
 
-#define VMALLOC_END       (PAGE_OFFSET + 0x24000000)
+/* Vmalloc at ... - 0xe5ffffff */
+#define VMALLOC_END 0xe6000000
 
 #endif /* __ASM_MACH_VMALLOC_H */
