From: Simon Horman <horms@verge.net.au>
Date: Mon, 10 Jan 2011 23:18:00 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: mackerel: SCIF port for earlyprintk when using zboot
Message-Id: <1294701481-30950-2-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Initialise the SCIF serial port to allow earlyprintk
output when using zboot. It is based on a very similar
patched for AP4EB.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 .../mach-shmobile/include/mach/head-mackerel.txt   |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/head-mackerel.txt b/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
index e3ebfa7..efd3687 100644
--- a/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
+++ b/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
@@ -85,3 +85,10 @@ ED 0xE6150004, 0x80331050
 WAIT 1, 0xFE40009C
 
 ED 0xE6150354, 0x00000002
+
+LIST "SCIF0 - Serial port for earlyprintk"
+EB 0xE6053098, 0x11
+EB 0xE6053098, 0xe1
+EW 0xE6C40000, 0x0000
+EB 0xE6C40004, 0x19
+EW 0xE6C40008, 0x3000
-- 
1.7.2.3

