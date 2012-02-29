From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:18:11 +0000
Subject: [PATCH 16/17] sh: board sh_clk_ops rename
Message-Id: <20120229131811.29154.80958.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert remaining sh board code to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-highlander/setup.c |    2 +-
 arch/sh/boards/mach-sdk7786/setup.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/boards/mach-highlander/setup.c
+++ work/arch/sh/boards/mach-highlander/setup.c	2012-02-29 20:53:33.000000000 +0900
@@ -322,7 +322,7 @@ static void ivdr_clk_disable(struct clk
 	__raw_writew(__raw_readw(PA_IVDRCTL) & ~(1 << IVDR_CK_ON), PA_IVDRCTL);
 }
 
-static struct clk_ops ivdr_clk_ops = {
+static struct sh_clk_ops ivdr_clk_ops = {
 	.enable		= ivdr_clk_enable,
 	.disable	= ivdr_clk_disable,
 };
--- 0001/arch/sh/boards/mach-sdk7786/setup.c
+++ work/arch/sh/boards/mach-sdk7786/setup.c	2012-02-29 20:53:23.000000000 +0900
@@ -167,7 +167,7 @@ static void sdk7786_pcie_clk_disable(str
 	fpga_write_reg(fpga_read_reg(PCIECR) & ~PCIECR_CLKEN, PCIECR);
 }
 
-static struct clk_ops sdk7786_pcie_clk_ops = {
+static struct sh_clk_ops sdk7786_pcie_clk_ops = {
 	.enable		= sdk7786_pcie_clk_enable,
 	.disable	= sdk7786_pcie_clk_disable,
 };
