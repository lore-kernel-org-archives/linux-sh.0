From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Dec 2012 00:46:28 +0000
Subject: [PATCH] ARM: clocksource: Initialise early (repost)
Message-Id: <20121213004628.GA26680@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Initialise clock sources early, since some subsystems rely on them to initialize

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Repost to add LKML to CC list.

v3
* Initial post
---
 drivers/Makefile |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index a16a8d0..eba9b58 100644
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

