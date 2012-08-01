From: kuninori.morimoto.gx@renesas.com
Date: Wed, 01 Aug 2012 07:53:37 +0000
Subject: [PATCH 0/2] sh: enable USB host on CN5 port
Message-Id: <874nondp4x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

These patches enable USB Host on Ecovec CN5.
(these should have been resolved at the v3.3...)

Kuninori Morimoto (2):
      sh: sh7724: fixup renesas_usbhs clock settings
      sh: ecovec: care CN5 VBUS if USB host mode

 arch/sh/boards/mach-ecovec24/setup.c   |    8 ++++++++
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)
