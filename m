From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 04 Dec 2009 14:52:52 +0000
Subject: [PATCH (sh-2.6.30.y) 10/13] stm: pm: Fixed resume from hibernation on sysconf
Message-Id: <1259938375-27499-10-git-send-email-francesco.virlinzi@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes the resume from hibernation in the sysconf device driver

Signed-off-by: Francesco Virlinzi <francesco.virlinzi@st.com>
---
 drivers/stm/sysconf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/stm/sysconf.c b/drivers/stm/sysconf.c
index cc599be..75ebe67 100644
--- a/drivers/stm/sysconf.c
+++ b/drivers/stm/sysconf.c
@@ -330,7 +330,7 @@ static int sysconf_pm_freeze(void)
 			continue;
 		}
 
-		for (j = 0; j < block->size; i += sizeof(unsigned long))
+		for (j = 0; j < block->size; j += sizeof(unsigned long))
 			block->snapshot[j / sizeof(unsigned long)]  					readl(block->base + j);
 	}
@@ -358,7 +358,7 @@ static int sysconf_pm_restore(void)
 			continue;
 		}
 
-		for (j = 0; j < block->size; i += sizeof(unsigned long))
+		for (j = 0; j < block->size; j += sizeof(unsigned long))
 			writel(block->snapshot[j / sizeof(unsigned long)],
 					block->base + j);
 
-- 
1.6.2.5

