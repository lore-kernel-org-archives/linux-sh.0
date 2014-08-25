From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Aug 2014 01:08:55 +0000
Subject: [GIT PULL] SH Drivers Updates For v3.17
Message-Id: <cover.1408928574.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>

Hi Linus,

Please consider these SH drivers updates for v3.17.

I realise these are slightly late in the rc cycle so
please don't hesitate to ask me to defer them to v3.18.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-drivers-for-v3.17

for you to fetch changes up to 049d28048be595e0a10a58fe1c104b153c386633:

  sh: intc: Confine SH_INTC to platforms that need it (2014-08-22 12:28:16 +0900)

----------------------------------------------------------------
SH Drivers Updates For v3.17

* Confine SH_INTC to platforms that need it

----------------------------------------------------------------
Geert Uytterhoeven (1):
      sh: intc: Confine SH_INTC to platforms that need it

 arch/arm/mach-shmobile/Kconfig | 2 ++
 arch/sh/Kconfig                | 3 +++
 drivers/sh/Makefile            | 3 +--
 drivers/sh/intc/Kconfig        | 6 +++++-
 4 files changed, 11 insertions(+), 3 deletions(-)
