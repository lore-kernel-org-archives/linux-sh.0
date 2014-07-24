From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 24 Jul 2014 01:57:39 +0000
Subject: [PATCH 2/5] ARM: shmobile: r8a7740: add TMU clock support for DT
Message-Id: <ef9cb75ca70c8d31b2493d1fd6cbf8b3dd1dec95.1406164563.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1406164563.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1406164563.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This will be used when initialising TMU devices using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 68592b7..3f34b3f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -598,7 +598,9 @@ static struct clk_lookup lookups[] = {
 
 	/* ICK */
 	CLKDEV_ICK_ID("fck",	"sh-tmu.1",		&mstp_clks[MSTP111]),
+	CLKDEV_ICK_ID("fck",	"fff90000.timer",	&mstp_clks[MSTP111]),
 	CLKDEV_ICK_ID("fck",	"sh-tmu.0",		&mstp_clks[MSTP125]),
+	CLKDEV_ICK_ID("fck",	"fff80000.timer",	&mstp_clks[MSTP125]),
 	CLKDEV_ICK_ID("fck",	"sh-cmt-48.1",		&mstp_clks[MSTP329]),
 	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
 	CLKDEV_ICK_ID("func",	"renesas_usbhs",	&mstp_clks[MSTP407]),
-- 
2.0.1

