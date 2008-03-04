From: Adrian Bunk <adrian.bunk@movial.fi>
Date: Tue, 04 Mar 2008 22:39:58 +0000
Subject: [2.6 patch] sh_ksyms_32.c update for gcc 4.3
Message-Id: <20080304223958.GA2136@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following build error with landisk_defconfig when 
using gcc 4.3:

<--  snip  -->

...
  MODPOST 50 modules
ERROR: "__udivsi3_i4i" [net/sunrpc/sunrpc.ko] undefined!
ERROR: "__udivsi3_i4i" [net/appletalk/appletalk.ko] undefined!
ERROR: "__udivsi3_i4i" [fs/ufs/ufs.ko] undefined!
ERROR: "__udivsi3_i4i" [fs/ntfs/ntfs.ko] undefined!
ERROR: "__sdivsi3_i4i" [fs/ntfs/ntfs.ko] undefined!
ERROR: "__udivsi3_i4i" [fs/nfsd/nfsd.ko] undefined!
ERROR: "__sdivsi3_i4i" [fs/nfsd/nfsd.ko] undefined!
ERROR: "__udivsi3_i4i" [fs/nfs/nfs.ko] undefined!
ERROR: "__udivsi3_i4i" [fs/lockd/lockd.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/usb/storage/usb-storage.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/usb/serial/pl2303.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/usb/serial/pl2303.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/usb/serial/ftdi_sio.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/usb/misc/sisusbvga/sisusbvga.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/usb/misc/sisusbvga/sisusbvga.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/media/video/v4l1-compat.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/media/video/v4l1-compat.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/media/video/usbvideo/vicam.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/media/video/usbvideo/usbvideo.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/media/video/usbvideo/usbvideo.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/media/video/sn9c102/sn9c102.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/media/video/sn9c102/sn9c102.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/media/video/se401.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/media/video/pwc/pwc.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/md/raid0.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/md/md-mod.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/md/md-mod.ko] undefined!
ERROR: "__udivsi3_i4i" [drivers/md/linear.ko] undefined!
ERROR: "__sdivsi3_i4i" [drivers/hid/usbhid/usbhid.ko] undefined!
make[2]: *** [__modpost] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <adrian.bunk@movial.fi>

---
d8726fd3d9224aaf1000054f32438f03d6e1a915 foobar
diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index e1a6de9..a12f115 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -111,9 +111,9 @@ DECLARE_EXPORT(__movmem_i4_even);
 DECLARE_EXPORT(__movmem_i4_odd);
 DECLARE_EXPORT(__movmemSI12_i4);
 
-#if (__GNUC_MINOR__ = 2 || defined(__GNUC_STM_RELEASE__))
+#if (__GNUC_MINOR__ >= 2 || defined(__GNUC_STM_RELEASE__))
 /*
- * GCC 4.2 emits these for division, as do GCC 4.1.x versions of the ST
+ * GCC >= 4.2 emits these for division, as do GCC 4.1.x versions of the ST
  * compiler which include backported patches.
  */
 DECLARE_EXPORT(__sdivsi3_i4i);

