From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Sep 2011 01:29:58 +0000
Subject: R-Mobile A1 support
Message-Id: <87bou4qgof.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Magnus

These are basic R-Mobile A1 chip and bonito board support patches

Kuninori Morimoto (5):
      serial: sh-sci: clean up white space
      ARM: mach-shmobile: R-Mobile A1 support.
      ARM: mach-shmobile: bonito: Add dip-switch selector
      ARM: mach-shmobile: r8a7740: Add i2c support
      ARM: mach-shmobile: bonito: add PMIC settings

This patch used xxx-r8a7740.c as file name.
This A1 chip support is based on v0.1 manual for now.
It will be fixed in the future

Best regards
---
Kuninori Morimoto
