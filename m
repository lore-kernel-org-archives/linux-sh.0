From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Fri, 14 Sep 2012 09:14:28 +0000
Subject: [PATCH 1/2] ARM: shmobile: kzm9g: enable magnetometer ak8975.
Message-Id: <1347614069-23345-2-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables magnetometer ak8975.
I checked ak8975_probe() returns successfully.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/configs/kzm9g_defconfig     |    2 ++
 arch/arm/mach-shmobile/board-kzm9g.c |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 2388c86..2aaa2ff 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -118,6 +118,8 @@ CONFIG_DMADEVICES=y
 CONFIG_SH_DMAE=y
 CONFIG_ASYNC_TX_DMA=y
 CONFIG_STAGING=y
+CONFIG_SENSORS_AK8975=y
+CONFIG_IIO=y
 # CONFIG_DNOTIFY is not set
 CONFIG_INOTIFY_USER=y
 CONFIG_VFAT_FS=y
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 04c836d..9c045d4 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -562,7 +562,11 @@ static struct i2c_board_info i2c0_devices[] = {
 	},
 	{
 		I2C_BOARD_INFO("r2025sd", 0x32),
-	}
+	},
+	{
+		I2C_BOARD_INFO("ak8975", 0x0c),
+		.irq = intcs_evt2irq(0x3380), /* IRQ28 */
+	},
 };
 
 static struct i2c_board_info i2c1_devices[] = {
-- 
1.7.9.5

