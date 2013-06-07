From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 07 Jun 2013 23:56:05 +0000
Subject: [PATCH 3/9] sh_eth: get SH7619 support out of #ifdef
Message-Id: <201306080356.05904.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306080351.39018.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306080351.39018.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Get  the SH7619 data in the driver out of #ifdef by adding "sh7619-ether" to the
platform driver's ID table. Change the Ether platform device's name  in  the SH
platform code accordingly.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Note that in this case the driver's probe will crash anyway as the platform code
is hopelessly behind since it passes PHY ID instead of 'struct sh_eth_plat_data'
pointer as a platform data.

 arch/sh/kernel/cpu/sh2/setup-sh7619.c |    4 ++--
 drivers/net/ethernet/renesas/sh_eth.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: net-next/arch/sh/kernel/cpu/sh2/setup-sh7619.c
=================================--- net-next.orig/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ net-next/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -124,8 +124,8 @@ static struct resource eth_resources[]  };
 
 static struct platform_device eth_device = {
-	.name = "sh-eth",
-	.id	= -1,
+	.name = "sh7619-ether",
+	.id = -1,
 	.dev = {
 		.platform_data = (void *)1,
 	},
Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -680,9 +680,9 @@ static struct sh_eth_cpu_data sh_eth_my_
 	.tsu		= 1,
 	.select_mii	= 1,
 };
+#endif
 
-#elif defined(CONFIG_CPU_SUBTYPE_SH7619)
-static struct sh_eth_cpu_data sh_eth_my_cpu_data = {
+static struct sh_eth_cpu_data sh7619_data = {
 	.eesipr_value	= DMAC_M_RFRMER | DMAC_M_ECI | 0x003fffff,
 
 	.apr		= 1,
@@ -690,7 +690,6 @@ static struct sh_eth_cpu_data sh_eth_my_
 	.tpauser	= 1,
 	.hw_swap	= 1,
 };
-#endif
 
 static struct sh_eth_cpu_data sh771x_data = {
 	.eesipr_value	= DMAC_M_RFRMER | DMAC_M_ECI | 0x003fffff,
@@ -2700,6 +2699,7 @@ static const struct dev_pm_ops sh_eth_de
 #endif
 
 static struct platform_device_id sh_eth_id_table[] = {
+	{ "sh7619-ether", (kernel_ulong_t)&sh7619_data },
 	{ "sh771x-ether", (kernel_ulong_t)&sh771x_data },
 	{ CARDNAME },
 	{ }

