From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Apr 2011 18:18:57 +0000
Subject: [PATCH] i2c: add a module alias to the sh-mobile driver
Message-Id: <Pine.LNX.4.64.1104152017400.18593@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>

This patch enables I2C driver autoloading on sh-mobile systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 drivers/i2c/busses/i2c-sh_mobile.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 2707f5e..81ccd78 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -729,3 +729,4 @@ module_exit(sh_mobile_i2c_adap_exit);
 MODULE_DESCRIPTION("SuperH Mobile I2C Bus Controller driver");
 MODULE_AUTHOR("Magnus Damm");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:i2c-sh_mobile");
-- 
1.7.2.5

