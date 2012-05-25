From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 May 2012 14:24:53 +0000
Subject: [PATCH] sh: fix sh7724 compilation
Message-Id: <Pine.LNX.4.64.1205251620540.13353@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix compile breakage:

arch/sh/kernel/process.c: In function 'arch_dup_task_struct':
arch/sh/kernel/process.c:23: error: implicit declaration of function 'unlazy_fpu'

Presumably, other 32-bit FPU-enabled SuperH SoCs are affected too.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This is for a 4-days old next, discard if already fixed.

diff --git a/arch/sh/kernel/process.c b/arch/sh/kernel/process.c
index 9b7a459..02a6f07 100644
--- a/arch/sh/kernel/process.c
+++ b/arch/sh/kernel/process.c
@@ -5,6 +5,8 @@
 #include <linux/export.h>
 #include <linux/stackprotector.h>
 
+#include <asm/fpu.h>
+
 struct kmem_cache *task_xstate_cachep = NULL;
 unsigned int xstate_size;
 
