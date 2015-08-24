From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Aug 2015 02:32:32 +0000
Subject: [PATCH 23/25 v7][RFC] Local: Hack: remove pm_sysrq_init
Message-Id: <87vbc55siq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>

In initial H3 environment, psci/pm/suspend is not supported.
When primary cpu was booted, pm_sysrq_init() is not initialized.
So remove this function as temporary fix.

Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
---
v5 -> v7

 - no change

 kernel/power/poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
index 7ef6866..3f7ba43 100644
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -39,7 +39,7 @@ static struct sysrq_key_op	sysrq_poweroff_op = {
 
 static int __init pm_sysrq_init(void)
 {
-	register_sysrq_key('o', &sysrq_poweroff_op);
+//	register_sysrq_key('o', &sysrq_poweroff_op);
 	return 0;
 }
 
-- 
1.9.1

