From: Sasha Levin <sashal@kernel.org>
Date: Mon, 28 Jan 2019 15:43:14 +0000
Subject: [PATCH AUTOSEL 4.20 277/304] arch/sh/boards/mach-kfr2r09/setup.c: fix struct mtd_oob_ops build warni
Message-Id: <20190128154341.47195-277-sashal@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Magnus Damm <magnus.damm@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <sashal@kernel.org>, linux-sh@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 440e7b379f91acd245d5c8de94d533f40f5dffb3 ]

arch/sh/boards/mach-kfr2r09/setup.c does not need to #include
<mtd/onenand.h>, and doing so causes a build warning, so drop that header
file.

In file included from ../arch/sh/boards/mach-kfr2r09/setup.c:28:
../include/linux/mtd/onenand.h:225:12: warning: 'struct mtd_oob_ops' declared inside parameter list will not be visible outside of this definition or declaration
     struct mtd_oob_ops *ops);

Link: http://lkml.kernel.org/r/702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org
Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sh/boards/mach-kfr2r09/setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-kfr2r09/setup.c b/arch/sh/boards/mach-kfr2r09/setup.c
index e59c577ed871..c70bc7809dda 100644
--- a/arch/sh/boards/mach-kfr2r09/setup.c
+++ b/arch/sh/boards/mach-kfr2r09/setup.c
@@ -25,7 +25,6 @@
 #include <linux/memblock.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
-#include <linux/mtd/onenand.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_data/lv5207lp.h>
 #include <linux/platform_device.h>
-- 
2.19.1
