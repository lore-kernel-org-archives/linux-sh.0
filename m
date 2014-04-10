From: Simon Horman <horms@verge.net.au>
Date: Thu, 10 Apr 2014 23:22:00 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: r8a7778/r8a7790: sound DT support
Message-Id: <20140410232157.GD4358@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ior2dhp9.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ior2dhp9.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 24, 2014 at 09:35:56PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These patches adds sound DT support on r8a7778/r8a7790.
> But, r8a7778 can't use it at this point,
> since it doesn't support CCF.
> 
> These patches are based on...
> 
>      1) Simon's renesas-devel-v3.14-rc7-20140324
>      2) Mark's  asoc/topic/rcar
>      3) Mark's  asoc/topic/simple
>      4) Mark's  asoc/fix/rcar
>      5) my previous patches
> 
> Kuninori Morimoto (7):
>       ARM: shmobile: r8a7790: add MSTP10 support on DTSI
>       ARM: shmobile: r8a7790: add R-Car sound support on DTSI
>       ARM: shmobile: r8a7778: add R-Car sound support on DTSI
>       ARM: shmobile: lager: enable sound codec for DT
>       ARM: shmobile: bockw: enable sound codec for DT
>       ARM: shmobile: lager: add R-Car sound support on DTS
>       ARM: shmobile: bockw: add R-Car sound support on DTS

Hi Morimoto-san,

as usual with DT patches. Please repost these once
all the dependencies have been merged. If there are
no-compile time dependencies then its sufficient for
the maintainer (Mark?) to have accepted them and I
can merge the DT bits for shmobile in parallel.
