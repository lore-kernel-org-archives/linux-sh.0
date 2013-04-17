From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 17 Apr 2013 18:47:27 +0000
Subject: [PATCH 2/2] ARM: shmobile: BOCK-W: enable I2C in defconfig
Message-Id: <201304172247.28311.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304172242.27671.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304172242.27671.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Enable I2C driver in 'bockw_defconfig'.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/configs/bockw_defconfig |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/arch/arm/configs/bockw_defconfig
=================================--- renesas.orig/arch/arm/configs/bockw_defconfig
+++ renesas/arch/arm/configs/bockw_defconfig
@@ -73,6 +73,8 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=6
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
+CONFIG_I2C=y
+CONFIG_I2C_RCAR=y
 CONFIG_USB=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_EHCI_HCD=y
