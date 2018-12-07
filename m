From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 07 Dec 2018 13:48:23 +0000
Subject: [PATCH 7/8] vfs: replace current_kernel_time64 with ktime equivalent
Message-Id: <20181207134824.300024-8-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>

current_time is the last remaining caller of current_kernel_time64(),
which is a wrapper around ktime_get_coarse_real_ts64().  This calls the
latter directly for consistency with the rest of the kernel that is moving
to the ktime_get_ family of time accessors, as now documented in
Documentation/core-api/timekeeping.rst.

An open questions is whether we may want to actually call the more
accurate ktime_get_real_ts64() for file systems that save high-resolution
timestamps in their on-disk format.  This would add a small overhead to
each update of the inode stamps but lead to inode timestamps to actually
have a usable resolution better than one jiffy (1 to 10 milliseconds
normally).  Experiments on a variety of hardware platforms show a typical
time of around 100 CPU cycles to read the cycle counter and calculate the
accurate time from that.  On old platforms without a cycle counter, this
can be signiciantly higher, up to several microseconds to access a
hardware clock, but those have become very rare by now.

I traced the original addition of the current_kernel_time() call to set
the nanosecond fields back to linux-2.5.48, where Andi Kleen added a patch
with subject "nanosecond stat timefields".  Andi explains that the
motivation was to introduce as little overhead as possible back then.  At
this time, reading the clock hardware was also more expensive when most
architectures did not have a cycle counter.

One side effect of having more accurate inode timestamp would be having to
write out the inode every time that mtime/ctime/atime get touched on most
systems, whereas many file systems today only write it when the timestamps
have changed, i.e.  at most once per jiffy unless something else changes
as well.  That change would certainly be noticed in some workloads, which
is enough reason to not do it without a good reason, regardless of the
cost of reading the time.

One thing we could still consider however would be to round the timestamps
from current_time() to multiples of NSEC_PER_JIFFY, e.g.  full
milliseconds rather than having six or seven meaningless but confusing
digits at the end of the timestamp.

Link: http://lkml.kernel.org/r/20180726130820.4174359-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9e198f00b64c..73432e64f874 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2146,7 +2146,9 @@ EXPORT_SYMBOL(timespec64_trunc);
  */
 struct timespec64 current_time(struct inode *inode)
 {
-	struct timespec64 now = current_kernel_time64();
+	struct timespec64 now;
+
+	ktime_get_coarse_real_ts64(&now);
 
 	if (unlikely(!inode->i_sb)) {
 		WARN(1, "current_time() called with uninitialized super_block in the inode");
-- 
2.18.0
