From: bd-phuc@jinso.co.jp
Date: Fri, 09 Sep 2016 11:43:14 +0000
Subject: [PATCH 8/8] ARM64: defconfig: Enable SH_TIMER_CMT config option
Message-Id: <1473421394-9745-9-git-send-email-bd-phuc@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
In-Reply-To: <1473421394-9745-1-git-send-email-bd-phuc@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Bui Duc Phuc <bd-phuc@jinso.co.jp>

Enable SH CMT driver for R-car Gen3 : SH_TIMER_CMT

Signed-off-by: Bui Duc Phuc <bd-phuc@jinso.co.jp>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf485..72f892d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -3,6 +3,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_SH_TIMER_CMT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASKSTATS=y
-- 
2.7.4

