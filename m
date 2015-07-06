From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 06 Jul 2015 21:46:05 +0000
Subject: [PATCH 1/5] clk: shmobile: emev2: deassert reset for IIC0/1
Message-Id: <1436219188-4325-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We have a driver now for IIC, so disable reset for them.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

If possible, I'd like to take this patch via the I2C tree because the driver
will spit WARNs if the dependency to this patch is not met. OK?

 drivers/clk/shmobile/clk-emev2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/shmobile/clk-emev2.c b/drivers/clk/shmobile/clk-emev2.c
index 5b60beb7d0ebce..a91825471c79ac 100644
--- a/drivers/clk/shmobile/clk-emev2.c
+++ b/drivers/clk/shmobile/clk-emev2.c
@@ -28,6 +28,8 @@
 #define USIBU1_RSTCTRL 0x0ac
 #define USIBU2_RSTCTRL 0x0b0
 #define USIBU3_RSTCTRL 0x0b4
+#define IIC0_RSTCTRL 0x0dc
+#define IIC1_RSTCTRL 0x0e0
 #define STI_RSTCTRL 0x124
 #define STI_CLKSEL 0x688
 
@@ -66,6 +68,10 @@ static void __init emev2_smu_init(void)
 	emev2_smu_write(2, USIBU1_RSTCTRL);
 	emev2_smu_write(2, USIBU2_RSTCTRL);
 	emev2_smu_write(2, USIBU3_RSTCTRL);
+
+	/* deassert reset for IIC0->IIC1 */
+	emev2_smu_write(1, IIC0_RSTCTRL);
+	emev2_smu_write(1, IIC1_RSTCTRL);
 }
 
 static void __init emev2_smu_clkdiv_init(struct device_node *np)
-- 
2.1.4

