From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Nov 2013 01:53:21 +0000
Subject: Re: [PATCH 0/16] ARM: shmobile: SDHI support for r8a7790
Message-Id: <87a9h6o2gi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>
Cc: Laurent <laurent.pinchart@ideasonboard.com>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Simon

These are v2 of SDHI support for r8a7790.

Kuninori Morimoto (2):
      ARM: shmobile: lager: add gpio/fixed regulator for SDHI
      ARM: shmobile: lager: add SDHI0/2 support

 arch/arm/mach-shmobile/board-lager.c |  149 +++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)
