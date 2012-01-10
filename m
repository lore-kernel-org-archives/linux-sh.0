From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 10 Jan 2012 15:04:11 +0000
Subject: [PATCH] sh: also without PM_RUNTIME pm_runtime.o must be built
Message-Id: <Pine.LNX.4.64.1201101559450.530@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When CONFIG_PM_RUNTIME is off, drivers/sh/pm_runtime.o still has to be
built on sh platforms, because then it provides means to statically
switch on device PM clocks.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Hi Paul

Your commit

commit 681dc7e512af62d1d005df535cf02b86cddcf587
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Fri Nov 18 16:05:52 2011 +0900

    sh: Kill off remaining private runtime PM bits.

broke the CONFIG_RUNTIME_PM=n case on sh7372. This patch fixes it, and I 
hope it doesn't break any other configuration...

 drivers/sh/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index c393894..7139ad2 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -7,4 +7,4 @@ obj-$(CONFIG_HAVE_CLK)		+= clk/
 obj-$(CONFIG_MAPLE)		+= maple/
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_GENERIC_GPIO)	+= pfc.o
-obj-$(CONFIG_PM_RUNTIME)	+= pm_runtime.o
+obj-y				+= pm_runtime.o
-- 
1.7.2.5

