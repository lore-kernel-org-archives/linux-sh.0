From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 07 May 2015 16:10:35 +0000
Subject: [PATCH 2/4] pinctrl: sh-pfc: Enable building of r8a7793 PFC support
Message-Id: <1431015037-25254-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/Kconfig  | 5 +++++
 drivers/pinctrl/sh-pfc/Makefile | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 8c4b3d3..5d570fd 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -55,6 +55,11 @@ config PINCTRL_PFC_R8A7791
 	depends on ARCH_R8A7791
 	select PINCTRL_SH_PFC
 
+config PINCTRL_PFC_R8A7793
+	def_bool y
+	depends on ARCH_R8A7793
+	select PINCTRL_SH_PFC
+
 config PINCTRL_PFC_SH7203
 	def_bool y
 	depends on CPU_SUBTYPE_SH7203
diff --git a/drivers/pinctrl/sh-pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
index f4074e1..11eefcb 100644
--- a/drivers/pinctrl/sh-pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PINCTRL_PFC_R8A7778)	+= pfc-r8a7778.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7779)	+= pfc-r8a7779.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7790)	+= pfc-r8a7790.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7791)	+= pfc-r8a7791.o
+obj-$(CONFIG_PINCTRL_PFC_R8A7793)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_SH7203)	+= pfc-sh7203.o
 obj-$(CONFIG_PINCTRL_PFC_SH7264)	+= pfc-sh7264.o
 obj-$(CONFIG_PINCTRL_PFC_SH7269)	+= pfc-sh7269.o
-- 
2.3.5

