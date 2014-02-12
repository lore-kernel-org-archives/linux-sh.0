From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 12 Feb 2014 06:23:40 +0000
Subject: Re: [PATCH 0/2 v2]: ARM: shmobile: lager: add SDHI0/2 support for legacy/DT
Message-Id: <87y51g97di.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon
Cc Magnus

These are v2 patch of SDHI0/2 support for Lager.
#1 is same one, #2 patch was updated

Kuninori Morimoto (2):
      ARM: shmobile: lager: add SDHI0/2 support
      ARM: shmobile: lager: add SDHI0/2 support on DTS

 arch/arm/boot/dts/r8a7790-lager.dts  |   84 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager.c |   64 ++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)
