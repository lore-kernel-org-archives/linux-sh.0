From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 11 Jul 2011 02:53:55 +0000
Subject: [PATCH 4/6] clk: Add Kconfig option to build all generic clk drivers
Message-Id: <1310352837-4277-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<1310352837-4277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1310352837-4277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Currently drivers for the generic clk subsystem must be selected by
platforms using them in order to enable build. When doing development on
the API or generic build time testing it is useful to be able to build
unused drivers in order to improve coverage so supply a Kconfig option
which allows this.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/clk/Kconfig |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 75d2902..1fd0070 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -1,4 +1,3 @@
-
 config CLKDEV_LOOKUP
 	bool
 	select HAVE_CLK
@@ -6,6 +5,16 @@ config CLKDEV_LOOKUP
 config GENERIC_CLK
 	bool
 
+config GENERIC_CLK_BUILD_TEST
+	bool "Build all generic clock drivers"
+	depends on EXPERIMENTAL && GENERIC_CLK
+	select GENERIC_CLK_FIXED
+	select GENERIC_CLK_GATE
+	help
+	   Enable all possible generic clock drivers.  This is only
+	   useful for improving build coverage, it is not useful for
+	   production kernel builds.
+
 config GENERIC_CLK_FIXED
 	bool
 	depends on GENERIC_CLK
-- 
1.7.5.4

