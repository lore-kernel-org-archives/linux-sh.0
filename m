From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Apr 2012 06:53:07 +0000
Subject: [PATCH 2/6] ARM: mach-shmobile: sh73a0.h: add GPIO_NR
Message-Id: <878vhn9bxs.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

GPIO_NR is added in order to clarify end of GPIO array.
We can add extra GPIO from it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index cad5757..ac75857 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -482,6 +482,9 @@ enum {
 	GPIO_FN_FSIAILR_PU,
 	GPIO_FN_FSIAIBT_PU,
 	GPIO_FN_FSIAISLD_PU,
+
+	/* end of GPIO */
+	GPIO_NR,
 };
 
 /* DMA slave IDs */
-- 
1.7.5.4

