From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 30 Mar 2011 01:46:15 +0000
Subject: [PATCH] sh: fix build error in board-sh7757lcr.c
Message-Id: <4D928B67.1010702@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the problem that the sh_mobile_sdhi.h changed the directory from
"linux/mfd/" to "linux/mmc/".

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index a9e3356..fa2a208 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
-#include <linux/mfd/sh_mobile_sdhi.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <cpu/sh7757.h>
 #include <asm/sh_eth.h>
 #include <asm/heartbeat.h>
-- 
1.7.1
