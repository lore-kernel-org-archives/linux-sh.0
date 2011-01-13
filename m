From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Date: Thu, 13 Jan 2011 12:58:56 +0000
Subject: [PATCH] ARM: sh-mobile: ag5evm requires GPIOLIB
Message-Id: <4D2EF710.6080103@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Because ag5evm board setup code uses gpio functions,
ARCH_REQUIRE_GPIOLIB should be set in Kconfig.
Otherwise, the first build with defconfig fails.

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4d1b4c5..a33c44f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -60,6 +60,7 @@ endchoice
 
 config MACH_AG5EVM
 	bool "AG5EVM board"
+	select ARCH_REQUIRE_GPIOLIB
 	depends on ARCH_SH73A0
 
 config MACH_MACKEREL
-- 
1.7.2.2


