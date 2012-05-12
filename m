From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 12 May 2012 21:18:01 +0000
Subject: [GIT PULL] Renesas ARM-based platforms: board support updates for v3.5
Message-Id: <201205122318.01634.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201205122307.20590.rjw@sisk.pl>
In-Reply-To: <201205122307.20590.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3

    Linux 3.4-rc6

with top-most commit 8823e2b38bd0ee45346ebd3613f47ddb2a3a208a

    ARM: mach-shmobile: bonito: make sure static function

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git board

to receive updates of the Renesas ARM-based boards support code for v3.5.
Included are:

 * FSI DMAEngine support for the Mackerel board from Kuninori Morimoto.

 * sh7372 CEU extension for the Mackere and AP4EVB boards from Guennadi
   Liakhovetski.

 * Bonito board code fix from Kuninori Morimoto.

This is based on the Renesas core SoC code updates I've sent a separate pull
request for.

Thanks!


 arch/arm/mach-shmobile/board-ap4evb.c   |    2 ++
 arch/arm/mach-shmobile/board-bonito.c   |    2 +-
 arch/arm/mach-shmobile/board-mackerel.c |   10 ++++++++--
 3 files changed, 11 insertions(+), 3 deletions(-)

---------------

Guennadi Liakhovetski (1):
      ARM: mach-shmobile: sh7372 CEU supports up to 8188x8188 images

Kuninori Morimoto (2):
      ARM: mach-shmobile: mackerel: Add FSI DMAEngine support
      ARM: mach-shmobile: bonito: make sure static function


