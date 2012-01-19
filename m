From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Jan 2012 00:37:07 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: add ak4642 amixer settings on comment
Message-Id: <87fwfc7cjz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

current ak4642 needs amixer settings for playing which was not
needed on old kernel.
This patch show it on comment area

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index d2150c1..76d8754 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -208,6 +208,16 @@
  */
 
 /*
+ * FSI - AK4642
+ *
+ * it needs amixer settings for playing
+ *
+ * amixer set "Headphone" on
+ * amixer set "HPOUTL Mixer DACH" on
+ * amixer set "HPOUTR Mixer DACH" on
+ */
+
+/*
  * FIXME !!
  *
  * gpio_no_direction
-- 
1.7.5.4

