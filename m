From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 08:09:06 +0000
Subject: [PATCH 11/13 v4][RFC] Local: Hack: disable CONFIG_SUSPEND
Message-Id: <87h9ocyh7u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Since cpu suspend is not supported in R-Car Gen3 initial version,
disable CONFIG_SUSPEND as interim fix until pcsi is available.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
---
v3 -> v4

 - new patch

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 53519ae..9139c0b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -56,6 +56,7 @@ CONFIG_CMA=y
 CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
+# CONFIG_SUSPEND is not set
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_NET=y
-- 
1.9.1

