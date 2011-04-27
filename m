From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Apr 2011 03:17:15 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb, mackerel: fixup scif initialisation for zboot
Message-Id: <1303874235-3344-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

* Set receive enable and transmit enable bits of SCASCR0 (E6C400089).
  Values previously written to this register was bogus.

  Curiously earlyprintk works with the previous code.

* Remove duplicate initialisation of GPIO port 152, SCIFA0_TXD (0xE6053098).
  This should have no effect other than to very slightly reduce the amount of
  code.

Reported-by: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 .../arm/mach-shmobile/include/mach/head-ap4evb.txt |    3 +--
 .../mach-shmobile/include/mach/head-mackerel.txt   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt b/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
index 3029aba..9f134df 100644
--- a/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
+++ b/arch/arm/mach-shmobile/include/mach/head-ap4evb.txt
@@ -87,8 +87,7 @@ WAIT 1, 0xFE40009C
 ED 0xFE400354, 0x01AD8002
 
 LIST "SCIF0 - Serial port for earlyprintk"
-EB 0xE6053098, 0x11
 EB 0xE6053098, 0xe1
 EW 0xE6C40000, 0x0000
 EB 0xE6C40004, 0x19
-EW 0xE6C40008, 0x3000
+EW 0xE6C40008, 0x0030
diff --git a/arch/arm/mach-shmobile/include/mach/head-mackerel.txt b/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
index 3029aba..9f134df 100644
--- a/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
+++ b/arch/arm/mach-shmobile/include/mach/head-mackerel.txt
@@ -87,8 +87,7 @@ WAIT 1, 0xFE40009C
 ED 0xFE400354, 0x01AD8002
 
 LIST "SCIF0 - Serial port for earlyprintk"
-EB 0xE6053098, 0x11
 EB 0xE6053098, 0xe1
 EW 0xE6C40000, 0x0000
 EB 0xE6C40004, 0x19
-EW 0xE6C40008, 0x3000
+EW 0xE6C40008, 0x0030
-- 
1.7.2.3

