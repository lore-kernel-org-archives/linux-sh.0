From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Jul 2014 07:30:02 +0000
Subject: [PATCH] clocksource: tidyup Kconfig typo for MTU2
Message-Id: <87lhs4s3xw.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Simon <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, olof@lixom.net, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, khilman@linaro.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It should be "MTU2" instead of "TMU2"

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/clocksource/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 065131c..84f8902 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -173,7 +173,7 @@ config SH_TIMER_MTU2
 	default SYS_SUPPORTS_SH_MTU2
 	help
 	  This enables build of a clockevent driver for the Multi-Function
-	  Timer Pulse Unit 2 (TMU2) hardware available on SoCs from Renesas.
+	  Timer Pulse Unit 2 (MTU2) hardware available on SoCs from Renesas.
 	  This hardware comes with 16 bit-timer registers.
 
 config SH_TIMER_TMU
-- 
1.7.9.5

