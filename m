From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 27 Jun 2012 00:59:40 +0000
Subject: [PATCH 1/3] sh: Convert sh_clk_mstp32_register to sh_clk_mstp_register
Message-Id: <1340758782-605-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_clk_mstp32_register is deprecated. This convert to sh_clk_mstp_register.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c      |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index c045142..9e702f2 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -239,7 +239,7 @@ static int __init pcie_clk_init(struct sh7786_pcie_port *port)
 	clk->enable_reg = (void __iomem *)(chan->reg_base + SH4A_PCIEPHYCTLR);
 	clk->enable_bit = BITS_CKE;
 
-	ret = sh_clk_mstp32_register(clk, 1);
+	ret = sh_clk_mstp_register(clk, 1);
 	if (unlikely(ret < 0))
 		goto err_phy;
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index ea01a72..53638e2 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -283,7 +283,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
index 7ac07b4..22e485d 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
@@ -276,7 +276,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index 8e1f970..c4cb740 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -261,7 +261,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, HWBLK_NR);
+		ret = sh_clk_mstp_register(mstp_clks, HWBLK_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
index 35f75cf..37c41c7 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
@@ -311,7 +311,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, HWBLK_NR);
+		ret = sh_clk_mstp_register(mstp_clks, HWBLK_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 2a87901..c87e78f 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -375,7 +375,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_reparent_register(div6_clks, DIV6_NR);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, HWBLK_NR);
+		ret = sh_clk_mstp_register(mstp_clks, HWBLK_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7734.c b/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
index 1697642..deb683a 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
@@ -260,7 +260,7 @@ int __init arch_clk_init(void)
 			&div4_table);
 
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 04ab5ae..e84a432 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -148,7 +148,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
 					   &div4_table);
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index ab1c58f..1c83788 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -175,7 +175,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
 					   &div4_table);
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index 4917094..8bba6f1 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -194,7 +194,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
 					   &div4_table);
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
diff --git a/arch/sh/kernel/cpu/sh4a/clock-shx3.c b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
index 0f11b39..a9422da 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
@@ -149,7 +149,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
 					   &div4_table);
 	if (!ret)
-		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
+		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	return ret;
 }
-- 
1.7.10

