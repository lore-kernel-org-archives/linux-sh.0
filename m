From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 28 Jun 2012 01:27:47 +0000
Subject: Re: [PATCH 0/1][RFC] ARM: shmobile: r8a7740: basic PM domain support
Message-Id: <87ipec9qen.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw9jlm4q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw9jlm4q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus

> In general I think it looks good for a V1, but I wonder about upcoming
> patches for PM domain support for board-specific devices on the
> Armadillo board. Do you have any other Armadillo-specific patch that
> for instance hooks up the board specific LCDC device to the correct
> power domain?
> 
> I recommend you to test during runtime with subsystem specific
> interfaces - not only suspend-to-RAM. As an example, I believe the
> LCDC can be powered on and off using some fbdev specific "blanking"
> file in sysfs.

OK. now I created the incremental patches which enable USB/LCDC PM domain.
Can I send these patches ? or should I wait until Rafael's tree became update ?

Best regards
---
Kuninori Morimoto
