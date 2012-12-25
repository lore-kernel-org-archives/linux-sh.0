From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Dec 2012 04:03:56 +0000
Subject: [PATCH 2/4] ARM: shmobile: add sample amixer settings for ap4evb
Message-Id: <87obhi7p7a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

FSI2A-AK4643 needs amixer setting to use it.
This patch adds quick setting guide

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 4065785..1a87d58 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -143,6 +143,10 @@
  *
  * SW41	:  ON : SH-Mobile AP4 Audio Mode
  *	: OFF : Bluetooth Audio Mode
+ *
+ * it needs amixer settings for playing
+ *
+ * amixer set "Headphone Enable" on
  */
 
 /*
-- 
1.7.9.5

