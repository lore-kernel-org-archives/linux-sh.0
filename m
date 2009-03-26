From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 26 Mar 2009 08:32:37 +0000
Subject: [PATCH] sh: Add depend on MMU for kexec
Message-Id: <49CB3DA5.1030009@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Kexec is not likely to work on NON-MMU CPU because this added
depend on MMU for kexec.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 8d50d52..19566c8 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -530,7 +530,7 @@ source kernel/Kconfig.hz

 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
-	depends on SUPERH32 && EXPERIMENTAL
+	depends on SUPERH32 && EXPERIMENTAL && MMU
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
-- 1.6.2.1
