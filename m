From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 12 Sep 2013 12:36:47 +0000
Subject: [PATCH v2 4/5] i2c: rcar: fix clk_get() error handling
Message-Id: <1378989408-10618-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1378989408-10618-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1378989408-10618-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

When clk_get() fails, it returns an error code, not a NULL. This patch
fixes such an error handling bug.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/i2c/busses/i2c-rcar.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 1f285a3..98276eb 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -234,9 +234,9 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv *priv,
 	u32 cdf_width;
 	unsigned long rate;
 
-	if (!clkp) {
-		dev_err(dev, "there is no peripheral_clk\n");
-		return -EIO;
+	if (IS_ERR(clkp)) {
+		dev_err(dev, "couldn't get clock\n");
+		return PTR_ERR(clkp);
 	}
 
 	switch (priv->devtype) {
-- 
1.7.2.5

