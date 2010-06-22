From: Sankar P <sankar.curiosity@gmail.com>
Date: Tue, 22 Jun 2010 08:58:43 +0000
Subject: [PATCH] kmemleak: config-options: Default buffer size for kmemleak
Message-Id: <1277196403-20836-1-git-send-email-sankar.curiosity@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTimb7rP0rS0OU8nan5uNEhHx_kEYL99ImZ3c8o0D@mail.gmail.com> <1277189909-16376-1-git-send-email-sankar.curiosity@gmail.com> <4C20702C.1080405@cs.helsinki.fi>
In-Reply-To: <4C20702C.1080405@cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: penberg@cs.helsinki.fi
Cc: lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, lrodriguez@atheros.com, catalin.marinas@arm.com, rnagarajan@novell.com, teheo@novell.com, linux-mm@kvack.org, paulmck@linux.vnet.ibm.com, mingo@elte.hu, akpm@linux-foundation.org, Sankar P <sankar.curiosity@gmail.com>

If we try to find the memory leaks in kernel that is
compiled with 'make defconfig', the default buffer size
of DEBUG_KMEMLEAK_EARLY_LOG_SIZE seem to be inadequate.

Change the buffer size from 400 to 1000,
which is sufficient for most cases.

Signed-off-by: Sankar P <sankar.curiosity@gmail.com>
---

Thanks to Pekka Enberg's comments on my previous mail, I am sending a better patch,
and adding new reviewers as suggested by the get_maintainer script. 

 lib/Kconfig.debug |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e722e9d..5eb9463 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -382,7 +382,7 @@ config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
 	int "Maximum kmemleak early log entries"
 	depends on DEBUG_KMEMLEAK
 	range 200 40000
-	default 400
+	default 1000
 	help
 	  Kmemleak must track all the memory allocations to avoid
 	  reporting false positives. Since memory may be allocated or
-- 
1.6.4.2

