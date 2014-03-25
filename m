From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:37:13 +0000
Subject: [PATCH 5/7] ARM: shmobile: bockw: enable sound codec for DT
Message-Id: <871txqdhc8.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index d042c30..c688b7e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -210,6 +210,8 @@ config MACH_BOCKW_REFERENCE
 	select ARCH_REQUIRE_GPIOLIB
 	select RENESAS_INTC_IRQPIN
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SND_SOC_AK4554 if SND_SIMPLE_CARD
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select USE_OF
 	---help---
 	   Use reference implementation of BockW board support
-- 
1.7.9.5

