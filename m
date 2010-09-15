From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Sep 2010 06:37:19 +0000
Subject: [PATCH 0/2] FSI clock patches
Message-Id: <w3pfwxbwm01.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Magnus, Guennadi

These patches are for FSI parent select support on clock frame work

Kuninori Morimoto (2):
      ARM: mach-shmobile: modify wrong array size of div6_reparent_clks
      ARM: mach-shmobile: clock-sh7372: FSI parent select support

1st patch is just bug fix.
I need some comment/advice in 2nd patch

2nd patch is 1st step to add FSIDIV support
which is needed for HDMI sound support

Best regards
--
Kuninori Morimoto
 
