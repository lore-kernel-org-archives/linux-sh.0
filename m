From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jul 2013 10:40:16 +0000
Subject: [PATCH 04/04] ARM: shmobile: Remove unused mach/dma.h
Message-Id: <20130709104016.1891.68682.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130709103944.1891.67462.sendpatchset@w520>
In-Reply-To: <20130709103944.1891.67462.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove mach-shmobile mach/dma.h since it only
seems to be used on non-mach-shmobile platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/dma.h |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/dma.h
+++ /dev/null	2013-06-03 21:41:10.638032047 +0900
@@ -1 +0,0 @@
-/* empty */
