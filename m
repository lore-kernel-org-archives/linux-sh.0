From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 11:59:36 +0000
Subject: [PATCH 09/13] ARM: shmobile: simplify kzm9g Kconfig dependencies
Message-Id: <1363607980-22153-10-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Reference kernel configurations for armadillo800eva and kzm9g boards do not
have to depend on their respective "legacy" configurations, doing device
instantiation in .c, they can be configured and built independently.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
[horms+renesas@verge.net.au: created separate patch for kzm9g portion]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0c48af9..ab2bb71 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -131,7 +131,11 @@ config MACH_KZM9G
 
 config MACH_KZM9G_REFERENCE
 	bool "KZM-A9-GT board - Reference Device Tree Implementation"
-	depends on MACH_KZM9G
+	depends on ARCH_SH73A0
+	select ARCH_REQUIRE_GPIOLIB
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
+	select USE_OF
 	---help---
 	   Use reference implementation of KZM-A9-GT board support
 	   which makes as greater use of device tree at the expense
-- 
1.7.10.4

