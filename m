From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Jun 2015 08:58:12 +0000
Subject: [PATCH v2 05/06] ARM: shmobile: Remove Marzen from shmobile_defconfig
Message-Id: <20150625085812.24543.85061.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Kill of the defconfig bits now when the marzen-reference board code is gone. 

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/configs/shmobile_defconfig |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/configs/shmobile_defconfig
+++ work/arch/arm/configs/shmobile_defconfig	2015-06-25 17:32:40.752366518 +0900
@@ -21,7 +21,6 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-CONFIG_MACH_MARZEN=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
