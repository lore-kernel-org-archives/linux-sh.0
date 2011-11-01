From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 01 Nov 2011 05:54:38 +0000
Subject: [PATCH] sh: modify the asm/sh_eth.h to linux/sh_eth.h in sh7757lcr
Message-Id: <1320126878-7886-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4E82D17A.7050108@renesas.com>
In-Reply-To: <4E82D17A.7050108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/boards/board-sh7757lcr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index fa2a208..ec8c84c 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -18,8 +18,8 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/sh_eth.h>
 #include <cpu/sh7757.h>
-#include <asm/sh_eth.h>
 #include <asm/heartbeat.h>
 
 static struct resource heartbeat_resource = {
-- 
1.7.7

