From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 12 Nov 2015 14:31:48 +0000
Subject: [PATCH v2 03/10] i2c: rcar: remove unused IOERROR state
Message-Id: <1447338715-9955-4-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index efc8de6cc8a2f9..746406923a5825 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -94,7 +94,6 @@
 #define RCAR_IRQ_ACK_RECV	(~(MAT | MDR) & 0xFF)
 
 #define ID_LAST_MSG	(1 << 0)
-#define ID_IOERROR	(1 << 1)
 #define ID_DONE		(1 << 2)
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
@@ -541,11 +540,6 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 			break;
 		}
 
-		if (rcar_i2c_flags_has(priv, ID_IOERROR)) {
-			ret = -EIO;
-			break;
-		}
-
 		ret = i + 1; /* The number of transfer */
 	}
 out:
-- 
2.1.4

