From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 02 Jun 2010 08:24:01 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: evt2irq() update for MMCIF
Message-Id: <20100602082401.GC19079@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39x7earf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p39x7earf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 01, 2010 at 11:40:05AM +0900, Kuninori Morimoto wrote:
> This patch updates the irq numbers for MMCIF
> to make use of evt2irq().

On Tue, Jun 01, 2010 at 11:40:32AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-sh7372.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

On Tue, Jun 01, 2010 at 01:31:29PM +0900, Kuninori Morimoto wrote:
> MMC0/SDHI1 (CN7) can be selected by dip switch.
> And card voltage can be selected by jumper pin.

On Wed, Jun 02, 2010 at 09:24:33AM +0900, Kuninori Morimoto wrote:
>       ARM: mach-shmobile: make sure static declaration on ap4evb
>       ARM: mach-shmobile: make sure static declaration on g4evm
>       ARM: mach-shmobile: make sure static declaration on g3evm

On Wed, Jun 02, 2010 at 09:27:15AM +0900, Kuninori Morimoto wrote:
>       sh: make sure static declaration on mach-ap325rxa
>       sh: make sure static declaration on mach-ecovec24
>       sh: make sure static declaration on mach-migor
>       sh: make sure static declaration on ms7724se

All applied, thanks.
