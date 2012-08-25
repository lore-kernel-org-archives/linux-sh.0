From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 Aug 2012 06:46:10 +0000
Subject: Re: [PATCH 0/2] Armadillo 800 EVA GPIO buttons fixes
Message-Id: <20120825064609.GF29755@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1343136369-14636-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1343136369-14636-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 24, 2012 at 04:49:29PM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> > Here are two small patches for the Armadillo 800 EVA GPIO buttons. The first
> > one is mostly cosmetic, it renames the buttons to match the names printed on
> > the board. The second patch adds support for waking up the system using the
> > power GPIO button.
> > 
> > Laurent Pinchart (2):
> >   ARM: mach-shmobile: armadillo800eva: Fix GPIO buttons descriptions
> >   ARM: mach-shmobile: armadillo800eva: Enable power button as wakeup
> >     source
> > 
> >  arch/arm/mach-shmobile/board-armadillo800eva.c |   11 ++++++-----
> >  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> Both patches
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Laurent,

This patches look good to me too. I have queued them up in the
armadillo800eva branch of my renesas tree,
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

I will endeavour to get it included in 3.7.
