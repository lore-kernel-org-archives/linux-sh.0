From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 29 Oct 2015 19:19:16 +0000
Subject: [PATCH] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 616433d387cdb2..ef26e933b1e9cb 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -612,7 +612,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io))
 		return PTR_ERR(priv->io);
 
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 	rcar_i2c_init(priv);
+	pm_runtime_put(dev);
 
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
@@ -634,7 +637,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_enable(dev);
 	platform_set_drvdata(pdev, priv);
 
 	ret = i2c_add_numbered_adapter(adap);
-- 
2.1.4

