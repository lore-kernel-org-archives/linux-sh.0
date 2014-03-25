From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:37:06 +0000
Subject: [PATCH 4/7] ARM: shmobile: lager: enable sound codec for DT
Message-Id: <8738i6dhcg.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index edf61e5..d042c30 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -52,6 +52,7 @@ config MACH_LAGER
 	bool "Lager board"
 	depends on ARCH_R8A7790
 	select MICREL_PHY if SH_ETH
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 
 comment "Renesas ARM SoCs System Configuration"
 endif
-- 
1.7.9.5

