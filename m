From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 11 Jul 2015 07:46:22 +0000
Subject: [PATCH v2 1/5] clk: shmobile: emev2: deassert reset for IIC0/1
Message-Id: <1436600786-3068-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1436600786-3068-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436600786-3068-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We have a driver now for IIC, so disable reset for them.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---

Change since v1:
* added ack from Stephen, thanks

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

