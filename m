From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 06:35:36 +0000
Subject: [PATCH 02/02] ARM: shmobile: Drop HAVE_ARM_ARCH_TIMER from defconfig
Message-Id: <20150621063536.6194.32705.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove arch timer from the defconfig now when this is selected
by Kconfig based on enabled SoC variants.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/configs/shmobile_defconfig |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/configs/shmobile_defconfig
+++ work/arch/arm/configs/shmobile_defconfig	2015-06-20 12:32:43.752366518 +0900
@@ -30,7 +30,6 @@ CONFIG_PCI_RCAR_GEN2=y
 CONFIG_PCI_RCAR_GEN2_PCIE=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
-CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_NR_CPUS=8
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
