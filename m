From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Jul 2014 00:28:09 +0000
Subject: [PATCH] ARM: shmobile: Enable genmai board in multiplatform defconfig
Message-Id: <c61010050d3baa3e1a3964bec7e62437d21107c6.1404172763.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1404172763.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1404172763.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index c4b72aa..5f05e98 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -10,9 +10,11 @@ CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_ARCH_SHMOBILE_MULTI=y
 CONFIG_ARCH_EMEV2=y
+CONFIG_ARCH_R7S72100=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_MACH_GENMAI=y
 CONFIG_MACH_KOELSCH=y
 CONFIG_MACH_LAGER=y
 CONFIG_MACH_MARZEN=y
-- 
2.0.0.rc2

