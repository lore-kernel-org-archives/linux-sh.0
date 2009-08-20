From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Aug 2009 13:58:38 +0000
Subject: [PATCH] sh: invalidate icache and tlbs during boot on kfr2r09
Message-Id: <20090820135838.23989.86574.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add instruction cache and TLB invalidation code for the
the kfr2r09 romimage target.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
+++ work/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt	2009-08-20 13:21:57.000000000 +0900
@@ -16,6 +16,12 @@ LIST "--------------------------------"
 LIST "disable watchdog"
 EW 0xa4520004, 0xa507
 
+LIST "invalidate instruction cache"
+ED 0xff00001c, 0x00000800
+
+LIST "invalidate TLBs"
+ED 0xff000010, 0x00000004
+
 LIST "select mode for cs5 + cs6"
 ED 0xff800020, 0xa5a50001
 ED 0xfec10000, 0x0000001b
