From: Adrian Bunk <adrian.bunk@movial.fi>
Date: Mon, 03 Mar 2008 18:07:42 +0000
Subject: [2.6 patch] sh/mm/pg-sh7705.c must #include <linux/fs.h>
Message-Id: <20080303180742.GJ26072@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following compile error:

<--  snip  -->

...
  CC      arch/sh/mm/pg-sh7705.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/mm/pg-sh7705.c: In function 'ptep_get_and_clear':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/mm/pg-sh7705.c:130: error: implicit declaration of function 'mapping_writably_mapped'
make[2]: *** [arch/sh/mm/pg-sh7705.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>

---
abeeede2889319116acd5969913c5fe3c78ead05 foobar
diff --git a/arch/sh/mm/pg-sh7705.c b/arch/sh/mm/pg-sh7705.c
index a4b015f..7f885b7 100644
--- a/arch/sh/mm/pg-sh7705.c
+++ b/arch/sh/mm/pg-sh7705.c
@@ -14,6 +14,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/threads.h>
+#include <linux/fs.h>
 #include <asm/addrspace.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>

