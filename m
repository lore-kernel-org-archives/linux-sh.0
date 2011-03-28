From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 28 Mar 2011 00:50:00 +0000
Subject: [PATCH 1/2] sh: landisk: Remove mv_nr_irqs
Message-Id: <1301273401-29948-1-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1301200307-5321-1-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301200307-5321-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/boards/mach-landisk/setup.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index 94186cf..aa1d0ad 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -97,7 +97,6 @@ static void __init landisk_setup(char **cmdline_p)
  */
 static struct sh_machine_vector mv_landisk __initmv = {
 	.mv_name = "LANDISK",
-	.mv_nr_irqs = 72,
 	.mv_setup = landisk_setup,
 	.mv_init_irq = init_landisk_IRQ,
 };
-- 
1.7.4.1

