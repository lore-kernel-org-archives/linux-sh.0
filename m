From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 27 Sep 2011 21:42:38 +0000
Subject: [GIT PULL] Power management regression fix for 3.1
Message-Id: <201109272342.38454.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Linus,

Please pull one power management regression fix for 3.1 on top of commit
f9d81f61c84aca693bc353dfef4b8c36c2e5e1b5 (ptrace: PTRACE_LISTEN forgets to
unlock ->siglock) from

git://github.com/rjwysocki/linux-pm.git pm-fixes

It fixes a locking bug introduced by one of the previous PM commits,
as described in the changelog.

Thanks!


 drivers/base/power/clock_ops.c |   75 ++++++++++++++++++++-------------------
 1 files changed, 38 insertions(+), 37 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM / Clocks: Do not acquire a mutex under a spinlock

