From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 19 Nov 2019 00:55:17 +0000
Subject: [PATCH] arch/sh/: fix NUMA build errors
Message-Id: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
SYS_SUPPORTS_SMP and SMP.

kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
code + data inside topology.c is only built when CONFIG_NUMA is
set/enabled, so these arch/sh/ configs need to select SMP and
SYS_SUPPORTS_SMP to build the NUMA support.

Fixes this build error in 3 different SUPERH configs:

mm/page_alloc.o: In function `get_page_from_freelist':
page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
or maybe these should be fixed in the defconfig files?

or alternatively, does it make any sense to support NUMA without SMP?

 arch/sh/Kconfig |    4 ++++
 1 file changed, 4 insertions(+)

--- lnx-54-rc8.orig/arch/sh/Kconfig
+++ lnx-54-rc8/arch/sh/Kconfig
@@ -508,6 +508,8 @@ config CPU_SUBTYPE_SH7722
 	select CPU_SHX2
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
+	select SYS_SUPPORTS_SMP
+	select SMP
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SH_CMT
 	select PINCTRL
@@ -518,6 +520,8 @@ config CPU_SUBTYPE_SH7366
 	select CPU_SHX2
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
+	select SYS_SUPPORTS_SMP
+	select SMP
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SH_CMT
 
