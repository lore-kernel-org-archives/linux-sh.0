From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Mar 2014 09:39:23 +0000
Subject: [PATCH trivial 1/2] ARM: shmobile: armadillo800eva: Spelling and grammar
Message-Id: <1395135565-7118-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Kosina <trivial@kernel.org>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>, Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org
---
 arch/arm/mach-shmobile/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f7465a3eb43d..edf61e5c1b7b 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -187,8 +187,8 @@ config MACH_ARMADILLO800EVA_REFERENCE
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 	---help---
-	   Use reference implementation of Aramdillo800 EVA board support
-	   which makes a greater use of device tree at the expense
+	   Use reference implementation of Armadillo800 EVA board support
+	   which makes greater use of device tree at the expense
 	   of not supporting a number of devices.
 
 	   This is intended to aid developers
-- 
1.7.9.5

