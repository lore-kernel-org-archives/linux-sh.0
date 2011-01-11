From: Simon Horman <horms@verge.net.au>
Date: Tue, 11 Jan 2011 02:51:50 +0000
Subject: Re: [PATCH] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Message-Id: <20110111025148.GA5532@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110110230549.GA20886@verge.net.au>
In-Reply-To: <20110110230549.GA20886@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 11, 2011 at 11:07:51AM +0900, Paul Mundt wrote:
> On Tue, Jan 11, 2011 at 08:05:49AM +0900, Simon Horman wrote:
> > Allow MMCIF_PROGRESS_* to be shared.
> > 
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> > ---
> >  arch/sh/boot/romimage/mmcif-sh7724.c |    3 ---
> >  include/linux/mmc/sh_mmcif.h         |    3 +++
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > Hi Paul,
> > 
> > this change didn't seem to make it into your
> > rc1 pull request, although it is present in
> > remotes/sh-2.6/common/mmcif.
> > 
> Blast. I thought I had all of the common/mmcif stuff rolled in via
> rmobile/mmcif, but it seems this one slipped by. I'll make sure it gets
> merged this time around.
> 
> > It is needed by "[patch v5] mmc, ARM: Add zboot from MMC support for SuperH
> > Mobile ARM", which I was hoping to get Russell to merge post 2.6.38-rc1.
> > Perhaps I should just add the enums directly to
> > arch/arm/boot/compressed/mmcif-sh7372.c in that patch for now?
> > 
> Optionally you can just push it out without the enums resolved also, the
> build target will just fail until the other patch catches up.

Ok, I guess that sounds reasonable. Its not like many people/anyone will have
the config option enabled while the merge is shaking itself out.

