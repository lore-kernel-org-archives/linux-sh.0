From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 24 Feb 2011 09:47:10 +0000
Subject: [PATCH] usb: add EHCI and OHCI support for SH7757
Message-Id: <4D66291E.1080204@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D660C04.9070800@renesas.com>
In-Reply-To: <4D660C04.9070800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - fix the condition for other CPU in ehci-hcd.c.

 drivers/usb/host/ehci-hcd.c |    3 ++-
 drivers/usb/host/ohci-hcd.c |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 4c77a81..b396567 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1184,7 +1184,8 @@ MODULE_LICENSE ("GPL");
 #define PLATFORM_DRIVER		ehci_mxc_driver
 #endif

-#ifdef CONFIG_CPU_SUBTYPE_SH7786
+#if defined(CONFIG_CPU_SUBTYPE_SH7757) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7786)
 #include "ehci-sh.c"
 #define PLATFORM_DRIVER		ehci_hcd_sh_driver
 #endif
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 759a12f..257974e 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -1070,6 +1070,7 @@ MODULE_LICENSE ("GPL");

 #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7757) || \
     defined(CONFIG_CPU_SUBTYPE_SH7763) || \
     defined(CONFIG_CPU_SUBTYPE_SH7786)
 #include "ohci-sh.c"
-- 
1.7.1

