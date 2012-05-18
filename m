From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 18 May 2012 21:55:47 +0000
Subject: [GIT PULL] Renesas Emma Mobile EV2 SoC and KZM9D board support for v3.5
Message-Id: <201205182355.47754.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201205182344.59703.rjw@sisk.pl>
In-Reply-To: <201205182344.59703.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3

    Linux 3.4-rc6

with top-most commit 450cca47d65b7500ba05d56770adbf8c758dc87d

    mach-shmobile: Use DT_MACHINE for KZM9D V3

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git emev2

to receive commits adding support for the Emma Mobile EV2 SoC and the KZM9D
board targeted at v3.5.

This is based on material that I have just sent another pull request for.

Thanks!


 arch/arm/boot/dts/emev2-kzm9d.dts           |   26 ++
 arch/arm/boot/dts/emev2.dtsi                |   63 ++++
 arch/arm/mach-shmobile/Kconfig              |   11 +
 arch/arm/mach-shmobile/Makefile             |    3 +
 arch/arm/mach-shmobile/board-kzm9d.c        |   85 +++++
 arch/arm/mach-shmobile/clock-emev2.c        |  249 +++++++++++++++
 arch/arm/mach-shmobile/include/mach/emev2.h |   19 ++
 arch/arm/mach-shmobile/platsmp.c            |   18 +
 arch/arm/mach-shmobile/setup-emev2.c        |  452 +++++++++++++++++++++++++++
 arch/arm/mach-shmobile/smp-emev2.c          |   97 ++++++
 drivers/gpio/Kconfig                        |    6 +
 drivers/gpio/Makefile                       |    1 +
 drivers/gpio/gpio-em.c                      |  418 +++++++++++++++++++++++++
 include/linux/platform_data/gpio-em.h       |   10 +
 14 files changed, 1458 insertions(+), 0 deletions(-)

---------------

Magnus Damm (8):
      gpio: Emma Mobile GPIO driver V2
      mach-shmobile: Emma Mobile EV2 SoC base support V3
      mach-shmobile: KZM9D board support V3
      mach-shmobile: Emma Mobile EV2 SMP support V3
      mach-shmobile: Emma Mobile EV2 GPIO support V3
      mach-shmobile: KZM9D board Ethernet support V3
      mach-shmobile: Emma Mobile EV2 DT support V3
      mach-shmobile: Use DT_MACHINE for KZM9D V3


