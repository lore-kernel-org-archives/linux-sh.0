From: Simon Horman <horms@verge.net.au>
Date: Mon, 01 Oct 2012 00:03:29 +0000
Subject: Re: [GIT PULL] Renesas ARM-based SoC: KZM-9A-GT for 3.7
Message-Id: <20121001000329.GA3888@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346113116-20252-1-git-send-email-horms@verge.net.au>
 <201209282002.28445.arnd@arndb.de>
In-Reply-To: <201209282002.28445.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Sep 28, 2012 at 08:02:28PM +0000, Arnd Bergmann wrote:
> On Tuesday 28 August 2012, Simon Horman wrote:
> > ----------------------------------------------------------------
> > Tetsuyuki Kobayashi (1):
> >       ARM: shmobile: kzm9g: enable restarting
> > 
> >  arch/arm/mach-shmobile/board-kzm9g.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> This patch ended up causing a new build warning in combination
> with the io.h changes in Russell's tree.
> 
> I've just applied this patch on top, which is the same thing we
> did to all the other open-coded mmio locations.

Thanks, sorry for missing that.
