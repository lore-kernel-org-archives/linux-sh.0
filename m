From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jun 2012 09:59:41 +0000
Subject: Re: [PATCH 26/27] ARM: shmobile: kzm9g: enable FSI-AK4648
Message-Id: <87ehpmp3sm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lijupkh8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lijupkh8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for checking patch

> On Sun, Jun 10, 2012 at 08:59:19PM -0700, Kuninori Morimoto wrote:
> > This patch enable sound playback/capture on CN9/CN10.
> 
> This, or possibly a previous patch, seems to have the following
> dependencies. I am using the next branch of Rafael's renesas tree
> which is based on v3.4-rc6.
> 
> cd04461 ASoC: sh: fsi: select simple-card on Kconfig
> f239088 ASoC: add generic simple-card support

Yes.
These patch set are based on latest linus/master tree.
Above patches are already included

Best regards
---
Kuninori Morimoto
