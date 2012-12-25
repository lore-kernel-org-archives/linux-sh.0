From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Dec 2012 04:04:05 +0000
Subject: [PATCH 3/4] ARM: shmobile: add sample amixer settings for armadillo800eva
Message-Id: <87mwx27p72.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

wm8978 codec requires amixer settings for capture.
This patch adds sample amixer settings on comment area.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
1.7.9.5

