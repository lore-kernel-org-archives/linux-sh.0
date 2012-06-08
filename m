From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 08 Jun 2012 06:05:02 +0000
Subject: [PATCH 4/5] sh: SH7734: Add support SCSCR_TOIE to platform data of SCIF
Message-Id: <1339135503-1997-4-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All SCIF device of SH7734 has TOIE bit in SCSCR register.
This sets SCSCR_TOIE to platform data of SCIF.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 658ca6c..061d5db 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -28,7 +28,7 @@
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase        = 0xFFE40000,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id  = SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
 	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x8C0)),
@@ -46,7 +46,7 @@ static struct platform_device scif0_device = {
 static struct plat_sci_port scif1_platform_data = {
 	.mapbase        = 0xFFE41000,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
 	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x8E0)),
@@ -64,7 +64,7 @@ static struct platform_device scif1_device = {
 static struct plat_sci_port scif2_platform_data = {
 	.mapbase        = 0xFFE42000,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id  = SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
 	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x900)),
@@ -100,7 +100,7 @@ static struct platform_device scif3_device = {
 static struct plat_sci_port scif4_platform_data = {
 	.mapbase        = 0xFFE44000,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
 	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x940)),
@@ -118,7 +118,7 @@ static struct platform_device scif4_device = {
 static struct plat_sci_port scif5_platform_data = {
 	.mapbase        = 0xFFE43000,
 	.flags          = UPF_BOOT_AUTOCONF,
-	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE,
+	.scscr          = SCSCR_RE | SCSCR_TE | SCSCR_REIE | SCSCR_TOIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
 	.irqs           = SCIx_IRQ_MUXED(evt2irq(0x960)),
-- 
1.7.10

