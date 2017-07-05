From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Wed, 05 Jul 2017 10:13:58 +0000
Subject: [PATCH v2 4/4] i2c: pca-platform: drop gpio from platform data
Message-Id: <20170705101358.17458-5-chris.packham@alliedtelesis.co.nz>
List-Id: <linux-sh.vger.kernel.org>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, ysato@users.sourceforge.jp, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, Steven Miao <realmz6@gmail.com>, Rich Felker <dalias@libc.org>, adi-buildroot-devel@lists.sourceforge.net

Now that the i2c-pca-plaform driver is using the device managed API for
gpios there is no need for the reset gpio to be specified via
i2c_pca9564_pf_platform_data.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/blackfin/mach-bf561/boards/acvilon.c | 1 -
 arch/sh/boards/board-sh7785lcr.c          | 1 -
 include/linux/i2c-pca-platform.h          | 3 ---
 3 files changed, 5 deletions(-)

diff --git a/arch/blackfin/mach-bf561/boards/acvilon.c b/arch/blackfin/mach-bf561/boards/acvilon.c
index 37f8f25a1347..192404318a36 100644
--- a/arch/blackfin/mach-bf561/boards/acvilon.c
+++ b/arch/blackfin/mach-bf561/boards/acvilon.c
@@ -112,7 +112,6 @@ static struct resource bfin_i2c_pca_resources[] = {
 };
 
 struct i2c_pca9564_pf_platform_data pca9564_platform_data = {
-	.gpio = -1,
 	.i2c_clock_speed = 330000,
 	.timeout = HZ,
 };
diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index caec1ebffb09..d7d232dea33e 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -253,7 +253,6 @@ static struct gpiod_lookup_table i2c_gpio_table = {
 };
 
 static struct i2c_pca9564_pf_platform_data i2c_platform_data = {
-	.gpio			= 0,
 	.i2c_clock_speed	= I2C_PCA_CON_330kHz,
 	.timeout		= HZ,
 };
diff --git a/include/linux/i2c-pca-platform.h b/include/linux/i2c-pca-platform.h
index aba33759dec4..6331eaef9352 100644
--- a/include/linux/i2c-pca-platform.h
+++ b/include/linux/i2c-pca-platform.h
@@ -2,9 +2,6 @@
 #define I2C_PCA9564_PLATFORM_H
 
 struct i2c_pca9564_pf_platform_data {
-	int gpio;		/* pin to reset chip. driver will work when
-				 * not supplied (negative value), but it
-				 * cannot exit some error conditions then */
 	int i2c_clock_speed;	/* values are defined in linux/i2c-algo-pca.h */
 	int timeout;		/* timeout in jiffies */
 };
-- 
2.13.0

