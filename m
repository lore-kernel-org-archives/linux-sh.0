From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 17 Jun 2008 22:30:57 +0000
Subject: [2.6 patch] sh/boards/dreamcast/rtc.c: make 2 functions static
Message-Id: <20080617223057.GK25911@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch makes the needlessly global aica_rtc_{get,set}timeofday() 
static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sh/boards/dreamcast/rtc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

1716a5d5a29b5a2c16713e34465558cce3895545 diff --git a/arch/sh/boards/dreamcast/rtc.c b/arch/sh/boards/dreamcast/rtc.c
index b3a876a..a743368 100644
--- a/arch/sh/boards/dreamcast/rtc.c
+++ b/arch/sh/boards/dreamcast/rtc.c
@@ -30,7 +30,7 @@
  *
  * Grabs the current RTC seconds counter and adjusts it to the Unix Epoch.
  */
-void aica_rtc_gettimeofday(struct timespec *ts)
+static void aica_rtc_gettimeofday(struct timespec *ts)
 {
 	unsigned long val1, val2;
 
@@ -54,7 +54,7 @@ void aica_rtc_gettimeofday(struct timespec *ts)
  *
  * Adjusts the given @tv to the AICA Epoch and sets the RTC seconds counter.
  */
-int aica_rtc_settimeofday(const time_t secs)
+static int aica_rtc_settimeofday(const time_t secs)
 {
 	unsigned long val1, val2;
 	unsigned long adj = secs + TWENTY_YEARS;

