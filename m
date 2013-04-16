From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 16 Apr 2013 23:03:45 +0000
Subject: [PATCH] ARM: shmobile: BOCK-W: enable CONFIG_PM_RUNTIME in defconfig
Message-Id: <201304170303.46193.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Enable CONFIG_PM_RUNTIME in 'bockw_defconfig' -- it's already used by TMU, SCI,
I2C, and Ether drivers to control the clocks...

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130416' tag.

 arch/arm/configs/bockw_defconfig |    1 +
 1 file changed, 1 insertion(+)

Index: renesas/arch/arm/configs/bockw_defconfig
=================================--- renesas.orig/arch/arm/configs/bockw_defconfig
+++ renesas/arch/arm/configs/bockw_defconfig
@@ -31,6 +31,7 @@ CONFIG_CMDLINE="console=ttySC0,115200 ig
 CONFIG_CMDLINE_FORCE=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
+CONFIG_PM_RUNTIME=y
 CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
