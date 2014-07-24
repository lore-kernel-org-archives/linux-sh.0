From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 24 Jul 2014 01:57:38 +0000
Subject: [PATCH 1/5] ARM: shmobile: r8a7778: add TMU clock support for DT
Message-Id: <0985f38d1379291c8701572e761c809f0d5f6476.1406164563.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1406164563.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1406164563.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This will be used when initialising TMU devices using DT
until common clock framework support is added.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index a6dd601..9407bac 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -244,7 +244,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("src.7", "rcar_sound", &mstp_clks[MSTP524]),
 	CLKDEV_ICK_ID("src.8", "rcar_sound", &mstp_clks[MSTP523]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[MSTP016]),
+	CLKDEV_ICK_ID("fck", "ffd80000.timer", &mstp_clks[MSTP016]),
 	CLKDEV_ICK_ID("fck", "sh-tmu.1", &mstp_clks[MSTP015]),
+	CLKDEV_ICK_ID("fck", "ffd81000.timer", &mstp_clks[MSTP015]),
 };
 
 void __init r8a7778_clock_init(void)
-- 
2.0.1

