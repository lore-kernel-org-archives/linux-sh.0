From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Dec 2012 04:03:45 +0000
Subject: [PATCH 1/4] ARM: shmobile: fix sample amixer settings for mackerel
Message-Id: <87pq1y7p7l.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch updates FSI-AK4643 amixer setting

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 3f56e70..e10ac06 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -202,9 +202,7 @@
  *
  * it needs amixer settings for playing
  *
- * amixer set "Headphone" on
- * amixer set "HPOUTL Mixer DACH" on
- * amixer set "HPOUTR Mixer DACH" on
+ * amixer set "Headphone Enable" on
  */
 
 /* Fixed 3.3V and 1.8V regulators to be used by multiple devices */
-- 
1.7.9.5

