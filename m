From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Oct 2010 05:14:00 +0000
Subject: [PATCH 0/3] ARM: mach-shmobile: FSI clock patches
Message-Id: <w3pocaw11if.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3ppqvc11ij.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3ppqvc11ij.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

These are latest version of my FSIDIV clock support patches.

Kuninori Morimoto (3):
      ARM: mach-shmobile: clock-sh7372: add sh7372_ prefix to global clocks
      ARM: mach-shmobile: clock-sh7372: FSI parent select support
      ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock support

These are based on Paul's "sh_clk mapping" patch.
1st patch was required from Maguns.
This time, I don't send patch which adds HDMI sound support for AP4,
because I noticed that it is depend on ALSA git tree.
I will send it if it were merged

Best regards
--
Kuninori Morimoto
 
