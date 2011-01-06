From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Jan 2011 02:43:00 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: fixup clk_put timing of fsib_clk
Message-Id: <w3pipy2ycp7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

fsib_clk will be used when fdiv_clk failed on fsi_hdmi_set_rate.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 5b07952..79cdf16 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -674,9 +674,8 @@ static int fsi_hdmi_set_rate(struct device *dev, int rate, int enable)
 		return -EIO;
 
 	ret = __fsi_set_round_rate(fsib_clk, fsib_rate, enable);
-	clk_put(fsib_clk);
 	if (ret < 0)
-		return ret;
+		goto fsi_set_rate_end;
 
 	/* FSI DIV setting */
 	ret = __fsi_set_round_rate(fdiv_clk, fdiv_rate, enable);
@@ -684,10 +683,14 @@ static int fsi_hdmi_set_rate(struct device *dev, int rate, int enable)
 		/* disable FSI B */
 		if (enable)
 			__fsi_set_round_rate(fsib_clk, fsib_rate, 0);
-		return ret;
+		goto fsi_set_rate_end;
 	}
 
-	return ackmd_bpfmd;
+	ret = ackmd_bpfmd;
+
+fsi_set_rate_end:
+	clk_put(fsib_clk);
+	return ret;
 }
 
 static int fsi_set_rate(struct device *dev, int is_porta, int rate, int enable)
-- 
1.7.1

