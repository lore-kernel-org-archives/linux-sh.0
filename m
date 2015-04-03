From: Russell King <rmk+kernel@arm.linux.org.uk>
Date: Fri, 03 Apr 2015 17:13:13 +0000
Subject: [PATCH 10/14] ARM: orion: use clkdev_create()
Message-Id: <E1Ye59d-0001BZ-Sv@rmk-PC.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20150403171149.GC13898@n2100.arm.linux.org.uk>
In-Reply-To: <20150403171149.GC13898@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>

clkdev_create() is a shorter way to write clkdev_alloc() followed by
clkdev_add().  Use this instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-orion/common.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/plat-orion/common.c b/arch/arm/plat-orion/common.c
index f5b00f41c4f6..2235081a04ee 100644
--- a/arch/arm/plat-orion/common.c
+++ b/arch/arm/plat-orion/common.c
@@ -28,11 +28,7 @@
 void __init orion_clkdev_add(const char *con_id, const char *dev_id,
 			     struct clk *clk)
 {
-	struct clk_lookup *cl;
-
-	cl = clkdev_alloc(clk, con_id, dev_id);
-	if (cl)
-		clkdev_add(cl);
+	clkdev_create(clk, con_id, "%s", dev_id);
 }
 
 /* Create clkdev entries for all orion platforms except kirkwood.
-- 
1.8.3.1

