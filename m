From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 14 Sep 2014 20:14:14 +0000
Subject: [PATCH v2 1/3] i2c-rcar: simplify check for last message
Message-Id: <1757193.42K2JNstnx@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
In-Reply-To: <2245366.q99HVYG3pL@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org

rcar_i2c_master_xfer() needlessly compares the message pointers (using indirect
addressing) in order to detect the last I2C message, while it's enough to only
compare the message indexes.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- refreshed patch.

 drivers/i2c/busses/i2c-rcar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/drivers/i2c/busses/i2c-rcar.c
=================================--- linux.orig/drivers/i2c/busses/i2c-rcar.c
+++ linux/drivers/i2c/busses/i2c-rcar.c
@@ -453,7 +453,7 @@ static int rcar_i2c_master_xfer(struct i
 		priv->msg	= &msgs[i];
 		priv->pos	= 0;
 		priv->flags	= 0;
-		if (priv->msg = &msgs[num - 1])
+		if (i = num - 1)
 			rcar_i2c_flags_set(priv, ID_LAST_MSG);
 
 		ret = rcar_i2c_prepare_msg(priv);

