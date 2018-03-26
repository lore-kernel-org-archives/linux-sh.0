From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:27:13 +0000
Subject: [PATCH 0/2] arch/sh: enable L2 cache on SH7786
Message-Id: <20180326212715.12907-1-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This small series enables the L2 cache on SH7786, bringing nice
performance improvements.

Thanks!

Thomas

Thomas Petazzoni (2):
  arch/sh: make l2_cache_init() return an integer
  arch/sh: enable L2 cache on SH7786

 arch/sh/include/cpu-sh4/cpu/cache.h    | 2 ++
 arch/sh/kernel/cpu/init.c              | 4 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c | 3 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 3 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 7 +++++++
 5 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.14.3

