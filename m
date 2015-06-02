From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 02 Jun 2015 01:34:36 +0000
Subject: [PATCH 1/2] ARM: shmobile: Enable gose board in multiplatform defconfig
Message-Id: <1433208877-3284-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1433208877-3284-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1433208877-3284-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b58618e2d13c..4a6a1b2b8e03 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -18,6 +18,7 @@ CONFIG_ARCH_R8A7778=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7793=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_MARZEN=y
-- 
2.1.4

