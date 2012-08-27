From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Aug 2012 08:22:59 +0000
Subject: Re: [PATCH 0/2 v2] Add SDHI to Marzen board
Message-Id: <20120827082257.GA29274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1344256265-9802-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1344256265-9802-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 06, 2012 at 07:12:02PM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> > Phil Edworthy (2):
> >   r8a7779: add SDHI clock support
> >   marzen: add SDHI0 support
> > 
> >  arch/arm/configs/marzen_defconfig      |    4 +-
> >  arch/arm/mach-shmobile/board-marzen.c  |   52 +++++++++++++++++++++++++++++++-
> >  arch/arm/mach-shmobile/clock-r8a7779.c |   11 ++++++-
> >  3 files changed, 63 insertions(+), 4 deletions(-)
> 
> It works well
> 
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks.

I had previously pushed an old version of this patchest,
but I have now forcibly pushed this version to the
marzen branch of my renesas tree,
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
