From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 23 Jul 2008 07:49:06 +0000
Subject: [PATCH] sh: fix uImage Entry Point
Message-Id: <4886E272.6060108@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

fix the problem that cannot boot using uImage when PAGE_SIZE is
8kbyte or 64kbyte.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/boot/Makefile |    2 +-
 arch/sh/mm/Kconfig    |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index 89b4086..8b37869 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -40,7 +40,7 @@ KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
 KERNEL_ENTRY	:= $(shell /bin/bash -c 'printf "0x%08x" \
 		     $$[$(CONFIG_PAGE_OFFSET)  + \
 			$(CONFIG_MEMORY_START) + \
-			$(CONFIG_ZERO_PAGE_OFFSET)+0x1000]')
+			$(CONFIG_ZERO_PAGE_OFFSET) + $(CONFIG_ENTRY_OFFSET)]')

 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A sh -O linux -T kernel \
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 29d8e3c..56d0a7d 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -170,6 +170,14 @@ config PAGE_SIZE_64KB

 endchoice

+config ENTRY_OFFSET
+	hex
+	default "0x00001000" if PAGE_SIZE_4KB
+	default "0x00002000" if PAGE_SIZE_8KB
+	default "0x00004000" if PAGE_SIZE_16KB
+	default "0x00010000" if PAGE_SIZE_64KB
+	default "0x00000000"
+
 choice
 	prompt "HugeTLB page size"
 	depends on HUGETLB_PAGE && (CPU_SH4 || CPU_SH5) && MMU
-- 
1.5.5

