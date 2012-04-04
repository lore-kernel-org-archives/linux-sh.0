From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 04 Apr 2012 02:56:07 +0000
Subject: [PATCH] sh: fix clock-sh7757 for the latest sh_mobile_sdhi driver
Message-Id: <4F7BB847.6010801@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The commit 996bc8aebd2cd5b6d4c5d85085f171fa2447f364 (mmc: sh_mobile_sdhi:
do not manage PM clocks manually) modified the sh_mobile_sdhi driver to
remove the clk_enable/clk_disable. So, we need to change
the "CLKDEV_CON_ID" to "CLKDEV_DEV_ID".

If we don't change this, we will see the following error from the driver:
    sh_mobile_sdhi sh_mobile_sdhi.0: timeout waiting for hardware interrupt (CMD52)

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 5853989..04ab5ae 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -113,7 +113,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),

 	/* MSTP32 clocks */
-	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP004]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP004]),
 	CLKDEV_CON_ID("riic0", &mstp_clks[MSTP000]),
 	CLKDEV_CON_ID("riic1", &mstp_clks[MSTP000]),
 	CLKDEV_CON_ID("riic2", &mstp_clks[MSTP000]),
-- 
1.7.1
