From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 07 Dec 2018 13:48:16 +0000
Subject: [PATCH 0/8] timekeeping: cleanups
Message-Id: <20181207134824.300024-1-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: y2038@lists.linaro.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>

Here are some older cleanups that for one reason or another never made
it into the mainline kernel so far:

- the arch/sh series was posted a couple of times by both
  Baolin and me, with no reply from the sh maintainers

- the vfs patch initially got some opposition when the new
  interfaces were not documented right, but that is done now.

- The remaining three patches simply remove functions that
  have been obsoleted a while ago and have lost their last
  callers now.

I'm adding these into my y2038 tree now, so they make it into
linux-next, planning to send a pull request to Thomas for the
tip tree afterwards.

       Arnd

Arnd Bergmann (8):
  sh: dreamcast: rtc: push down rtc class ops into driver
  sh: sh03: rtc: push down rtc class ops into driver
  sh: remove unused rtc_sh_get/set_time infrastructure
  sh: remove board_time_init() callback
  timekeeping: remove unused {read,update}_persistent_clock
  timekeeping: remove timespec_add/timespec_del
  vfs: replace current_kernel_time64 with ktime equivalent
  timekeeping: remove obsolete time accessors

 Documentation/sh/new-machine.txt              |  8 --
 arch/sh/boards/mach-dreamcast/Makefile        |  4 +-
 arch/sh/boards/mach-dreamcast/rtc.c           | 39 +++++++---
 arch/sh/boards/mach-dreamcast/setup.c         |  1 -
 arch/sh/boards/mach-sh03/Makefile             |  3 +-
 arch/sh/boards/mach-sh03/rtc.c                | 51 ++++++++-----
 arch/sh/boards/mach-sh03/setup.c              |  9 ---
 arch/sh/boards/of-generic.c                   |  8 --
 arch/sh/configs/dreamcast_defconfig           |  2 +
 arch/sh/configs/sh03_defconfig                |  2 +
 arch/sh/include/asm/rtc.h                     |  3 -
 arch/sh/include/mach-dreamcast/mach/sysasic.h |  1 -
 arch/sh/kernel/time.c                         | 74 +------------------
 fs/inode.c                                    |  4 +-
 include/linux/time32.h                        | 25 -------
 include/linux/timekeeping.h                   | 14 ----
 include/linux/timekeeping32.h                 | 15 ----
 kernel/time/ntp.c                             | 10 +--
 kernel/time/time.c                            | 36 ---------
 kernel/time/timekeeping.c                     | 12 +--
 20 files changed, 73 insertions(+), 248 deletions(-)

-- 
2.18.0
