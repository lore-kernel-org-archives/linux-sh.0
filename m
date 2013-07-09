From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jul 2013 09:07:13 +0000
Subject: [PATCH] ARM: mach-shmobile: select the fixed regulator driver on BockW
Message-Id: <87zjtwrtj6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207051515190.30191@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207051515190.30191@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

34767f8dccc326026f97cd63f759dd36bd83502d
(ARM: mach-shmobile: select the fixed regulator driver on several boards)
decided to select fixed regulator driver on Kconfig.
BockW follows same style.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 30c571b..90f449e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -124,6 +124,7 @@ config MACH_BOCKW
 	depends on ARCH_R8A7778
 	select ARCH_REQUIRE_GPIOLIB
 	select RENESAS_INTC_IRQPIN
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 
 config MACH_MARZEN
-- 
1.7.9.5

