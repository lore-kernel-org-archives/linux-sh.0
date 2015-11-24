From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Nov 2015 02:55:28 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups
Message-Id: <20151124025527.GK21853@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446148654-20551-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1446148654-20551-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Sat, Oct 31, 2015 at 04:24:30PM +0900, Simon Horman wrote:
> On 金, 10月 30, 2015 at 09:11:49午前 +0100, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Fri, Oct 30, 2015 at 8:55 AM, Simon Horman <horms@verge.net.au> wrote:
> > > On Thu, Oct 29, 2015 at 08:57:34PM +0100, Geert Uytterhoeven wrote:
> > >> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > >>
> > >> Ensures that the pull-ups for pins SD0_CD and SD0_WP are enabled.
> > >>
> > >> This is one of two features from the DT reference platform that are
> > >> still missing in MP.
> > >>
> > >> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >> ---
> > >> The dependencies are now in pinctrl/for-next:
> > >> ae7465a0972aee88 pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
> > >> 22768fc60abbf58b pinctrl: sh-pfc: Add macros defining GP ports with config flags
> > >
> > > Am I correct in thinking that it is safe for me to apply this patch
> > > without those dependencies present in my dt-for-v4.5 branch?
> > 
> > Pinctrl may fail in that branch, and device probing may fail due to that
> > (still puzzled about when pinctrl failures are hard vs. soft).
> > But you will rebase the *-for-v4.5 branches on top of v4.4-rc1 later, right?
> > Then that problem will be resolved.
> 
> Ok. I think it would be best if I queued up these patches after I rebase
> dt-for-v4.5 on top of v4.4-rca (once the latter has been released). Could
> you repost this patch then?
> 
> > Note that not having this patch in v4.4 may be considered a regression
> > compared to bockw-legacy...
> 
> Understood.

I have now queued up the patch for v4.5.
