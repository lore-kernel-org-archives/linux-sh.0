From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 21 Nov 2012 02:53:32 +0000
Subject: [PATCH 16/42] sh: Select PINCTRL for CPU subtypes that require it
Message-Id: <1353466438-10929-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This will be required when the sh-pfc driver will move to
drivers/pinctrl/.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/Kconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index babc2b8..c72b616 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -276,6 +276,7 @@ config CPU_SUBTYPE_SH7203
 	select SYS_SUPPORTS_CMT
 	select SYS_SUPPORTS_MTU2
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7206
 	bool "Support SH7206 processor"
@@ -296,6 +297,7 @@ config CPU_SUBTYPE_SH7264
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_CMT
 	select SYS_SUPPORTS_MTU2
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7269
 	bool "Support SH7269 processor"
@@ -303,6 +305,7 @@ config CPU_SUBTYPE_SH7269
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_CMT
 	select SYS_SUPPORTS_MTU2
+	select PINCTRL
 
 config CPU_SUBTYPE_MXG
 	bool "Support MX-G processor"
@@ -364,6 +367,7 @@ config CPU_SUBTYPE_SH7720
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
 	select USB_OHCI_SH if USB_OHCI_HCD
+	select PINCTRL
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.
 
@@ -429,6 +433,7 @@ config CPU_SUBTYPE_SH7723
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
 
@@ -440,6 +445,7 @@ config CPU_SUBTYPE_SH7724
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 	help
 	  Select SH7724 if you have an SH-MobileR2R CPU.
 
@@ -450,6 +456,7 @@ config CPU_SUBTYPE_SH7734
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
+	select PINCTRL
 	help
 	  Select SH7734 if you have a SH4A SH7734 CPU.
 
@@ -460,6 +467,7 @@ config CPU_SUBTYPE_SH7757
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
 	select USB_ARCH_HAS_EHCI
+	select PINCTRL
 	help
 	  Select SH7757 if you have a SH4A SH7757 CPU.
 
@@ -486,6 +494,7 @@ config CPU_SUBTYPE_SH7785
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7786
 	bool "Support SH7786 processor"
@@ -498,6 +507,7 @@ config CPU_SUBTYPE_SH7786
 	select USB_OHCI_SH if USB_OHCI_HCD
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_SH if USB_EHCI_HCD
+	select PINCTRL
 
 config CPU_SUBTYPE_SHX3
 	bool "Support SH-X3 processor"
@@ -505,6 +515,7 @@ config CPU_SUBTYPE_SHX3
 	select CPU_SHX3
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select ARCH_REQUIRE_GPIOLIB
+	select PINCTRL
 
 # SH4AL-DSP Processor Support
 
@@ -523,6 +534,7 @@ config CPU_SUBTYPE_SH7722
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 
 config CPU_SUBTYPE_SH7366
 	bool "Support SH7366 processor"
-- 
1.7.8.6

