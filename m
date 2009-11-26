From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 26 Nov 2009 06:00:29 +0000
Subject: [PATCH] sh: mach-ecovec24: modify address map
Message-Id: <uiqcxomf6.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ecovec24 board expect address map 2 instead of map 1

Signed-off-by: Mizukawa Tatsuo <mizukawa.tatsuo@renesas.com>
Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 .../mach-ecovec24/mach/partner-jet-setup.txt       |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
index 8b8e4fa..09aaabc 100644
--- a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
+++ b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
@@ -28,7 +28,7 @@ WAIT 1
 
 LIST "BSC"
 ED 0xff800020, 0xa5a50000
-ED 0xfec10000, 0x00000013
+ED 0xfec10000, 0x00001013
 ED 0xfec10004, 0x11110400
 ED 0xfec10024, 0x00000440
 
-- 
1.6.3.3

