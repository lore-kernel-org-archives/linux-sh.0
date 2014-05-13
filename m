From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 13 May 2014 07:42:04 +0000
Subject: [GIT PULL] SH Driver Updates for v3.15
Message-Id: <cover.1399966519.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <paul.mundt@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Simon Horman <horms+renesas@verge.net.au>

Hi Linus,

Please consider this SH Driver Update for v3.15.

It consists of a single fix for a regression
introduced in v3.14 by bf98c1eac1d4a6bcf00532e4fa41d8126cd6c187.


This is my first pull-request to you for these drivers.

It is my understanding that previously the SH Drivers were maintained by
Paul Mundt as part of his maintenance of the SH architecture and Renesas
ARM Based SoCs. These days the SH architecture is orphaned and the Renesas
ARM Based SoCs are maintained by Magnus Damm and I.

Over the past year or so there have been very few updates to these drivers.
And the few that have been made have generally been taken by other
subsystem maintainers as part of larger patchsets. As this patch
does not fall into that category I would like you to consider pulling it.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-drivers-for-v3.15

for you to fetch changes up to 3c90c55dcde745bed81f6447f24ba96bda43d984:

  drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI (2014-05-12 16:05:01 +0900)

----------------------------------------------------------------
SH Driver Updates for v3.15

* Compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI

----------------------------------------------------------------
Geert Uytterhoeven (1):
      drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI

 drivers/Makefile        |  2 +-
 drivers/sh/Makefile     | 14 ++++++++------
 drivers/sh/pm_runtime.c | 20 +++++++++++++++++++-
 3 files changed, 28 insertions(+), 8 deletions(-)


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-drivers-for-v3.15

for you to fetch changes up to 3c90c55dcde745bed81f6447f24ba96bda43d984:

  drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI (2014-05-12 16:05:01 +0900)

----------------------------------------------------------------
SH Driver Update for v3.15

* Compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI

  This resolves a regression introduced in v3.14 by
  bf98c1eac1d4a6 ("ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY").

----------------------------------------------------------------
Geert Uytterhoeven (1):
      drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI

 drivers/Makefile        |  2 +-
 drivers/sh/Makefile     | 14 ++++++++------
 drivers/sh/pm_runtime.c | 20 +++++++++++++++++++-
 3 files changed, 28 insertions(+), 8 deletions(-)
