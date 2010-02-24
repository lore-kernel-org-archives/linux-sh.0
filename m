From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 24 Feb 2010 00:16:47 +0000
Subject: [PATCH] sh: ms7724: modify scan_timing for KEYSC
Message-Id: <u8wajv5g1.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

KEYSC::SCN register of SH7724 is 3bit.
Thus, scan_timing should be 0 - 7 here.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 6419f27..ee5251f 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -313,7 +313,7 @@ static struct platform_device fsi_device = {
 /* KEYSC in SoC (Needs SW33-2 set to ON) */
 static struct sh_keysc_info keysc_info = {
 	.mode = SH_KEYSC_MODE_1,
-	.scan_timing = 10,
+	.scan_timing = 3,
 	.delay = 50,
 	.keycodes = {
 		KEY_1, KEY_2, KEY_3, KEY_4, KEY_5,
-- 
1.6.3.3

