From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 10 Jan 2013 10:16:42 +0000
Subject: [PATCH 0/2] allow unplugging of CPU0
Message-Id: <1357813004-9549-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

sh73a0 appears to deal fine with having its first core disabled, so we
should allow that.

This may not be the case with all platforms, so as per suggestion of
Magnus, so I have introduced a new method (shmobile_cpu_disable_any())
that removes the restriction on CPU0.

CU
Uli

Ulrich Hecht (2):
  ARM: mach-shmobile: add shmobile_cpu_disable_any()
  ARM: mach-shmobile: sh73a0: allow unplugging of CPU0

 arch/arm/mach-shmobile/hotplug.c             |    6 ++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/smp-sh73a0.c          |    2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
1.7.10.4

