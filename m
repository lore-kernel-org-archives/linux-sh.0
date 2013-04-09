From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 12:50:43 +0000
Subject: Re: [PATCH 0/6 v2] ARM: shmobile: r8a73a4: detailed clock topology support
Message-Id: <20130409125042.GF15412@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4ipk3rp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4ipk3rp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 04, 2013 at 09:19:57PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon, Magnus
> 
> These patches are v2 of r8a73a4 clock topology support.
> 
> These are tested on APE6EVM board,
> and based on renesas-next-20130404v2 tags
> 
> Kuninori Morimoto (5):
>       ARM: shmobile: r8a73a4: add main clock
>       ARM: shmobile: r8a73a4: add pll clocks
>       ARM: shmobile: r8a73a4: add div4 clocks
>       ARM: shmobile: r8a73a4: add div6 clocks
>       ARM: shmobile: ape6evm: MP clock parent become EXTAL2
> 
>  arch/arm/mach-shmobile/board-ape6evm.c |   15 ++
>  arch/arm/mach-shmobile/clock-r8a73a4.c |  375 ++++++++++++++++++++++++++++++--

Magnus, could you review these patches?
