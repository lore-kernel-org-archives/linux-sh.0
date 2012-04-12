From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Apr 2012 08:25:59 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <20120412082557.GB26803@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 06, 2012 at 01:26:54AM -0700, kuninori.morimoto.gx@renesas.com wrote:
> 
> Hi Rafael, Magnus
> Cc Simon, nakai-san, Saneyoshi-san
> 
> These are v2 of basic R8A7740 A1 Armadillo800eva baord support patch set.
> These are based on linus/master branch.
> 
> Kuninori Morimoto (7):
>       ARM: mach-shmobile: pfc-r8a7740: add gpio_irq support
>       ARM: mach-shmobile: add armadillo800eva board support.
>       ARM: mach-shmobile: armadillo800eva: add defconfig
>       ARM: mach-shmobile: armadillo800eva: add support LCDC0
>       ARM: mach-shmobile: armadillo800eva: add support ST1232
>       ARM: mach-shmobile: armadillo800eva: add support gpio_key
>       ARM: mach-shmobile: armadillo800eva: add support sh_eth

I have tested all of the patches above, except
"ARM: mach-shmobile: armadillo800eva: add support ST1232",
against 3.4-rc2. For those six patches:

	Tested-by: Simon Horman <horms@verge.net.au>

I have also booted a kernel with "ARM: mach-shmobile: armadillo800eva: add
support ST1232", however I am unable to exercise this code as I am having
trouble bringing up an Android user-space. Tips on how the code might
be exercised would be greatly. appreciated.
