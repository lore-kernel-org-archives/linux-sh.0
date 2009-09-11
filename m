From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 11 Sep 2009 09:05:00 +0000
Subject: [PATCH] sh: kfr2r09: add the reason to change PLL/FLL
Message-Id: <utyz9kg1v.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 .../mach-kfr2r09/mach/partner-jet-setup.txt        |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt b/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
index a19ac31..700e5ae 100644
--- a/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
+++ b/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
@@ -27,6 +27,8 @@ ED 0xff800020, 0xa5a50001
 ED 0xfec10000, 0x0000001b
 
 LIST "setup clocks"
+LIST "To avoid the frequency of RF, PLL and FLL are changed"
+LIST "This frequency influences the reception sensitivity"
 ED 0xa4150004, 0x00000050
 ED 0xa4150000, 0x91053508
 WAIT 1
-- 
1.6.0.4

