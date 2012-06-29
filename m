From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 29 Jun 2012 02:18:51 +0000
Subject: Re: [PATCH][rework] ARM: shmobile: patch set rework
Message-Id: <874npuamif.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hatzlm7x.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael

> Sorry to say that, but it totally doesn't work for me.
> 
> I'd prefer it to be a single patch series organized so that:
> (1) Patches that multiple SoCs depend on go first
>     (e.g. "ARM: shmobile: add common extra gpio functions" above).
> (2) Patches that only one SoC depends on, but that touch files common to
>     multiple boards go next
>     (e.g. "ARM: shmobile: use common DMAEngine definitions on r8a7740" above).
> (3) Patches that touch only one individual board go last
>     (e.g. "ARM: shmobile: use common extra gpio functions on mackrel" above).

OK.
My understanding is

(1) -> for rafael/soc					=> rafael/soc'
(2) -> for rafael/r8a7740	+ rafael/soc'		=> rafael/r8a7740'
    -> for rafael/sh73a0	+ rafael/soc'		=> rafael/sh73a0'
(3) -> for rafael/armadillo	+ rafael/r8a7740'	=> rafael/armadillo'
    -> for rafael/kzm9g		+ rafael/sh73a0'	=> rafael/kzm9g' 

Is this correct ?

If so, v2 patch set will be...

------- for rafael/soc ----------------------------------
Kuninori Morimoto (1):
      [PATCH 1/1] ARM: shmobile: shareing extra gpio setting functions

 arch/arm/mach-shmobile/board-ap4evb.c      |   19 +--------------
 arch/arm/mach-shmobile/board-g4evm.c       |   18 ---------------
 arch/arm/mach-shmobile/board-mackerel.c    |   30 +------------------------
 arch/arm/mach-shmobile/include/mach/gpio.h |   32 ++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 63 deletions(-)

------- for rafael/soc ----------------------------------
Kuninori Morimoto (3):
      [PATCH 1/3] ARM: shmobile: shareing DMAEngine definitions
      [PATCH 2/3] ARM: shmobile: shareing DMAEngine TS_HI/LOW value
      [PATCH 3/3] ARM: shmobile: shareing DMAEngine USBTS_HI/LOW value

 arch/arm/mach-shmobile/include/mach/dma-register.h |   84 +++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c              |  131 +++++++-------------
 arch/arm/mach-shmobile/setup-sh73a0.c              |   41 +-----
 3 files changed, 138 insertions(+), 118 deletions(-)

------- for rafael/r8a7740 ----------------------------------
Kuninori Morimoto (3):
      [PATCH 1/3] ARM: shmobile: r8a7740: add DMAEngine support for FSI
      [PATCH 2/3] ARM: shmobile: r8a7740: add DMAEngine support for SDHI
      [PATCH 3/3] ARM: shmobile: r8a7740: add DMAEngine support for USB

 arch/arm/mach-shmobile/clock-r8a7740.c        |   10 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h |   16 ++
 arch/arm/mach-shmobile/setup-r8a7740.c        |  273 +++++++++++++++++++++++++
 3 files changed, 298 insertions(+), 1 deletions(-)

------- for rafael/sh73a0 ----------------------------------
Kuninori Morimoto (2):
      [PATCH 1/2] ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
      [PATCH 2/2] ARM: shmobile: sh73a0: add USB clock support

 arch/arm/mach-shmobile/clock-sh73a0.c        |    8 ++-
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    7 ++
 arch/arm/mach-shmobile/setup-sh73a0.c        |  111 ++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 2 deletions(-)

------- for rafael/armadillo ----------------------------------
Kuninori Morimoto (5):
      [PATCH 1/5] ARM: shmobile: armadillo800eva: enable FSI-WM8978 sound
      [PATCH 2/5] ARM: shmobile: armadillo800eva: enable FSI-HDMI sound
      [PATCH 3/5] ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
      [PATCH 4/5] ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
      [PATCH 5/5] ARM: shmobile: armadillo800eva: enable DMAEngine on USB

 arch/arm/configs/armadillo800eva_defconfig     |    2 +
 arch/arm/mach-shmobile/Kconfig                 |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |  175 +++++++++++++++++++++++-
 3 files changed, 175 insertions(+), 3 deletions(-)

------- for rafael/kzm9g ----------------------------------
Kuninori Morimoto (4):
      [PATCH 1/4] ARM: shmobile: kzm9g: enable DMAEngine on FSI
      [PATCH 2/4] ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
      [PATCH 3/4] ARM: shmobile: kzm9g: enable USB func
      [PATCH 4/4] ARM: shmobile: kzm9g: enable MicroSD

 arch/arm/configs/kzm9g_defconfig     |    5 +
 arch/arm/mach-shmobile/board-kzm9g.c |  208 ++++++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+), 0 deletions(-)

Best regards
---
Kuninori Morimoto
