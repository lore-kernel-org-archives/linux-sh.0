From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 11:08:02 +0000
Subject: SDHI and MMCIF with kzm9g-reference
Message-Id: <20130301110802.GB24364@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

this is a heads-up about the state of SDHI and MMCIF with kzm9g-reference
in the current next and topic/all+next branches.

Currently the boot will not complete. It stalls in SDHI or MMCIF
initialisation (whichever comes first), though it doesn't say so.

The reason is msleep() calls. In the case of SDHI in the driver itself.
In the case of MMCIF in the MMC core code.

I had the following patch in next for a while but removed it a few days
ago because for some reason I thought my tests showed it was no longer needed.
I now believe it is needed and I will put it back into next and
topic/all+next ASAP. I do not plan to make any other changes to my branches
in what is left of today for me.


From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 11 Dec 2012 10:20:21 +0900
Subject: [PATCH] ARM: clocksource: Initialise early

Initialise clock sources early, since some subsystems rely on them to
initialize.

This came up when working on DT support for the kzm9g board.
The prototype does not use early timers and I found that the
CMT clocksource needs to be initialised before the MMCIF MMC driver.

Cc: linux-kernel@vger.kernel.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/Makefile |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 7863b9f..f156db5 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -37,6 +37,11 @@ obj-$(CONFIG_XEN)		+= xen/
 # regulators early, since some subsystems rely on them to initialize
 obj-$(CONFIG_REGULATOR)		+= regulator/
 
+# clocksource early, since some subsystems rely on them to initialize
+ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
+obj-y				+= clocksource/
+endif
+
 # tty/ comes before char/ so that the VT console is the boot-time
 # default.
 obj-y				+= tty/
@@ -114,9 +119,6 @@ obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_ARCH_SHMOBILE)	+= sh/
-ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
-obj-y				+= clocksource/
-endif
 obj-$(CONFIG_DCA)		+= dca/
 obj-$(CONFIG_HID)		+= hid/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
-- 
1.7.10.4

