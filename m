From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Dec 2013 02:14:34 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: r8a7790: add sound clock support
Message-Id: <87haasc83c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3fr52r4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3fr52r4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> On Thursday 28 November 2013 19:02:42 Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Could you please split this in a patch that adds the MSTP clocks and a patch 
> that adds the audio_clk inputs ? The reason for that is that I believe the 
> first patch can be applied now, but the second will also need a CCF 
> implementation.

OK, I see.
But, I will re-send MSTP part only at this point.

Best regards
---
Kuninori Morimoto
