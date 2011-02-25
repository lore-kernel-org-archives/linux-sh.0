From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Feb 2011 07:38:47 +0000
Subject: [PATCH 1/7] sh: add USB_ARCH_HAS_EHCI and OHCI for SH7757
Message-Id: <4D675C87.9050204@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 8a9011d..ca649d3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -434,6 +434,8 @@ config CPU_SUBTYPE_SH7757
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select USB_ARCH_HAS_OHCI
+	select USB_ARCH_HAS_EHCI
 	help
 	  Select SH7757 if you have a SH4A SH7757 CPU.

-- 
1.7.1
