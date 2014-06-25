From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 25 Jun 2014 07:35:26 +0000
Subject: [PATCH 14/14] ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile
Message-Id: <3ed66ec5ced8b801cb851b2b8548301df94f8f54.1403681315.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

The following commit has removed ARCH_HAS_CPUFREQ config:

 Commit: e49d9b375628e67c9a718f4befaa8e45e5fad21b
 Subject: ARM: Remove ARCH_HAS_CPUFREQ config option

This patch removes the code that is using ARCH_HAS_CPUFREQ
in mach-shmobile.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index c32fa7c..cbc90f1 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -12,7 +12,6 @@ config ARCH_SHMOBILE_MULTI
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 
 if ARCH_SHMOBILE_MULTI
-- 
2.0.0.rc2

