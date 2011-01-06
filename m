From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 05:33:15 +0000
Subject: [PATCH] sh: include Migo-R TS driver in Migo-R defconfig
Message-Id: <20110106053315.13938.11769.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch enables the Migo-R specific touch screen
driver in the Migo-R defconfig.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/configs/migor_defconfig |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/sh/configs/migor_defconfig
+++ work/arch/sh/configs/migor_defconfig	2011-01-06 14:21:31.000000000 +0900
@@ -54,6 +54,8 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_SH_KEYSC=y
 # CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_MIGOR=y
 # CONFIG_SERIO is not set
 CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_SH_SCI=y
