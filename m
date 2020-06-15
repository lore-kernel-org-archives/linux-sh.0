From: Flavio Suligoi <f.suligoi@asem.it>
Date: Mon, 15 Jun 2020 12:09:40 +0000
Subject: [PATCH] arch: sh: smc37c93x: fix spelling mistake
Message-Id: <20200615120940.12603-1-f.suligoi@asem.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>

Fix typo: "triger" --> "trigger"

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 arch/sh/include/asm/smc37c93x.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/smc37c93x.h b/arch/sh/include/asm/smc37c93x.h
index f054c30a171a..891f2f8f2fd0 100644
--- a/arch/sh/include/asm/smc37c93x.h
+++ b/arch/sh/include/asm/smc37c93x.h
@@ -112,8 +112,8 @@ typedef struct uart_reg {
 #define FCR_RFRES	0x0200	/* Receiver FIFO reset */
 #define FCR_TFRES	0x0400	/* Transmitter FIFO reset */
 #define FCR_DMA		0x0800	/* DMA mode select */
-#define FCR_RTL		0x4000	/* Receiver triger (LSB) */
-#define FCR_RTM		0x8000	/* Receiver triger (MSB) */
+#define FCR_RTL		0x4000	/* Receiver trigger (LSB) */
+#define FCR_RTM		0x8000	/* Receiver trigger (MSB) */
 
 /* Line Control Register */
 
-- 
2.17.1
