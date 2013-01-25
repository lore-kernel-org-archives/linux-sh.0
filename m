From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 02:17:29 +0000
Subject: [PATCH 3/7] ARM: shmobile: add sample amixer settings for ap4evb
Message-Id: <1359080253-30995-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

FSI2A-AK4643 needs amixer setting to use it.
This patch adds quick setting guide

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 99ef190..70d287c 100644
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
1.7.10.4

