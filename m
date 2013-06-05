From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Jun 2013 02:03:35 +0000
Subject: Re: [PATCH 3/3 v3] ARM: shmobile: bockw: add SDHI0 support
Message-Id: <20130605020334.GD16849@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738uwpavc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738uwpavc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Tue, Jun 04, 2013 at 05:48:18PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for your reply
> 
> > > > This patch is directly accessing to PUPR4 register which can
> > > > control SDHI0 CD/WP pin pull-up setting.
> > > > It should be replaced in the future.
> > > > 
> > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > ---
> (snip)
> > 
> > I have dropped this patch as it currently seems to be causing a build failure.
> > Please resolve this and re-post.
> > 
> >   CC      arch/arm/mach-shmobile/board-bockw.o
> > arch/arm/mach-shmobile/board-bockw.c:60: error: variable ‘sdhi0_info’ has initializer but incomplete type
> > arch/arm/mach-shmobile/board-bockw.c:61: error: unknown field ‘tmio_caps’ specified in initializer
> > arch/arm/mach-shmobile/board-bockw.c:61: warning: excess elements in struct initializer
> > arch/arm/mach-shmobile/board-bockw.c:61: warning: (near initialization for ‘sdhi0_info’)
> > arch/arm/mach-shmobile/board-bockw.c:62: error: unknown field ‘tmio_ocr_mask’ specified in initializer
> > arch/arm/mach-shmobile/board-bockw.c:62: warning: excess elements in struct initializer
> > arch/arm/mach-shmobile/board-bockw.c:62: warning: (near initialization for ‘sdhi0_info’)
> > arch/arm/mach-shmobile/board-bockw.c:63: error: unknown field ‘tmio_flags’ specified in initializer
> > arch/arm/mach-shmobile/board-bockw.c:63: warning: excess elements in struct initializer
> > arch/arm/mach-shmobile/board-bockw.c:63: warning: (near initialization for ‘sdhi0_info’)
> > arch/arm/mach-shmobile/board-bockw.c: In function ‘bockw_init’:
> > arch/arm/mach-shmobile/board-bockw.c:134: error: implicit declaration of function ‘r8a7778_sdhi_init’
> 
> Hmm... strange.
> I couldn't get this error/warning.
> I used renesas-next-20130604v2 + above patch,
> but no error

Thanks.

The problem that I was seeing was that I was missing some SoC patches.
I have resolved that and re-queued-up your patch
