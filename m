From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:07 +0000
Subject: [PATCH v2 01/10] i2c: sh_mobile: replace magic hex values with constants
Message-Id: <1399058116-7721-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

No functional change, binaries are identical.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 1d79585ba4b3..d91625eea6bb 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -316,7 +316,7 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 
 	switch (op) {
 	case OP_START: /* issue start and trigger DTE interrupt */
-		iic_wr(pd, ICCR, 0x94);
+		iic_wr(pd, ICCR, ICCR_ICE | ICCR_TRS | ICCR_BBSY);
 		break;
 	case OP_TX_FIRST: /* disable DTE interrupt and write data */
 		iic_wr(pd, ICIC, ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
@@ -327,10 +327,11 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 		break;
 	case OP_TX_STOP: /* write data and issue a stop afterwards */
 		iic_wr(pd, ICDR, data);
-		iic_wr(pd, ICCR, pd->send_stop ? 0x90 : 0x94);
+		iic_wr(pd, ICCR, pd->send_stop ? ICCR_ICE | ICCR_TRS
+					       : ICCR_ICE | ICCR_TRS | ICCR_BBSY);
 		break;
 	case OP_TX_TO_RX: /* select read mode */
-		iic_wr(pd, ICCR, 0x81);
+		iic_wr(pd, ICCR, ICCR_ICE | ICCR_SCP);
 		break;
 	case OP_RX: /* just read data */
 		ret = iic_rd(pd, ICDR);
@@ -338,13 +339,13 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 	case OP_RX_STOP: /* enable DTE interrupt, issue stop */
 		iic_wr(pd, ICIC,
 		       ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
-		iic_wr(pd, ICCR, 0xc0);
+		iic_wr(pd, ICCR, ICCR_ICE | ICCR_RACK);
 		break;
 	case OP_RX_STOP_DATA: /* enable DTE interrupt, read data, issue stop */
 		iic_wr(pd, ICIC,
 		       ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
 		ret = iic_rd(pd, ICDR);
-		iic_wr(pd, ICCR, 0xc0);
+		iic_wr(pd, ICCR, ICCR_ICE | ICCR_RACK);
 		break;
 	}
 
-- 
1.9.2

