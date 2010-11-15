From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Nov 2010 05:43:40 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ap4evb: add fsib 44100Hz rate
Message-Id: <20101115054340.GC8489@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 15, 2010 at 12:11:09PM +0900, Kuninori Morimoto wrote:
> Tested-by: Tony SIM <chinyeow.sim.xt@renesas.com>
> Tested-by: TAKEI Mitsuharu <takei.andr@gmail.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-ap4evb.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index 63c2fca..5c14c73 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -582,7 +582,14 @@ static int fsi_set_rate(int is_porta, int rate)
>  	if (IS_ERR(fsib_clk))
>  		return -EINVAL;
>  
> +	while (fdiv_clk->usecount)
> +		clk_disable(fdiv_clk);
> +

Uhm, no.  Whatever this thinks its doing, is horribly, horribly wrong. 

The refcount exists for a reason. If your driver wants to change the
rate, then it can drop the usecount itself and give it a go. If that
fails, then that means that some other driver also has a handle on the
same clock, and simply changing the rate underneath it is precisely the
sort of thing that the refcounting exists to prevent!

>  	switch (rate) {
> +	case 44100:
> +		clk_set_rate(fsib_clk, clk_round_rate(fsib_clk, 11283000));
> +		ret = SH_FSI_ACKMD_256 | SH_FSI_BPFMD_64;
> +		break;

This part looks fine, and I'll apply it, while pretending like I never
saw the first part.

When you fix your driver to get the refcounting right, feel free to
submit a follow-up patch for that.
