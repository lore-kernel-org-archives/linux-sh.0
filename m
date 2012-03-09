From: Thomas Schwinge <thomas@codesourcery.com>
Date: Fri, 09 Mar 2012 16:38:47 +0000
Subject: [PATCH 1/7] SH: sh7785lcr board: restore big-endian operation.
Message-Id: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
endianess-agnostic I/O accessor functions.

Tested on both litte-endian and big-endian sh7785lcr.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/boards/board-sh7785lcr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index d879848..c4cb782 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -339,7 +339,7 @@ static void __init sh7785lcr_setup(char **cmdline_p)
 		return;
 	}
 
-	writel(0x000307c2, sm501_reg + SM501_DRAM_CONTROL);
+	__raw_writel(0x000307c2, sm501_reg + SM501_DRAM_CONTROL);
 	iounmap(sm501_reg);
 }
 
-- 
1.7.4.1

