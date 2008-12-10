From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Dec 2008 15:12:43 +0000
Subject: [PATCH 01/05] clocksource: add read2() callback and warning
Message-Id: <20081210151243.32515.61254.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add a read2() callback for clocksources and warn if not in place.
This callback is passing a pointer to struct clocksource which makes
it easy to share the same callback for multiple clocksource instances.

The function clocksource_read() is modified to prefer read2() over
read() if initialized, and a warning is emitted at registration
time if read() is still in use. The jiffy clocksource is updated.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/linux/clocksource.h |    4 +++-
 kernel/time/clocksource.c   |    6 ++++++
 kernel/time/jiffies.c       |    4 ++--
 3 files changed, 11 insertions(+), 3 deletions(-)

--- 0001/include/linux/clocksource.h
+++ work/include/linux/clocksource.h	2008-12-10 23:06:00.000000000 +0900
@@ -43,6 +43,7 @@ struct clocksource;
  *				The ideal clocksource. A must-use where
  *				available.
  * @read:		returns a cycle value
+ * @read2:		returns a cycle value, passes clocksource as argument
  * @mask:		bitmask for two's complement
  *			subtraction of non 64 bit counters
  * @mult:		cycle to nanosecond multiplier (adjusted by NTP)
@@ -62,6 +63,7 @@ struct clocksource {
 	struct list_head list;
 	int rating;
 	cycle_t (*read)(void);
+	cycle_t (*read2)(struct clocksource *cs);
 	cycle_t mask;
 	u32 mult;
 	u32 mult_orig;
@@ -170,7 +172,7 @@ static inline u32 clocksource_hz2mult(u3
  */
 static inline cycle_t clocksource_read(struct clocksource *cs)
 {
-	return cs->read();
+	return cs->read2 ? cs->read2(cs) : cs->read();
 }
 
 /**
--- 0001/kernel/time/clocksource.c
+++ work/kernel/time/clocksource.c	2008-12-10 23:44:38.000000000 +0900
@@ -325,6 +325,12 @@ int clocksource_register(struct clocksou
 	unsigned long flags;
 	int ret;
 
+	/* warn to make sure people convert their code to read2() */
+	if (c->read)
+		printk(KERN_INFO
+			"warning: clocksource `%s' should be updated "
+			"to use read2()\n", c->name);
+
 	/* save mult_orig on registration */
 	c->mult_orig = c->mult;
 
--- 0001/kernel/time/jiffies.c
+++ work/kernel/time/jiffies.c	2008-12-10 23:44:38.000000000 +0900
@@ -50,7 +50,7 @@
  */
 #define JIFFIES_SHIFT	8
 
-static cycle_t jiffies_read(void)
+static cycle_t jiffies_read(struct clocksource *cs)
 {
 	return (cycle_t) jiffies;
 }
@@ -58,7 +58,7 @@ static cycle_t jiffies_read(void)
 struct clocksource clocksource_jiffies = {
 	.name		= "jiffies",
 	.rating		= 1, /* lowest valid rating*/
-	.read		= jiffies_read,
+	.read2		= jiffies_read,
 	.mask		= 0xffffffff, /*32bits*/
 	.mult		= NSEC_PER_JIFFY << JIFFIES_SHIFT, /* details above */
 	.mult_orig	= NSEC_PER_JIFFY << JIFFIES_SHIFT,
