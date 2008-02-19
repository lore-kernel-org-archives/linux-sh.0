From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Tue, 19 Feb 2008 00:57:04 +0000
Subject: [PATCH] sh: fix rtc_resources setup for sh770x
Message-Id: <20080219013258.GA30331@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Fix the RTC resources setup for sh770x. Whit these proper
start values RTC driver (drivers/rtc/rtc-sh.c) works.

Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>
---
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
index 969804b..9066ed7 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -123,15 +123,15 @@ static struct resource rtc_resources[] = {
                .flags  = IORESOURCE_IO,
        },
        [1] =   {
-               .start  = 20,
+               .start  = 21,
                .flags  = IORESOURCE_IRQ,
        },
        [2] =   {
-               .start  = 21,
+               .start  = 22,
                .flags  = IORESOURCE_IRQ,
        },
        [3] =   {
-               .start  = 22,
+               .start  = 20,
                .flags  = IORESOURCE_IRQ,
        },
 };

