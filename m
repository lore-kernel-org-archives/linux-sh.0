From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 20 Nov 2015 00:39:09 +0000
Subject: [GIT PULL] SH Drivers Updates for v4.4
Message-Id: <cover.1447979812.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>

Hi Linus,

Please consider these SH drivers updates for v4.4.

I am sending this change after v4.4-rc1 has been released
as it depends on SoC changes which are present in that rc release.


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-drivers-for-v4.4

for you to fetch changes up to 0ba58de231066e47de87ccc4d61c5e396fe9bd27:

  drivers: sh: Get rid of CONFIG_ARCH_SHMOBILE_MULTI (2015-11-17 02:12:46 +0900)

----------------------------------------------------------------
SH Drivers Updates for v4.4

* Remove now unnecessary reference to CONFIG_ARCH_SHMOBILE_MULTI

----------------------------------------------------------------
Geert Uytterhoeven (1):
      drivers: sh: Get rid of CONFIG_ARCH_SHMOBILE_MULTI

 drivers/sh/pm_runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
