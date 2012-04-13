From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Apr 2012 09:56:45 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: armadillo800eva: tidyup dipswitch explain for SDHI
Message-Id: <87obqw2bvq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index c2affc4..b80b8ea 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -87,7 +87,7 @@
  *     0     | Extension Bus | D8-D15 disable, eMMC enable
  *     1     | Extension Bus | D8-D15 enable,  eMMC disable
  * -12345678-+---------------+----------------------------
- *      0    | SDHI1         | COM8 enable,  COM14 disable
+ *      0    | SDHI1         | COM8 disable, COM14 enable
  *      1    | SDHI1         | COM8 enable,  COM14 disable
  * -12345678-+---------------+----------------------------
  *        00 | JTAG          | SH-X2
-- 
1.7.5.4

