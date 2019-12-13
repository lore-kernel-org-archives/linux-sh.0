From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 13 Dec 2019 01:01:49 +0000
Subject: [PATCH v2] sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
Message-Id: <87zhfx3uo2.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

__ashiftrt_r4_xx might be used from kernel module.
We need DECLARE_EXPORT() for them, otherwise we will get compile error.
This patch adds missing DECLARE_EXPORT()

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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1 -> v2

	- r4_0  - r4_5  are added
	- r4_16 - r4_19 are added

 arch/sh/kernel/sh_ksyms_32.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index 2827744..5858936 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -38,6 +38,13 @@ DECLARE_EXPORT(__ashlsi3);
 DECLARE_EXPORT(__lshrsi3_r0);
 DECLARE_EXPORT(__ashrsi3_r0);
 DECLARE_EXPORT(__ashlsi3_r0);
+
+DECLARE_EXPORT(__ashiftrt_r4_0);
+DECLARE_EXPORT(__ashiftrt_r4_1);
+DECLARE_EXPORT(__ashiftrt_r4_2);
+DECLARE_EXPORT(__ashiftrt_r4_3);
+DECLARE_EXPORT(__ashiftrt_r4_4);
+DECLARE_EXPORT(__ashiftrt_r4_5);
 DECLARE_EXPORT(__ashiftrt_r4_6);
 DECLARE_EXPORT(__ashiftrt_r4_7);
 DECLARE_EXPORT(__ashiftrt_r4_8);
@@ -48,13 +55,23 @@ DECLARE_EXPORT(__ashiftrt_r4_12);
 DECLARE_EXPORT(__ashiftrt_r4_13);
 DECLARE_EXPORT(__ashiftrt_r4_14);
 DECLARE_EXPORT(__ashiftrt_r4_15);
+DECLARE_EXPORT(__ashiftrt_r4_16);
+DECLARE_EXPORT(__ashiftrt_r4_17);
+DECLARE_EXPORT(__ashiftrt_r4_18);
+DECLARE_EXPORT(__ashiftrt_r4_19);
 DECLARE_EXPORT(__ashiftrt_r4_20);
 DECLARE_EXPORT(__ashiftrt_r4_21);
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
