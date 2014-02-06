From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 06:21:09 +0000
Subject: [PATCH 12/13] ARM: shmobile: r7s72100: really add i2c clocks
Message-Id: <3440cb28627d7fbaf25c0d60cb9c6cf6d66d61ad.1391666228.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1391666228.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1391666228.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Due to a merge conflict, addition of the clocks was lost. Tested with
RIIC2 on a genmai board. Others untested but hopefully trivial enough to
be added.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
[horms+renesas@verge.net.au: Capitalised "ARM" in subject]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index e6ab0cd..dd8ce87 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -176,6 +176,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
 
 	/* MSTP clocks */
+	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
+	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
+	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
+	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
 	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 
 	/* ICK */
-- 
1.8.5.2

