From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 04 Jun 2015 18:22:34 +0000
Subject: [PATCH 10/11] ARM: shmobile: r8a7779: Make struct rcar_sysc_ch const
Message-Id: <1433442155-19492-11-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/pm-r8a7779.c  |  3 ++-
 arch/arm/mach-shmobile/smp-r8a7779.c | 12 ++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-r8a7779.c b/arch/arm/mach-shmobile/pm-r8a7779.c
index d5f258e4d890f0ca..47a862e7f8bab242 100644
--- a/arch/arm/mach-shmobile/pm-r8a7779.c
+++ b/arch/arm/mach-shmobile/pm-r8a7779.c
@@ -35,7 +35,8 @@ struct r8a7779_pm_domain {
 	struct rcar_sysc_ch ch;
 };
 
-static inline struct rcar_sysc_ch *to_r8a7779_ch(struct generic_pm_domain *d)
+static inline
+const struct rcar_sysc_ch *to_r8a7779_ch(struct generic_pm_domain *d)
 {
 	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
 }
diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 01f792fcb220188a..9122216df0604004 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -32,25 +32,25 @@
 #define AVECR IOMEM(0xfe700040)
 #define R8A7779_SCU_BASE 0xf0000000
 
-static struct rcar_sysc_ch r8a7779_ch_cpu1 = {
+static const struct rcar_sysc_ch r8a7779_ch_cpu1 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
 	.chan_bit = 1, /* ARM1 */
 	.isr_bit = 1, /* ARM1 */
 };
 
-static struct rcar_sysc_ch r8a7779_ch_cpu2 = {
+static const struct rcar_sysc_ch r8a7779_ch_cpu2 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
 	.chan_bit = 2, /* ARM2 */
 	.isr_bit = 2, /* ARM2 */
 };
 
-static struct rcar_sysc_ch r8a7779_ch_cpu3 = {
+static const struct rcar_sysc_ch r8a7779_ch_cpu3 = {
 	.chan_offs = 0x40, /* PWRSR0 .. PWRER0 */
 	.chan_bit = 3, /* ARM3 */
 	.isr_bit = 3, /* ARM3 */
 };
 
-static struct rcar_sysc_ch *r8a7779_ch_cpu[4] = {
+static const struct rcar_sysc_ch * const r8a7779_ch_cpu[4] = {
 	[1] = &r8a7779_ch_cpu1,
 	[2] = &r8a7779_ch_cpu2,
 	[3] = &r8a7779_ch_cpu3,
@@ -66,7 +66,7 @@ void __init r8a7779_register_twd(void)
 
 static int r8a7779_platform_cpu_kill(unsigned int cpu)
 {
-	struct rcar_sysc_ch *ch = NULL;
+	const struct rcar_sysc_ch *ch = NULL;
 	int ret = -EIO;
 
 	cpu = cpu_logical_map(cpu);
@@ -82,7 +82,7 @@ static int r8a7779_platform_cpu_kill(unsigned int cpu)
 
 static int r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	struct rcar_sysc_ch *ch = NULL;
+	const struct rcar_sysc_ch *ch = NULL;
 	unsigned int lcpu = cpu_logical_map(cpu);
 	int ret;
 
-- 
1.9.1

