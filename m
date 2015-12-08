From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Dec 2015 02:00:50 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: tidyup #sound-dai-cells settings
Message-Id: <20151208020046.GB20031@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449505537-15428-1-git-send-email-geert+renesas@glider.be>
 <878u557qff.wl%kuninori.morimoto.gx@renesas.com>
 <20151208003724.GG10799@verge.net.au>
 <874mft7mrh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874mft7mrh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Dec 08, 2015 at 01:30:12AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Renesas sound driver needs #sound-dai-cells settings, but, this usage
> > > is a little bit confusable. It came from ALSA SoC historical reasons.
> > > The sound DAI naming method is different between Single/Multi DAI in
> > > the ALSA framework, and it is used for sound card matching.
> > > And this #sound-dai-cells has relationship to it.
> > > Current SoC dtsi has #sound-dai-cells = <1> as default settings
> > > (= it is assuming that board/platform has multi DAI), and
> > > board/platform side needs to overwrite it if board/platform was single
> > > DAI. This style is more confusable for users.
> > > This patch removes SoC side default settings, and force to set it by
> > > board/platform side.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > This patch is based on Geert's
> > > ARM: shmobile: bockw dts: Override #sound-dai-cells to zero
> > 
> > Is Geert's patch necessary with this patch?
> 
> I think best order (for git bisect) is
> 
> 	1. Geert's patch
> 	2. My patch

Thanks, I will make it so.
