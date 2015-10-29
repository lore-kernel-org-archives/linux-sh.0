From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Oct 2015 09:37:20 +0000
Subject: [PATCH] i2c: rcar: call rcar_i2c_init() after pm_runtime_get_sync()
Message-Id: <87oafiyq8y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rcar_i2c_init() initializes I2C device, but it should be called
*after* pm_runtime_get_sync(). Otherwise it outputs very hi speed
clock. This patch solved this issue, 
This patch also removes pointless rcar_i2c_init()
from rcar_i2c_probe()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/i2c/busses/i2c-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 616433d..edbfefc 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -474,6 +474,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 
 	pm_runtime_get_sync(dev);
 
+	rcar_i2c_init(priv);
+
 	ret = rcar_i2c_bus_barrier(priv);
 	if (ret < 0)
 		goto out;
@@ -612,8 +614,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io))
 		return PTR_ERR(priv->io);
 
-	rcar_i2c_init(priv);
-
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
 
-- 
1.9.1

