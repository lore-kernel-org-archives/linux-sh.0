From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 08 Aug 2015 20:33:19 +0000
Subject: [PATCH 02/10] i2c: add a flag to mark clients as slaves
Message-Id: <1439066007-13951-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1439066007-13951-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Andrey Danin <danindrey@mail.ru>, Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

And update indentation with one more tab, sigh...

Tested-by: Andrey Danin <danindrey@mail.ru>
Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/i2c.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index e83a738a3b8741..51ed2e40932f3d 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -550,11 +550,12 @@ void i2c_lock_adapter(struct i2c_adapter *);
 void i2c_unlock_adapter(struct i2c_adapter *);
 
 /*flags for the client struct: */
-#define I2C_CLIENT_PEC	0x04		/* Use Packet Error Checking */
-#define I2C_CLIENT_TEN	0x10		/* we have a ten bit chip address */
+#define I2C_CLIENT_PEC		0x04	/* Use Packet Error Checking */
+#define I2C_CLIENT_TEN		0x10	/* we have a ten bit chip address */
 					/* Must equal I2C_M_TEN below */
-#define I2C_CLIENT_WAKE	0x80		/* for board_info; true iff can wake */
-#define I2C_CLIENT_SCCB	0x9000		/* Use Omnivision SCCB protocol */
+#define I2C_CLIENT_SLAVE	0x20	/* we are the slave */
+#define I2C_CLIENT_WAKE		0x80	/* for board_info; true iff can wake */
+#define I2C_CLIENT_SCCB		0x9000	/* Use Omnivision SCCB protocol */
 					/* Must match I2C_M_STOP|IGNORE_NAK */
 
 /* i2c adapter classes (bitmask) */
-- 
2.1.4

