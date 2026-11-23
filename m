Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424264;
	b=Ev0lPTeu8Pl+AlX71N1p206njTKfpAPzt1ZxG4jt6no9qRq9+bgbk7mBDtddnMRWov/g
	 MNMxTJLvMSrA4kXGvZnRKkqvb86Vblnr7scxKmLhL2+N6vGYulEfUyw6mcz1qwE5BU2Ig
	 vGzVxBySmjn7iQbw+wfZeprYkVoBC3QPlSs3A5J1f2EWywenLz/cicSg0yUr7N60rlI4Y
	 8B5qgSeRKI80PLe2DU8dmIMesdAaL70SM5YQeSfL9/6Rev9oFhik+NlysX3wBJ03D1NJL
	 xEky8tL484r+l7O5UkTX/E0u/kOhGs6qdP2M1s83YouSc0dAKDptCVcEnI/qi2E+PBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424264;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ApqXI+L+rJvaTMWirTj9cIQB1urHs8z+JAG5Yj708Rk=;
	b=rDkXKutXPfZgPe7+1GIgavKvoltzoAngTX4dulNq6VqiliNgS+t9iMHHB2Z7YadRNKoW
	 pCUYYpGAKAaGflUpUcTAYy09lAVJlG6miEFVA5Jbb9AZmVNyyaRqg8SbFrMgl6LK0Rft/
	 /crDXKggbcSpFs4bDKBkvCXSjRE7z6DSz7FLfdvNddnuYGKF0dSAuciqEfD1VwJNhVO6Z
	 kXgt5Bs9OjcvZviMwQqU1kQkI9ADnbwESk0vsgw0To3kW38WLuT1iCqT0ZWQLOPTCZIbO
	 EFKHfJ7bVlTUWYGoyqdPV3k2H9huyFoHR6SukrC1zVzoOJvTET58VrvTx+wJAV23hEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9nTSCJU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106EE606A331;
	Mon, 23 Nov 2026 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X9nTSCJU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5969E1F000D0;
	Mon, 23 Nov 2026 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424263;
	bh=ApqXI+L+rJvaTMWirTj9cIQB1urHs8z+JAG5Yj708Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X9nTSCJU4tFQ/WzCTKIEu1+uyCly9AXS/Au/44r/jtp2Ll4RUJponQ6c77gm2d0QQ
	 s5XNmDIrvsIeoeErfLVwEK3xGjTQYCk7CdRKDiDK+4kl3YKMqz2eL5/hQGZ8lZ8Wql
	 v1d3ykuFXH2AGSfzcof2m8SRqFyccj17WAfP13MxEQN1ckYrQyMmTr0Zlg3JukjhEO
	 C3GsEsoD3yyFmL3ryKQf+vyUNDDzoZRUAwkDX4zXpcMh2jX7AZJoZEq3xzcWze9M3/
	 ST3Mmlsgz/uaO+kP+krck/kEilBgf2X1BBpmkHbFHQaWmhyFLvzt4iyVNbBSDPIER9
	 0ew/Xm0zxrY8w==
From: Arnd Bergmann <arnd@kernel.org>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Gibson <warthog618@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 2/2] [v8] gpiolib: remove linux/gpio.h
Date: Mon, 23 Nov 2026 09:57:23 +0100
Message-ID: <20261123085723.156933-3-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123085723.156933-1-arnd@kernel.org>
References: <20261123085723.156933-1-arnd@kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After all other drivers have converted to linux/gpio/consumer.h
or linux/gpio/legacy.h, remove the final leftover bits here.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 MAINTAINERS                                  |  1 -
 arch/mips/txx9/rbtx4927/setup.c              |  2 +-
 drivers/gpio/TODO                            |  4 +---
 drivers/gpio/gpiolib-cdev.c                  |  2 +-
 drivers/gpio/gpiolib-legacy.c                |  3 +--
 drivers/gpio/gpiolib.c                       |  2 +-
 drivers/net/wireless/morsemicro/mm81x/hw.c   |  1 -
 drivers/net/wireless/morsemicro/mm81x/yaps.c |  1 -
 include/linux/gpio.h                         | 22 --------------------
 9 files changed, 5 insertions(+), 33 deletions(-)
 delete mode 100644 include/linux/gpio.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 829c795c13b3..7efa1e6446a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11589,7 +11589,6 @@ F:	Documentation/devicetree/bindings/gpio/
 F:	Documentation/driver-api/gpio/
 F:	drivers/gpio/
 F:	include/dt-bindings/gpio/
-F:	include/linux/gpio.h
 F:	include/linux/gpio/
 K:	(devm_)?gpio_(request|free|direction|get|set)
 K:	GPIOD_FLAGS_BIT_NONEXCLUSIVE
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 223889c03186..fdbe2bd87979 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -48,7 +48,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/leds.h>
 #include <asm/io.h>
diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index 7ce80fde1f17..4fce4a7e4704 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -52,9 +52,7 @@ Work items:
   base can be made dynamic (set to -1) if CONFIG_GPIO_SYSFS is disabled.
 
 - When this work is complete (will require some of the items in the
-  following ongoing work as well) we can delete the old global
-  numberspace accessors from <linux/gpio.h> and eventually delete
-  <linux/gpio.h> altogether.
+  following ongoing work as well) we can delete <linux/gpio/legacy.h>.
 
 -------------------------------------------------------------------------------
 
diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index d877f2de506c..795f7df5b540 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -11,7 +11,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/file.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/hte.h>
 #include <linux/interrupt.h>
diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.c
index c2b04605b203..a841208dc19a 100644
--- a/drivers/gpio/gpiolib-legacy.c
+++ b/drivers/gpio/gpiolib-legacy.c
@@ -7,8 +7,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
-
-#include <linux/gpio.h>
+#include <linux/gpio/legacy.h>
 
 #include "gpiolib.h"
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index c09342fc52cb..c16d69761e04 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -30,7 +30,7 @@
 #include <linux/string_choices.h>
 #include <linux/workqueue.h>
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 
diff --git a/drivers/net/wireless/morsemicro/mm81x/hw.c b/drivers/net/wireless/morsemicro/mm81x/hw.c
index 9293f4094db1..e48eaf151faa 100644
--- a/drivers/net/wireless/morsemicro/mm81x/hw.c
+++ b/drivers/net/wireless/morsemicro/mm81x/hw.c
@@ -7,7 +7,6 @@
 #include <linux/stringify.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
-#include <linux/gpio.h>
 #include "hif.h"
 #include "mac.h"
 #include "bus.h"
diff --git a/drivers/net/wireless/morsemicro/mm81x/yaps.c b/drivers/net/wireless/morsemicro/mm81x/yaps.c
index 2d1728c1a6de..a843c1c16216 100644
--- a/drivers/net/wireless/morsemicro/mm81x/yaps.c
+++ b/drivers/net/wireless/morsemicro/mm81x/yaps.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2017-2026 Morse Micro
  */
-#include <linux/gpio.h>
 #include <linux/random.h>
 #include <linux/timer.h>
 #include <linux/bitops.h>
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
deleted file mode 100644
index b0d4942a65de..000000000000
--- a/include/linux/gpio.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * NOTE: This header *must not* be included.
- *
- * If you're implementing a GPIO driver, only include <linux/gpio/driver.h>
- * If you're implementing a GPIO consumer, only include <linux/gpio/consumer.h>
- * If you're using the legacy interfaces, include <linux/gpio/legacy.h>
- */
-
-#ifndef __LINUX_GPIO_H
-#define __LINUX_GPIO_H
-
-#include <linux/types.h>
-#ifdef CONFIG_GPIOLIB
-#include <linux/gpio/consumer.h>
-#endif
-
-#ifdef CONFIG_GPIOLIB_LEGACY
-#include <linux/gpio/legacy.h>
-#endif /* CONFIG_GPIOLIB_LEGACY */
-
-#endif /* __LINUX_GPIO_H */
-- 
2.53.0

