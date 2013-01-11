From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Jan 2013 04:17:35 +0000
Subject: [PATCH] sh: define TASK_UNMAPPED_BASE as a page aligned constant
Message-Id: <87sj684alg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

b4265f12340f809447b9a48055e88c444b480c89
(mm: use vm_unmapped_area() on sh architecture)
broke sh boot. This patch define TASK_UNMAPPED_BASE
as a page aligned constant to solve this issue.
Special thanks to Michel

Cc: Michel Lespinasse <walken@google.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---

>> Michel

Thanks !!
my board start works with this patch.
Please check it.

 arch/sh/include/asm/processor_32.h |    2 +-
 arch/sh/include/asm/processor_64.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index b6311fd..379a407 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -39,7 +39,7 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
 
 /*
  * Bit of SR register
diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
index cd6029f..670891d 100644
--- a/arch/sh/include/asm/processor_64.h
+++ b/arch/sh/include/asm/processor_64.h
@@ -47,7 +47,7 @@ pc; })
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+#define TASK_UNMAPPED_BASE	PAGE_ALIGN(TASK_SIZE / 3)
 
 /*
  * Bit of SR register
-- 
1.7.9.5

