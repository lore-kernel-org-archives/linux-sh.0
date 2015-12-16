From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 16 Dec 2015 11:02:36 +0000
Subject: [PATCH] i2c: rcar: disable runtime PM correctly in slave mode
Message-Id: <1450263756-12013-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

When we also are I2C slave, we need to disable runtime PM because the
address detection mechanism needs to be active all the time. However, we
can reenable runtime PM once the slave instance was unregistered. So,
use pm_runtime_disable/enable to achieve this, since it has proper
refcounting. pm_runtime_allow/forbid is like a global switch which is
unsuitable here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I'd be grateful to get an ACK from a runtime PM expert to verify that my
assumptions match reality :)

 drivers/i2c/busses/i2c-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index b2389c492579cf..dc3343291e7497 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -533,7 +533,7 @@ static int rcar_reg_slave(struct i2c_client *slave)
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
 
-	pm_runtime_forbid(rcar_i2c_priv_to_dev(priv));
+	pm_runtime_disable(rcar_i2c_priv_to_dev(priv));
 
 	priv->slave = slave;
 	rcar_i2c_write(priv, ICSAR, slave->addr);
@@ -555,7 +555,7 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	priv->slave = NULL;
 
-	pm_runtime_allow(rcar_i2c_priv_to_dev(priv));
+	pm_runtime_enable(rcar_i2c_priv_to_dev(priv));
 
 	return 0;
 }
-- 
2.1.4

