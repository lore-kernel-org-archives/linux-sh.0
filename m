From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 13 Jul 2015 06:15:23 +0000
Subject: [PATCH v3 03/04] ARM: shmobile: Remove Marzen from shmobile_defconfig
Message-Id: <20150713061523.25534.1744.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Kill of the defconfig bits now when the marzen-reference board code is gone. 

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V2:
 - None

 arch/arm/configs/shmobile_defconfig |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/configs/shmobile_defconfig
+++ work/arch/arm/configs/shmobile_defconfig	2015-07-13 14:28:56.092366518 +0900
@@ -21,7 +21,6 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-CONFIG_MACH_MARZEN=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
