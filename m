From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 11 Jan 2016 18:41:14 +0000
Subject: [PATCH 3/3] ARM: shmobile: defconfig: Do not enable CONFIG_CPU_BPREDICT_DISABLE
Message-Id: <1452537674-20006-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Do not disable branch prediction, as this has a big performance impact.

After re-enabling branch prediction, __loop_delay() runs 16 (Cortex A15)
or 11 (Cortex A9) times faster than before.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This used to be enabled in:

  - ag5evm_defconfig (sh73a0)
  - ape6evm_defconfig (r8a73a4)
  - armadillo800eva_defconfig (r8a7740)
  - koelsch_defconfig (r8a7791)
  - kota2_defconfig (sh73a0)

Was there ever a good reason for that?
---
 arch/arm/configs/shmobile_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 969738324a5d5f81..5208b5caacd1a4e2 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -20,7 +20,6 @@ CONFIG_ARCH_R8A7791=y
 CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
-CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_PCI=y
-- 
1.9.1

