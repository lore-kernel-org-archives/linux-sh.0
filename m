From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Nov 2013 02:58:49 +0000
Subject: [PATCH] ARM: shmobile: lager: fixup compile error
Message-Id: <87k3g5drmh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch solve this compile error

  CC      arch/arm/mach-shmobile/board-lager-reference.o
${LINUX}/arch/arm/mach-shmobile/board-lager-reference.c:44:15:\
   error: 'shmobile_init_late' undeclared here (not in a function)
make[3]: *** [arch/arm/mach-shmobile/board-lager-reference.o] Error 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

This patch is for renesas-devel-v3.12-20131118 tag.

4314a31924dfa394919dad912440c7f81ec078b0
(ARM: shmobile: Use ->init_late() on Lager)
is the reason for this error, but I don't indicate it in git-log,
since renesas-devel-xxx commit ID sometimes be exchanged

 arch/arm/mach-shmobile/board-lager-reference.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index ac01118..51a3bcc 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <mach/common.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
-- 
1.7.9.5

