From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Fri, 11 Jun 2010 04:51:31 +0000
Subject: [PATCH v3 3/4] Add Kconfig and Makefile for SH-2007 support
Message-Id: <1276231892-22850-4-git-send-email-mitake@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Modify Makefile and Kconfig for enabling and building SH-2007 related files.

Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
---
 arch/sh/Makefile       |    1 +
 arch/sh/boards/Kconfig |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 307b3a4..567fcd0 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -151,6 +151,7 @@ machdir-$(CONFIG_SH_LANDISK)			+= mach-landisk
 machdir-$(CONFIG_SH_LBOX_RE2)			+= mach-lboxre2
 machdir-$(CONFIG_SH_CAYMAN)			+= mach-cayman
 machdir-$(CONFIG_SH_RSK)			+= mach-rsk
+machdir-$(CONFIG_SH_SH2007)			+= mach-sh2007
 
 ifneq ($(machdir-y),)
 core-y	+= $(addprefix arch/sh/boards/, \
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 938e87d..f76c81f 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -306,6 +306,17 @@ config SH_POLARIS
 	help
 	  Select if configuring for an SMSC Polaris development board
 
+config SH_SH2007
+	bool "SH-2007 board"
+	select NO_IOPORT
+	depends on CPU_SUBTYPE_SH7780
+	help
+	  SH-2007 is a single-board computer based around SH7780 chip
+	  intended for embedded applications.
+	  It has an Ethernet interface (SMC9118), direct connected
+	  Compact Flash socket, two serial ports and PC-104 bus.
+	  More information at <http://sh2000.sh-linux.org>.
+
 endmenu
 
 source "arch/sh/boards/mach-r2d/Kconfig"
-- 
1.6.5.2

