From: Boris Brezillon <boris.brezillon@bootlin.com>
Date: Thu, 06 Sep 2018 22:38:47 +0000
Subject: [PATCH 15/19] mtd: rawnand: Inline onfi_get_async_timing_mode()
Message-Id: <20180906223851.6964-16-boris.brezillon@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Boris Brezillon <boris.brezillon@bootlin.com>, Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org

onfi_get_async_timing_mode() is only used in one place inside
nand_base.c. Let's inline the code and kill the helper.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/nand_base.c | 5 +++--
 include/linux/mtd/rawnand.h      | 9 ---------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 2f8bbc3bca7a..136ccdc61a06 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1310,8 +1310,9 @@ static int nand_init_data_interface(struct nand_chip *chip)
 	 * if the NAND does not support ONFI, fallback to the default ONFI
 	 * timing mode.
 	 */
-	modes = onfi_get_async_timing_mode(chip);
-	if (modes = ONFI_TIMING_MODE_UNKNOWN) {
+	if (chip->parameters.onfi) {
+		modes = chip->parameters.onfi->async_timing_mode;
+	} else {
 		if (!chip->onfi_timing_mode_default)
 			return 0;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 04e11a314e9c..7f0e3dc222ed 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1540,15 +1540,6 @@ int nand_isbad_bbt(struct nand_chip *chip, loff_t offs, int allowbbt);
 int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
 		    int allowbbt);
 
-/* return the supported asynchronous timing mode. */
-static inline int onfi_get_async_timing_mode(struct nand_chip *chip)
-{
-	if (!chip->parameters.onfi)
-		return ONFI_TIMING_MODE_UNKNOWN;
-
-	return chip->parameters.onfi->async_timing_mode;
-}
-
 int onfi_fill_data_interface(struct nand_chip *chip,
 			     enum nand_data_interface_type type,
 			     int timing_mode);
-- 
2.14.1
