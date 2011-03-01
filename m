From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 01 Mar 2011 07:58:37 +0000
Subject: [PATCH] usb: EHCI, OHCI: Add configuration for the SH USB controller
Message-Id: <4D6CA72D.8030205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SH EHCI/OHCI driver hardcoded the CPU type in {ehci,ohci}-hcd.c.
So if we will add the new CPU, we had to add to the hcd driver each time.
The patch adds the CONFIG_USB_{EHCI,OHCI}_SH configuration. So if we
want to use the SH EHCI/OHCI, we only enable the configuration.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/Kconfig    |   14 ++++++++++++++
 drivers/usb/host/ehci-hcd.c |    2 +-
 drivers/usb/host/ohci-hcd.c |    5 +----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 923e5a0..9116d30 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -173,6 +173,13 @@ config USB_EHCI_HCD_PPC_OF
 	  Enables support for the USB controller present on the PowerPC
 	  OpenFirmware platform bus.

+config USB_EHCI_SH
+	bool "EHCI support for SuperH USB controller"
+	depends on USB_EHCI_HCD && SUPERH
+	---help---
+	  Enables support for the on-chip EHCI controller on the SuperH.
+	  If you use the PCI EHCI controller, this option is not necessary.
+
 config USB_W90X900_EHCI
 	bool "W90X900(W90P910) EHCI support"
 	depends on USB_EHCI_HCD && ARCH_W90X900
@@ -326,6 +333,13 @@ config USB_OHCI_HCD_SSB

 	  If unsure, say N.

+config USB_OHCI_SH
+	bool "OHCI support for SuperH USB controller"
+	depends on USB_OHCI_HCD && SUPERH
+	---help---
+	  Enables support for the on-chip OHCI controller on the SuperH.
+	  If you use the PCI OHCI controller, this option is not necessary.
+
 config USB_CNS3XXX_OHCI
 	bool "Cavium CNS3XXX OHCI Module"
 	depends on USB_OHCI_HCD && ARCH_CNS3XXX
diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index f69305d..3b24090 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1184,7 +1184,7 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_mxc_driver
 #endif

-#ifdef CONFIG_CPU_SUBTYPE_SH7786
+#ifdef CONFIG_USB_EHCI_SH
 #include "ehci-sh.c"
 #define PLATFORM_DRIVER		ehci_hcd_sh_driver
 #endif
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 759a12f..64faf7f 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1068,10 +1068,7 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ohci_hcd_da8xx_driver
 #endif

-#if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7763) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7786)
+#ifdef CONFIG_USB_OHCI_SH
 #include "ohci-sh.c"
 #define PLATFORM_DRIVER		ohci_hcd_sh_driver
 #endif
-- 
1.7.1
