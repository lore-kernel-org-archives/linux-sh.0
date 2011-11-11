From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:47:07 +0000
Subject: [PATCH 17/20] ARM: mach-shmobile: bonito: add PMIC settings
Message-Id: <87d3cz9xzs.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

bonito board needs some settings by pmic which use i2c access.
It is dependent on the device to be used.
This patch adds standard settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bonito.c |   53 +++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index efaa5fe..d78008b 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -20,6 +20,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -84,6 +85,56 @@ static void bonito_fpga_write(u32 offset, u16 val)
 }
 
 /*
+* PMIC settings
+*
+* FIXME
+*
+* bonito board needs some settings by pmic which use i2c access.
+* pmic settings use device_initcall() here for use it.
+*/
+static __u8 *pmic_settings = NULL;
+static __u8 pmic_do_2A[] = {
+	0x1C, 0x09,
+	0x1A, 0x80,
+	0xff, 0xff,
+};
+
+static int __init pmic_init(void)
+{
+	struct i2c_adapter *a = i2c_get_adapter(0);
+	struct i2c_msg msg;
+	__u8 buf[2];
+	int i, ret;
+
+	if (!pmic_settings)
+		return 0;
+	if (!a)
+		return 0;
+
+	msg.addr	= 0x46;
+	msg.buf		= buf;
+	msg.len		= 2;
+	msg.flags	= 0;
+
+	for (i = 0; ; i += 2) {
+		buf[0] = pmic_settings[i + 0];
+		buf[1] = pmic_settings[i + 1];
+
+		if ((0xff = buf[0]) && (0xff = buf[1]))
+			break;
+
+		ret = i2c_transfer(a, &msg, 1);
+		if (ret < 0) {
+			pr_err("i2c transfer fail\n");
+			break;
+		}
+	}
+
+	return 0;
+}
+device_initcall(pmic_init);
+
+/*
  * core board devices
  */
 static struct platform_device *bonito_core_devices[] __initdata = {
@@ -154,6 +205,8 @@ static void __init bonito_init(void)
 
 	r8a7740_pinmux_init();
 
+	pmic_settings = pmic_do_2A;
+
 	/*
 	 * core board settings
 	 */
-- 
1.7.5.4

