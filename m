From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Apr 2013 06:26:05 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: r8a73a4: detailed clock topology support
Message-Id: <20130404062603.GO28297@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo9x5h1h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo9x5h1h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 02, 2013 at 04:05:35AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon, Magnus
> 
> These patches adds detailed r8a73a4 clock topology support.
> These patches are tested on APE6EVM board.
> 
> Kuninori Morimoto (6):
>       clk: sh: add sh_clk_reparent_register()
>       ARM: shmobile: r8a73a4: add main clock
>       ARM: shmobile: r8a73a4: add pll clocks
>       ARM: shmobile: r8a73a4: add div4 clocks
>       ARM: shmobile: r8a73a4: add div6 clocks
>       ARM: shmobile: ape6evm: MP clock parent become EXTAL2

These seem sane to me.

Magnus, can I get a review from you?
