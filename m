From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 12 Dec 2019 02:38:59 +0000
Subject: [PATCH] sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_2x
Message-Id: <87v9qmcloc.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

__ashiftrt_r4_2x is used from kernel module.
We need DECLARE_EXPORT(), otherwise we will get compile error.

ERROR: "__ashiftrt_r4_25" [drivers/iio/pressure/bmp280.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/iio/dac/ad5764.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/mma7660.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/iio/accel/dmard06.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/iio/accel/bma220_spi.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/crypto/hisilicon/sec/hisi_sec.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/rtc/rtc-x1205.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf85063.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/rtc/rtc-pcf2123.ko] undefined!
ERROR: "__ashiftrt_r4_25" [drivers/input/tablet/gtco.ko] undefined!
ERROR: "__ashiftrt_r4_26" [drivers/input/mouse/psmouse.ko] undefined!
ERROR: "__ashiftrt_r4_28" [drivers/input/mouse/psmouse.ko] undefined!
ERROR: "__ashiftrt_r4_28" [drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko] undefined!
ERROR: "__ashiftrt_r4_28" [fs/udf/udf.ko] undefined!

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/kernel/sh_ksyms_32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index 2827744..5818f98 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -53,8 +53,14 @@ DECLARE_EXPORT(__ashiftrt_r4_21);
 DECLARE_EXPORT(__ashiftrt_r4_22);
 DECLARE_EXPORT(__ashiftrt_r4_23);
 DECLARE_EXPORT(__ashiftrt_r4_24);
+DECLARE_EXPORT(__ashiftrt_r4_25);
+DECLARE_EXPORT(__ashiftrt_r4_26);
 DECLARE_EXPORT(__ashiftrt_r4_27);
+DECLARE_EXPORT(__ashiftrt_r4_28);
+DECLARE_EXPORT(__ashiftrt_r4_29);
 DECLARE_EXPORT(__ashiftrt_r4_30);
+DECLARE_EXPORT(__ashiftrt_r4_31);
+DECLARE_EXPORT(__ashiftrt_r4_32);
 DECLARE_EXPORT(__movstr);
 DECLARE_EXPORT(__movstrSI8);
 DECLARE_EXPORT(__movstrSI12);
-- 
2.7.4
