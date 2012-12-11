From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 11 Dec 2012 03:07:29 +0000
Subject: [PATCH 1/6] ARM: clocksource: Initialise early
Message-Id: <1355195254-4563-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1355195254-4563-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Initialise clock sources early, since some subsystems rely on them to initialize

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

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

