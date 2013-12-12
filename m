From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Dec 2013 12:08:22 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: kzm9g: add FSI sound support for DT
Message-Id: <20131212120820.GD18308@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9ggqe1a.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87a9ggqe1a.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 04, 2013 at 05:31:41PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> ALSA SoC supports simple-audio-card via DT now
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git :: topic/dt
> 
> These pathes adds FSI-AK4648 sound support for kzm9g.
> 
> Kuninori Morimoto (3):
>       ARM: shmobile: sh73a0: add FSI clock support for DT
>       ARM: shmobile: sh73a0: add FSI support via DTSI
>       ARM: shmobile: kzm9g: add FSI support for DTS
> 
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   33 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/sh73a0.dtsi                |    9 +++++++
>  arch/arm/mach-shmobile/clock-sh73a0.c        |    1 +
>  3 files changed, 43 insertions(+)

Thanks. I will queue these up.
