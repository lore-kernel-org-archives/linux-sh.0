From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Nov 2014 10:11:42 +0000
Subject: [PATCH 3/5] i2c: sh_mobile: improve success message
Message-Id: <1415355104-2031-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

No user needs magic hex values, makes this debug output. Add DMA info.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 1e0aa597dd04..903bb22aa5b4 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -293,6 +293,7 @@ static int sh_mobile_i2c_init(struct sh_mobile_i2c_data *pd)
 	else
 		pd->icic &= ~ICIC_ICCHB8;
 
+	dev_dbg(pd->dev, "timing values: L/H=0x%x/0x%x\n", pd->iccl, pd->icch);
 	return 0;
 }
 
@@ -937,9 +938,8 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 		return ret;
 	}
 
-	dev_info(&dev->dev,
-		 "I2C adapter %d with bus speed %lu Hz (L/H=0x%x/0x%x)\n",
-		 adap->nr, pd->bus_speed, pd->iccl, pd->icch);
+	dev_info(&dev->dev, "I2C adapter %d, bus speed %lu Hz, DMA=%c\n",
+		 adap->nr, pd->bus_speed, (pd->dma_rx || pd->dma_tx) ? 'y' : 'n');
 
 	return 0;
 }
-- 
2.1.1

