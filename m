From: Simon Horman <horms@verge.net.au>
Date: Fri, 07 Jan 2011 22:26:15 +0000
Subject: [PATCH] [rfc] ARM: mach-shmobile: mackerel: clarify shdi/mmcif switch settings
Message-Id: <1294439175-18808-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1291849274-8115-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1291849274-8115-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

* Pins 2 and 4 of switch 33 are documented as don't care on the PCB,
  my testing seems to confirm this.

* I have been unable to do anything sensible with S1 set to on.
  Am I missing something with regards to MMC1?

* Clarify which driver is needed for each switch setting.

* Should the AP4 board code be updated to allow the
  SHDI driver to access SHDI1 as the mackerel code does?

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 42f7c0d..b190248 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -167,9 +167,8 @@
  *	SW1	|	SW33
  *		| bit1 | bit2 | bit3 | bit4
  * -------------+------+------+------+-------
- * MMC0	  OFF	|  OFF |  ON  |  ON  |  X
- * MMC1	  ON	|  OFF |  ON  |  X   | ON
- * SDHI1  OFF	|  ON  |   X  |  OFF | ON
+ * MMC0   OFF	|  OFF |   X  |  ON  |  X       (Use MMCIF)
+ * SDHI1  OFF	|  ON  |   X  |  OFF |  X       (Use MFD_SH_MOBILE_SDHI)
  *
  */
 
-- 
1.7.2.3

