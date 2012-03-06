From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 06 Mar 2012 05:07:09 +0000
Subject: [PATCH] sh/next: Fix build fail by asm/system.h in asm/bitops.h
Message-Id: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Other files are not done include definitely by asm/system.h made
include in asm/bitops.h.
This patch remove asm/system.h from asm/bitops.h.

-----
LANG=C make ARCH=sh CROSS_COMPILE=sh4-linux-gnu-
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
make[1]: `include/generated/machtypes.h' is up to date.
  CC      arch/sh/kernel/asm-offsets.s
In file included from include/asm-generic/getorder.h:7,
               from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/page.h:187,
               from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/mmu.h:38,
               from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/system_32.h:5,
               from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/system.h:179,
               from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/bitops.h:10,
               from include/linux/bitops.h:22,
               from include/linux/thread_info.h:52,
               from include/linux/preempt.h:9,
               from include/linux/spinlock.h:50,
               from include/linux/mmzone.h:7,
               from include/linux/gfp.h:4,
               from include/linux/mm.h:8,
               from arch/sh/kernel/asm-offsets.c:13:
include/linux/log2.h: In function '__ilog2_u32':
include/linux/log2.h:34: error: implicit declaration of function 'fls'
include/linux/log2.h: In function '__ilog2_u64':
include/linux/log2.h:42: error: implicit declaration of function 'fls64'
include/linux/log2.h: In function '__roundup_pow_of_two':
include/linux/log2.h:63: error: implicit declaration of function 'fls_long'
-----

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/include/asm/bitops.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 90fa3e4..ea8706d 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -7,7 +7,6 @@
 #error only <linux/bitops.h> can be included directly
 #endif
 
-#include <asm/system.h>
 /* For __swab32 */
 #include <asm/byteorder.h>
 
-- 
1.7.9.1

