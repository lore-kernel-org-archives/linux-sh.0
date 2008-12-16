From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 16 Dec 2008 07:48:12 +0000
Subject: [GIT PULL] sh updates for 2.6.28-rc9
Message-Id: <20081216074812.GA27933@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The Dreamcast port hadn't been tested in some time, so a couple of bugs
fell out in recent testing. So, here are some last minute fixes to get
the Dreamcast working again.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.28

Which contains:

Matt Fleming (1):
      sh: maple: Do not pass SLAB_POISON to kmem_cache_create()

Paul Mundt (1):
      sh: Disable GENERIC_HARDIRQS_NO__DO_IRQ for unconverted platforms.

 arch/sh/Kconfig          |    2 ++
 drivers/sh/maple/maple.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)
