From: Simon Horman <horms@verge.net.au>
Date: Wed, 31 Jul 2013 06:40:31 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7778 USB Func support
Message-Id: <20130731064029.GE5090@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87siyvb6e4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87siyvb6e4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 30, 2013 at 11:17:10PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> >  1 - 6 : r8a7778 cleanup patches
> >  7 - 8 : r8a7779 cleanup patches
> >  9     : BockW DT reference
> >  A - B : BockW USB Func support
> 
> These patches are A-B part v2 patches for r8a7778/BockW
> These are based on renesas-devel-20130731
> 
> Kuninori Morimoto (2):
>       ARM: shmobile: r8a7778: add usb phy power control function
>       ARM: shmobile: bockw: add USB Function support
> 
>  arch/arm/mach-shmobile/board-bockw.c          |   81 ++++++++++++++++++++++++-
>  arch/arm/mach-shmobile/clock-r8a7778.c        |    1 +
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 +
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   37 +++++++----
>  4 files changed, 107 insertions(+), 14 deletions(-)

Magnus, could you review these?
