From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 08:26:58 +0000
Subject: Re: [PATCH 1/2 v3] ARM: shmobile: r8a7778: i2c should not be called from C in DT
Message-Id: <20130730082657.GA12147@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo5kedk0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo5kedk0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 30, 2013 at 12:01:55AM -0700, Kuninori Morimoto wrote:
> c9fa47e287b304f3df02fc4b4b683a8d394bb9a4
> (ARM: shmobile: r8a7778: cleanup registration of i2c)
> added i2c register functions,
> but i2c will be called from C code in DT case.
> This patch fixup it
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - fixup v2's miss
> 
>  arch/arm/mach-shmobile/setup-r8a7778.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, I have squashed that into the patch I applied this morning.

The result is as follows:

commit 5aee07cb8bd629c7288e9851ef01f6be889b6f22
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Fri Jul 26 00:35:08 2013 -0700

    ARM: shmobile: r8a7778: cleanup registration of i2c
    
    i2c-rcar driver which doesn't need platform data at the time of
    registration can be registerd on SoC.
    And, registering these drivers in the SoC code can avoid
    unwanted device numbering issue.
    (ex. the i2c3 device number will be i2c.0 if i2c3 only registered)
    This patch registers it on SoC code as cleanup C code
    
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 1c876ab..d7d3427 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -200,7 +200,6 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_ether_device(&ether_platform_data);
-	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
 
 	i2c_register_board_info(0, i2c0_devices,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index aaa0544..9874511 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -23,7 +23,6 @@
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
-extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 extern void r8a7778_add_dt_devices(void);
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index c585ee0..ce3b54d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -250,7 +250,7 @@ static struct resource i2c_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x6d)),
 };
 
-void __init r8a7778_add_i2c_device(int id)
+static void __init r8a7778_register_i2c(int id)
 {
 	BUG_ON(id < 0 || id > 3);
 
@@ -308,6 +308,10 @@ void __init r8a7778_add_dt_devices(void)
 void __init r8a7778_add_standard_devices(void)
 {
 	r8a7778_add_dt_devices();
+	r8a7778_register_i2c(0);
+	r8a7778_register_i2c(1);
+	r8a7778_register_i2c(2);
+	r8a7778_register_i2c(3);
 }
 
 void __init r8a7778_init_late(void)
