From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Apr 2015 05:17:34 +0000
Subject: [GIT PULL] SH Drivers Updates for v4.1
Message-Id: <cover.1430370969.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>

Hi Linus,

Please consider these SH drivers updates for v4.1.

I am sending this change after v4.1-rc1 has been released
as it depends on SoC changes which are present in that rc release.


The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-drivers-for-v4.1

for you to fetch changes up to 00170528f0486c08a18475af7fefa0a7679e042d:

  drivers: sh: Remove test for now unsupported sh7372 (2015-04-27 13:08:14 +0900)

----------------------------------------------------------------
SH Drivers Updates for v4.1

* Remove test for now unsupported sh7372 SoC
* Disable PM runtime for multi-platform r8a73a4 and sh73a0 SoCs with genpd

----------------------------------------------------------------
Geert Uytterhoeven (3):
      drivers: sh: Disable PM runtime for multi-platform sh73a0 with genpd
      drivers: sh: Disable PM runtime for multi-platform r8a73a4 with genpd
      drivers: sh: Remove test for now unsupported sh7372

 drivers/sh/pm_runtime.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
