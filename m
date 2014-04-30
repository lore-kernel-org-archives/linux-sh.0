From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 30 Apr 2014 22:21:06 +0000
Subject: [PATCH 2/6] i2c: sh_mobile: improve error handling
Message-Id: <1398896470-24663-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Use standard i2c error codes for i2c failures. Also, don't print
something on timeout since it happens regularly with i2c. Simplify some,
logic, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index d91625eea6bb..d2fa222df3d1 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -480,7 +480,7 @@ static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
 {
 	if (usr_msg->len = 0 && (usr_msg->flags & I2C_M_RD)) {
 		dev_err(pd->dev, "Unsupported zero length i2c read\n");
-		return -EIO;
+		return -EOPNOTSUPP;
 	}
 
 	if (do_init) {
@@ -515,17 +515,12 @@ static int poll_dte(struct sh_mobile_i2c_data *pd)
 			break;
 
 		if (val & ICSR_TACK)
-			return -EIO;
+			return -ENXIO;
 
 		udelay(10);
 	}
 
-	if (!i) {
-		dev_warn(pd->dev, "Timeout polling for DTE!\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	return i ? 0 : -ETIMEDOUT;
 }
 
 static int poll_busy(struct sh_mobile_i2c_data *pd)
@@ -543,20 +538,18 @@ static int poll_busy(struct sh_mobile_i2c_data *pd)
 		 */
 		if (!(val & ICSR_BUSY)) {
 			/* handle missing acknowledge and arbitration lost */
-			if ((val | pd->sr) & (ICSR_TACK | ICSR_AL))
-				return -EIO;
+			val |= pd->sr;
+			if (val & ICSR_TACK)
+				return -ENXIO;
+			if (val & ICSR_AL)
+				return -EAGAIN;
 			break;
 		}
 
 		udelay(10);
 	}
 
-	if (!i) {
-		dev_err(pd->dev, "Polling timed out\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	return i ? 0 : -ETIMEDOUT;
 }
 
 static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
-- 
1.9.2

