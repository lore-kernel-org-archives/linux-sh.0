From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 02:17:30 +0000
Subject: [PATCH 4/7] ARM: shmobile: add sample amixer settings for armadillo800eva
Message-Id: <1359080253-30995-5-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

wm8978 codec requires amixer settings for capture.
This patch adds sample amixer settings on comment area.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5353adf..5f179e1 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -124,6 +124,14 @@
  * this command is required when playback.
  *
  * # amixer set "Headphone" 50
+ *
+ * this command is required when capture.
+ *
+ * # amixer set "Input PGA" 15
+ * # amixer set "Left Input Mixer MicP" on
+ * # amixer set "Left Input Mixer MicN" on
+ * # amixer set "Right Input Mixer MicN" on
+ * # amixer set "Right Input Mixer MicP" on
  */
 
 /*
-- 
1.7.10.4

