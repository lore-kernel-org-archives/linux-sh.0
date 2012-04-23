From: kuninori.morimoto.gx@renesas.com
Date: Mon, 23 Apr 2012 06:52:02 +0000
Subject: ARM: mach-shmobile: incremental KZM-A9-GT board support
Message-Id: <87bomj9bzl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon

These are incremental KZM-A9-GT board support patches.
These are based on "ARM: mach-shmobile: add KZM-A9-GT board support" patch series

Kuninori Morimoto (6):
      ARM: mach-shmobile: pfc-sh73a0: fixup MSEL2CR MSEL18 for I2C-3
      ARM: mach-shmobile: sh73a0.h: add GPIO_NR
      ARM: mach-shmobile: kzm9g: correct screen direction
      ARM: mach-shmobile: kzm9g: add MMCIF support
      ARM: mach-shmobile: kzm9g: add SDHI support
      ARM: mach-shmobile: kzm9g: add PCF8757 gpio-key

#1 is bugfix patch for I2C-3.
#1, #2 are required by #6 patch.

