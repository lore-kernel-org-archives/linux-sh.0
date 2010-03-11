From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 11 Mar 2010 07:34:37 +0000
Subject: [PATCH 3/3] ARM: mach-shmobile: ap4evb: Add R2025S RTC support
Message-Id: <umxyfgmvd.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 33ed915..b134902 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -246,6 +246,9 @@ struct tsc2007_platform_data tsc2007_info = {
 /* I2C */
 static struct i2c_board_info i2c1_devices[] = {
 	{
+		I2C_BOARD_INFO("r2025sd", 0x32),
+	},
+	{
 		I2C_BOARD_INFO("tsc2007", 0x48),
 		.type		= "tsc2007",
 		.platform_data	= &tsc2007_info,
-- 
1.6.3.3

