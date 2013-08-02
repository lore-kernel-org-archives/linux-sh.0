From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 01:01:59 +0000
Subject: Re: [PATCH 0/2 v3] ARM: shmobile: r8a7778 USB Func support
Message-Id: <8738qsaosb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

>  1 - 6 : r8a7778 cleanup patches
>  7 - 8 : r8a7779 cleanup patches
>  9     : BockW DT reference
>  A - B : BockW USB Func support

These patches are A-B part v3 patches for r8a7778/BockW
These are based on renesas-devel-20130801v2

Kuninori Morimoto (3):
      ARM: shmobile: r8a7778: add usb phy power control function
      ARM: shmobile: r8a7778: add USB Function clock
      ARM: shmobile: bockw: add USB Function support

 arch/arm/mach-shmobile/board-bockw.c          |   81 ++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7778.c        |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |   37 +++++++----
 4 files changed, 107 insertions(+), 14 deletions(-)
