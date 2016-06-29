From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Wed, 29 Jun 2016 13:40:48 +0000
Subject: [PATCH v4 03/22] sh: set preset_lpj
Message-Id: <1467207667-15768-4-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Generic callibrate delay required this value.

Changes v4
none

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boards/of-generic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 3db4294..2d3cda3 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -128,6 +128,8 @@ static void __init sh_of_time_init(void)
 static void __init sh_of_setup(char **cmdline_p)
 {
 	struct device_node *root;
+	struct device_node *cpu;
+	u32 freq;
 
 	board_time_init = sh_of_time_init;
 
@@ -139,6 +141,10 @@ static void __init sh_of_setup(char **cmdline_p)
 	}
 
 	sh_of_smp_probe();
+
+	cpu = of_find_node_by_name(NULL, "cpu");
+	if (!of_property_read_u32(cpu, "clock-frequency", &freq))
+		preset_lpj = freq / CONFIG_HZ / 2;
 }
 
 static int sh_of_irq_demux(int irq)
-- 
2.7.0

