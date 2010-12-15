From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Dec 2010 10:59:24 +0000
Subject: [PATCH] ARM: mach-shmobile: fix compile warning in mm/init.c
Message-Id: <20101215105924.23413.34629.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Turn down the warning noise from the compiler,
basically a SH-Mobile specific version of the
patch located in the RMK patch tracker:

6484/1: "fix compile warning in mm/init.c",

Without this patch the following warning triggers:

 CC      arch/arm/kernel/sys_arm.o
arch/arm/mm/init.c: In function 'mem_init':
arch/arm/mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but argument 12 has type 'unsigned int'
  CC      arch/arm/kernel/traps.o

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/vmalloc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/vmalloc.h
+++ work/arch/arm/mach-shmobile/include/mach/vmalloc.h	2010-11-18 16:13:50.000000000 +0900
@@ -2,6 +2,6 @@
 #define __ASM_MACH_VMALLOC_H
 
 /* Vmalloc at ... - 0xe5ffffff */
-#define VMALLOC_END 0xe6000000
+#define VMALLOC_END 0xe6000000UL
 
 #endif /* __ASM_MACH_VMALLOC_H */
