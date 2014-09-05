From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Sep 2014 23:34:32 +0000
Subject: [PATCH] i2c-rcar: fix RCAR_IRQ_ACK_{RECV|SEND}
Message-Id: <2641177.jdYX8POT82@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Bits 8-31 of all registers reflect the value of bits 0-7 on reads and should be
0 on writes, according to the manuals. RCAR_IRQ_ACK_{RECV|SEND} macros have all
1's in bits 8-31, thus going against the manuals, so fix them.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: stable@vger.kernel.org

---
The patch is against Wolfram Sang's 'linux.git' repo's 'i2c/for-current' branch.

 drivers/i2c/busses/i2c-rcar.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/i2c/busses/i2c-rcar.c
=================================--- linux.orig/drivers/i2c/busses/i2c-rcar.c
+++ linux/drivers/i2c/busses/i2c-rcar.c
@@ -76,8 +76,8 @@
 #define RCAR_IRQ_RECV	(MNR | MAL | MST | MAT | MDR)
 #define RCAR_IRQ_STOP	(MST)
 
-#define RCAR_IRQ_ACK_SEND	(~(MAT | MDE))
-#define RCAR_IRQ_ACK_RECV	(~(MAT | MDR))
+#define RCAR_IRQ_ACK_SEND	(~(MAT | MDE) & 0xFF)
+#define RCAR_IRQ_ACK_RECV	(~(MAT | MDR) & 0xFF)
 
 #define ID_LAST_MSG	(1 << 0)
 #define ID_IOERROR	(1 << 1)

