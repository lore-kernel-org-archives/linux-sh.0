From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 10 Nov 2014 01:32:12 +0000
Subject: [PATCH 4/4] ARM: shmobile: multiplatform: add AK4642 support on defconfig
Message-Id: <ccde0fbd4fe88151c8d3a93a3e3a939a0a1753b2.1415582943.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415582943.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415582943.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

AK4642 is well used audio codec on Renesas reference board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 8a39a46..cc67508 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -126,6 +126,7 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SH4_FSI=y
 CONFIG_SND_SOC_RCAR=y
+CONFIG_SND_SOC_AK4642=y
 CONFIG_SND_SOC_WM8978=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.1.1

