From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 01 Mar 2011 07:58:47 +0000
Subject: [PATCH] sh: add to select the new configuration for USB EHCI/OHCI
Message-Id: <4D6CA737.3060802@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Because the USB EHCI/OHCI driver has new configuration for SH,
the patch enables the EHCI and/or OHCI driver of the on-chip for
some CPUs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
=E3=80=80This patch depends on the following patch in linux-usb ml:
  - usb: EHCI, OHCI: Add configuration for the SH USB controller

 arch/sh/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 8a9011d..e836a70 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -351,6 +351,7 @@ config CPU_SUBTYPE_SH7720
 	select SYS_SUPPORTS_CMT
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_SH
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.

@@ -360,6 +361,7 @@ config CPU_SUBTYPE_SH7721
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_CMT
 	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_SH
 	help
 	  Select SH7721 if you have a SH3-DSP SH7721 CPU.

@@ -441,6 +443,7 @@ config CPU_SUBTYPE_SH7763
 	bool "Support SH7763 processor"
 	select CPU_SH4A
 	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_SH
 	help
 	  Select SH7763 if you have a SH4A SH7763(R5S77631) CPU.

@@ -468,7 +471,9 @@ config CPU_SUBTYPE_SH7786
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_SH
 	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_SH

 config CPU_SUBTYPE_SHX3
 	bool "Support SH-X3 processor"
--=20
1.7.1
