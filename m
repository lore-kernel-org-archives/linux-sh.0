From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 14 May 2015 12:40:02 +0000
Subject: [PATCH 1/4] i2c: add FUNC flag for slave capabilities
Message-Id: <1431607205-2316-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1431607205-2316-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

So users can check in advance if there is slave support.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/uapi/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index 0e949cbfd33338..b0a7dd61eb353a 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -87,6 +87,7 @@ struct i2c_msg {
 #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_IGNORE_NAK etc. */
 #define I2C_FUNC_SMBUS_PEC		0x00000008
 #define I2C_FUNC_NOSTART		0x00000010 /* I2C_M_NOSTART */
+#define I2C_FUNC_SLAVE			0x00000020
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000
-- 
2.1.4

