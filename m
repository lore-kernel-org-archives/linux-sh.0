From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Dec 2008 10:33:37 +0000
Subject: [PATCH 08/10] clocksource: add read2() callback
Message-Id: <20081201103337.26620.38744.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add a read2() callback for clocksources. This callback is passing
a pointer to struct clocksource which makes it easy to share the
same callback for multiple clocksource instances.

The function clocksource_read() is modified to prefer read2() over
read() if initialized.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/linux/clocksource.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- 0001/include/linux/clocksource.h
+++ work/include/linux/clocksource.h	2008-11-27 13:58:25.000000000 +0900
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
