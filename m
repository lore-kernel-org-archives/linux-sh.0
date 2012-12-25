From: Simon Horman <horms@verge.net.au>
Date: Tue, 25 Dec 2012 23:25:40 +0000
Subject: Re: [PATCH 0/4] ARM/sh: add sample amixer settings for FSI-codec
Message-Id: <20121225232521.GE12379@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4me7p8k.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4me7p8k.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 24, 2012 at 08:03:10PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon, Paul
> 
> These patches add sample amixer settings for sound on comment area.
> Sound doesn't work without these puzzling settings
> 
> Kuninori Morimoto (4):
>       ARM: shmobile: fix sample amixer settings for mackerel
>       ARM: shmobile: add sample amixer settings for ap4evb
>       ARM: shmobile: add sample amixer settings for armadillo800eva
>       sh: ecovec: add sample amixer settings

Thanks, I have added the three "ARM: shmobile" patches to the
boards branch of the renesas tree on kernel.org which I have
rebased on v3.8-rc1.

The patches are also present in the next branch.
