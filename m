From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 02 Jun 2011 08:57:10 +0000
Subject: [GIT PULL] rmobile fixes for 3.0-rc2
Message-Id: <20110602085710.GA28066@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git rmobile-fixes-for-linus

Which contains:

Damian Hobson-Garcia (1):
      sh_mobile_meram: MERAM platform data for LCDC

Guennadi Liakhovetski (2):
      ARM: arch-shmobile: support SDHI card detection on mackerel, using a GPIO
      ARM: mach-shmobile: add DMAC clock definitions on SH7372

 arch/arm/mach-shmobile/board-ap4evb.c   |   56 ++++++++++++++++++++++
 arch/arm/mach-shmobile/board-mackerel.c |   78 +++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh7372.c   |    7 +++
 3 files changed, 141 insertions(+), 0 deletions(-)
