From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 09 Sep 2013 15:55:16 +0000
Subject: [PATCH 1/5] i2c: rcar: (cosmetic) remove superfluous parenthesis
Message-Id: <1378742120-11135-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1378742120-11135-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

A recent patch added even more superfluous parenthesis to those, which
already were there. Remove them again.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/i2c/busses/i2c-rcar.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d2fe11d..15eef94 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -306,7 +306,7 @@ scgd_find:
 	/*
 	 * keep icccr value
 	 */
-	priv->icccr = (scgd << (cdf_width) | cdf);
+	priv->icccr = scgd << cdf_width | cdf;
 
 	return 0;
 }
-- 
1.7.2.5

