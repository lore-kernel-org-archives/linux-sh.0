From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 14 Sep 2009 11:23:16 +0000
Subject: [PATCH] sh: asm/clock.h is needed for EcoVec24
Message-Id: <uy6ohepnf.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

this patch modify compile error

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 40decfe..7da274a 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -24,6 +24,7 @@
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <asm/sh_keysc.h>
+#include <asm/clock.h>
 #include <cpu/sh7724.h>
 
 /*
-- 
1.6.0.4

