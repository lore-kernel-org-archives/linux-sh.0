From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 02 Dec 2009 09:36:18 +0000
Subject: [PATCH] sh: mach-ecovec24: Remove un-defined settings for VPU
Message-Id: <uiqcpzpil.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The setting of VPU need not be changed from default.
And current setting value is not defined on SH7724

Reported-by:   Goda Yusuke <goda.yusuke@renesas.com>
Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 .../mach-ecovec24/mach/partner-jet-setup.txt       |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
index 09aaabc..cc737b8 100644
--- a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
+++ b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
@@ -22,7 +22,6 @@ ED 0xff000010, 0x00000004
 LIST "setup clocks"
 ED 0xa4150024, 0x00004000
 ED 0xa4150000, 0x8E003508
-ED 0xa4150004, 0x00000000
 
 WAIT 1
 
-- 
1.6.3.3

