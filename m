From: Simon Horman <horms@verge.net.au>
Date: Tue, 11 Jun 2013 07:55:33 +0000
Subject: Re: [PATCH 0/6 v4] ARM: shmobile: r8a7778/bockw: add I2C/HSPI/MMC support
Message-Id: <20130611075531.GL10440@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9n65uti.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9n65uti.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 03, 2013 at 10:06:04PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > 1) - 2) are not SH patch but needed
> > 3) - 5) are pfc patches
> > 6) - 8) are r8a7778 patches
> > 9) - b) are bockw patches
> > c) - e) are defconfig patches
> > f) - h) are tidyup cleanup patches
> 
> These patches are part of 6) - 8) v4 I2C/HSPI/MMC support for r8a7778.
> I separated these into "clock support" and "driver support" patches.
> 
> These patches are based on renesas-next-20130528 tag
> 
> 1) - 3) are clock support patches
> 4) - 6) are driver support patches
> 
> Kuninori Morimoto (6):
>       1) ARM: shmobile: r8a7778: add support I2C clock
>       2) ARM: shmobile: r8a7778: add support HSPI clock
>       3) ARM: shmobile: r8a7778: add support MMC clock
>       4) ARM: shmobile: r8a7778: add support I2C driver
>       5) ARM: shmobile: r8a7778: add support HSPI driver
>       6) ARM: shmobile: r8a7778: add support MMC driver
> 
>  arch/arm/mach-shmobile/clock-r8a7778.c        |   23 +++++++++-
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |    5 ++
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   61 +++++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 1 deletion(-)

Thanks, I have queued this up in the soc2 branch.
My current plan is to let that branch sit in next for a few
days and then send a pull-request for it to be included in v3.11.
