From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 06 Aug 2018 14:07:54 +0000
Subject: [PATCH/RFC 3/4] Revert "serial: sh-sci: Compute the regshift value for SCI ports"
Message-Id: <20180806140755.24087-4-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
In-Reply-To: <20180806140755.24087-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Brandt <chris.brandt@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <uli@fpond.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This reverts commit dfc80387aefb78161f83732804c6d01c89c24595.

Deriving the proper regshift value from the register block size is
fragile, as it may have been rounded up.

Furthermore we will need plat_sci_port.regshift again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/kernel/cpu/sh3/setup-sh770x.c |  1 +
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |  3 ++-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c | 10 ++--------
 drivers/tty/serial/sh-sci.c           |  8 +-------
 include/linux/serial_sci.h            |  1 +
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 59a88611df55ac8f..592cd9ab30c4272f 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -111,6 +111,7 @@ static struct platform_device rtc_device = {
 static struct plat_sci_port scif0_platform_data = {
 	.type		= PORT_SCI,
 	.ops		= &sh770x_sci_port_ops,
+	.regshift	= 1,
 };
 
 static struct resource scif0_resources[] = {
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 57d30689204d03b9..d98a55416306baef 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -39,10 +39,11 @@ static struct platform_device rtc_device = {
 
 static struct plat_sci_port sci_platform_data = {
 	.type		= PORT_SCI,
+	.regshift	= 2,
 };
 
 static struct resource sci_resources[] = {
-	DEFINE_RES_MEM(0xffe00000, 0x20),
+	DEFINE_RES_MEM(0xffe00000, 0x100),
 	DEFINE_RES_IRQ(evt2irq(0x4e0)),
 };
 
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
index e51fe1734e1368e8..0c0cdfc69dcc3e33 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -200,18 +200,12 @@ static struct platform_device scif2_device = {
 };
 
 static struct plat_sci_port scif3_platform_data = {
-	/*
-	 * This is actually a SIM card module serial port, based on an SCI with
-	 * additional registers. The sh-sci driver doesn't support the SIM port
-	 * type, declare it as a SCI. Don't declare the additional registers in
-	 * the memory resource or the driver will compute an incorrect regshift
-	 * value.
-	 */
 	.type		= PORT_SCI,
+	.regshift	= 2,
 };
 
 static struct resource scif3_resources[] = {
-	DEFINE_RES_MEM(0xfe480000, 0x10),
+	DEFINE_RES_MEM(0xfe480000, 0x100),
 	DEFINE_RES_IRQ(evt2irq(0xc00)),
 	DEFINE_RES_IRQ(evt2irq(0xc20)),
 	DEFINE_RES_IRQ(evt2irq(0xc40)),
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index caf4422d9e2e59e4..955c057dff6e8c78 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2895,15 +2895,9 @@ static int sci_init_single(struct platform_device *dev,
 
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
+	port->regshift		= p->regshift;
 	port->fifosize		= sci_port->params->fifosize;
 
-	if (port->type = PORT_SCI) {
-		if (sci_port->reg_size >= 0x20)
-			port->regshift = 2;
-		else
-			port->regshift = 1;
-	}
-
 	if (regtype = SCIx_SH4_SCIF_REGTYPE)
 		if (sci_port->reg_size >= 0x20)
 			port->regshift = 1;
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index c0e795d95477daea..eebb12fc473f49a2 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -57,6 +57,7 @@ struct plat_sci_port {
 	/*
 	 * Platform overrides if necessary, defaults otherwise.
 	 */
+	unsigned char	regshift;
 	unsigned char	regtype;
 
 	struct plat_sci_port_ops	*ops;
-- 
2.17.1

