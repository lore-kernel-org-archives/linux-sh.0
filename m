From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 06 May 2011 14:14:05 +0000
Subject: superh perf events broken ?
Message-Id: <BANLkTinDMcB4_JfEqaXWPr0PwUCM1HLjwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

unless i'm missing something, it seems the core
sh/kernel/perf_events.c code broke at some point.  the events[] array
is updated in sh_pmu_{start,stop}, but no one ever reads it.  when i
look at the alpha version, that events array is walked in the
pmu_enable step before setting the global enable bit while in the
superh one, only the global enable bit is set.

so it seems like the superh pmu_enable func too should walk its
events[] array to update its settings before enabling things ...
otherwise, the whole events[] array maintenance is pointless ...
-mike
