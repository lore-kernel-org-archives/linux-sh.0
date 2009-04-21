From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Apr 2009 08:20:37 +0000
Subject: [GIT PULL] sh updates for 2.6.30-rc3
Message-Id: <20090421082036.GA15855@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.30

Which contains:

Paul Mundt (3):
      rtc: rtc-sh: clock framework support.
      sh: sh7722: Don't default enable the RTC clock.
      sh: sh7723: Don't default enable the RTC clock.

Toshinobu Sugioka (1):
      sh: Fix mmap2 for handling differing PAGE_SIZEs.

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    1 -
 arch/sh/kernel/sys_sh.c                |    9 ++++
 drivers/rtc/Kconfig                    |    2 +-
 drivers/rtc/rtc-sh.c                   |   67 +++++++++++++++++++++++--------
 5 files changed, 59 insertions(+), 21 deletions(-)
