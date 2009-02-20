From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 20 Feb 2009 07:02:32 +0000
Subject: [PATCH 6/6] timer-tmu: Add SH7786 support
Message-Id: <ueixpd2gx.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/timers/timer-tmu.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/timers/timer-tmu.c b/arch/sh/kernel/timers/timer-tmu.c
index 2b62f9c..10b5a6f 100644
--- a/arch/sh/kernel/timers/timer-tmu.c
+++ b/arch/sh/kernel/timers/timer-tmu.c
@@ -244,6 +244,7 @@ static int tmu_timer_init(void)
     !defined(CONFIG_CPU_SUBTYPE_SH7721) && \
     !defined(CONFIG_CPU_SUBTYPE_SH7760) && \
     !defined(CONFIG_CPU_SUBTYPE_SH7785) && \
+    !defined(CONFIG_CPU_SUBTYPE_SH7786) && \
     !defined(CONFIG_CPU_SUBTYPE_SHX3)
 	ctrl_outb(TMU_TOCR_INIT, TMU_TOCR);
 #endif
-- 
1.5.6.3

