From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 12 Dec 2019 02:38:43 +0000
Subject: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-Id: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zhfyclvb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zhfyclvb.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

__delay() is used from kernel module.
We need EXPORT_SYMBOL(), otherwise we will get compile error.

ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/lib/delay.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
index dad8e6a..540e670 100644
--- a/arch/sh/lib/delay.c
+++ b/arch/sh/lib/delay.c
@@ -29,6 +29,7 @@ void __delay(unsigned long loops)
 		: "0" (loops)
 		: "t");
 }
+EXPORT_SYMBOL(__delay);
 
 inline void __const_udelay(unsigned long xloops)
 {
-- 
2.7.4
