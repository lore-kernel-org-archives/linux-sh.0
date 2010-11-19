From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Date: Fri, 19 Nov 2010 13:21:32 +0000
Subject: [PATCH 2/2] ARM: sh-mobile: ag5evm i2c_shmobile support.
Message-Id: <4CE679DC.5010807@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Just add port multiplex settings to enable i2c modules.

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 4758690..02f64d9 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -193,6 +193,12 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_KEYOUT8, NULL);
 	gpio_request(GPIO_FN_PORT149_KEYOUT9, NULL);
 
+	/* enable IC2 2 and 3 */
+	gpio_request(GPIO_FN_PORT236_I2C_SDA2, NULL);
+	gpio_request(GPIO_FN_PORT237_I2C_SCL2, NULL);
+	gpio_request(GPIO_FN_PORT248_I2C_SCL3, NULL);
+	gpio_request(GPIO_FN_PORT249_I2C_SDA3, NULL);
+
 	/* enable SMSC911X */
 	gpio_request(GPIO_PORT144, NULL); /* PINTA2 */
 	gpio_direction_input(GPIO_PORT144);
-- 1.7.2.2 
