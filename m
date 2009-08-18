From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 18 Aug 2009 06:51:28 +0000
Subject: [PATCH] kfr2409: add FLLFRQ value
Message-Id: <ueir9y5qn.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


FLLFRQ setting is needed to use correct PLL clock for kfr2409.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 .../mach-kfr2r09/mach/partner-jet-setup.txt        |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt b/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
index 9c85088..25801d4 100644
--- a/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
+++ b/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
@@ -24,6 +24,7 @@ LIST "setup clocks"
 ED 0xa4150004, 0x00000050
 ED 0xa4150000, 0x91053508
 WAIT 1
+ED 0xa4150050, 0x00000340
 ED 0xa4150024, 0x00005000
 
 LIST "setup pins"
-- 
1.6.0.4

