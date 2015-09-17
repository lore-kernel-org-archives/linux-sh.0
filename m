From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Sep 2015 09:00:28 +0000
Subject: [GIT PULL] SH Drivers Updates for v4.3
Message-Id: <cover.1442480237.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms+renesas@verge.net.au>

Hi Linus,

Please consider these SH drivers updates for v4.3.

I am sending this change after v4.3-rc1 has been released
as it depends on SoC changes which are present in that rc release.


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh-drivers-for-v4.3

for you to fetch changes up to cbc41d0a761bffb3166a413a3c77100a737c0cd7:

  drivers: sh: Disable PM runtime for multi-platform ARM with genpd (2015-09-14 10:20:23 +0900)

----------------------------------------------------------------
SH Drivers Updates for v4.3

* Disable PM runtime for multi-platform ARM with genpd
* Disable legacy default PM Domain on emev2

----------------------------------------------------------------
Geert Uytterhoeven (2):
      drivers: sh: Disable legacy default PM Domain on emev2
      drivers: sh: Disable PM runtime for multi-platform ARM with genpd

 drivers/sh/pm_runtime.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)
