From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 16 Dec 2014 09:11:22 +0000
Subject: Re: [PATCH 2/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <87k31s6jsh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod again

> > This rcar-audmapp driver is very limited usage, and user is only sound device/driver.
> > Sound driver configures both 1st/2nd DMAC if needed (it depends on platform).
> > Sound driver knows all reg address / mem address which are needed for 1st/2nd DMAC settings.
> > 1st/2nd DMAC needs general DMAEngine settings method, not special. 
> > Now, sound driver + 1st/2nd DMAC works well on my local environment.
> Are you not using the sound dmaengine library then, right?

Do you mean this ?

linux/sound/soc/soc-generic-dmaengine-pcm.c


Best regards
---
Kuninori Morimoto
