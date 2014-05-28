From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:46 +0000
Subject: [PATCH 11/11] i2c: rcar: update copyright and license information
Message-Id: <1401263086-13720-12-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Make clear that the driver is GPL v2 only. Remove FSF address. Remove
filename in comment. Update copyright information.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index b4cbbc412ca9..f1ae1a3e187e 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1,7 +1,9 @@
 /*
- *  drivers/i2c/busses/i2c-rcar.c
+ * Driver for the Renesas RCar I2C unit
  *
- * Copyright (C) 2012 Renesas Solutions Corp.
+ * Copyright (C) 2014 Wolfram Sang <wsa@sang-engineering.com>
+ *
+ * Copyright (C) 2012-14 Renesas Solutions Corp.
  * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
  *
  * This file is based on the drivers/i2c/busses/i2c-sh7760.c
@@ -12,16 +14,12 @@
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
+ * the Free Software Foundation; version 2 of the License.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -605,6 +603,6 @@ static struct platform_driver rcar_i2c_driver = {
 
 module_platform_driver(rcar_i2c_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Renesas R-Car I2C bus driver");
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
-- 
2.0.0.rc2

