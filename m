From: Thomas Schwinge <thomas@codesourcery.com>
Date: Fri, 09 Mar 2012 16:38:51 +0000
Subject: [PATCH 5/7] USB: r8a66597-hcd: restore big-endian operation.
Message-Id: <1331311133-26937-5-git-send-email-thomas@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On SH, as of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
endianess-agnostic I/O accessor functions.

This driver is also enabled in ARM's viper_defconfig as well as MIPS'
bcm47xx_defconfig and fuloong2e_defconfig -- I suppose none of these are
operating in big-endian mode, or this issue should already have been noticed
before.

The device is now recognized correctly for both litte-endian and big-endian
sh7785lcr, but I have not tested this any further, as the board is situated in
a remote data center.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mips@linux-mips.org
---
 drivers/usb/host/r8a66597.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/r8a66597.h b/drivers/usb/host/r8a66597.h
index f28782d..c2ea6d1 100644
--- a/drivers/usb/host/r8a66597.h
+++ b/drivers/usb/host/r8a66597.h
@@ -170,7 +170,7 @@ static inline struct urb *r8a66597_get_urb(struct r8a66597 *r8a66597,
 
 static inline u16 r8a66597_read(struct r8a66597 *r8a66597, unsigned long offset)
 {
-	return ioread16(r8a66597->reg + offset);
+	return __raw_readw(r8a66597->reg + offset);
 }
 
 static inline void r8a66597_read_fifo(struct r8a66597 *r8a66597,
@@ -198,7 +198,7 @@ static inline void r8a66597_read_fifo(struct r8a66597 *r8a66597,
 static inline void r8a66597_write(struct r8a66597 *r8a66597, u16 val,
 				  unsigned long offset)
 {
-	iowrite16(val, r8a66597->reg + offset);
+	__raw_writew(val, r8a66597->reg + offset);
 }
 
 static inline void r8a66597_mdfy(struct r8a66597 *r8a66597,
-- 
1.7.4.1

