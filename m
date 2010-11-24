From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 Nov 2010 05:03:33 +0000
Subject: [PATCH] ARM: mach-shmobile: ag5evm: remove unused define
Message-Id: <w3poc9fz522.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index b35d8f4..cec0de0 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -224,16 +224,6 @@ void __init ag5evm_init_irq(void)
 	gic_cpu_init(0, __io(0xf0000100));
 }
 
-#define PORT144CR 0xe6052090
-#define PORT145CR 0xe6052091
-
-#define PORT154CR 0xe605209a
-#define PORT155CR 0xe605209b
-#define PORT156CR 0xe605209c
-#define PORT157CR 0xe605209d
-
-#define PORTR159_128DR 0xe6056004
-
 static void __init ag5evm_init(void)
 {
 	sh73a0_pinmux_init();
-- 
1.7.0.4

