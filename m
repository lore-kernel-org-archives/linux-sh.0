From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 27 Apr 2012 02:15:02 +0000
Subject: Re: [PATCH 1/8] ARM: mach-shmobile: clock-r8a7740: add USB clock
Message-Id: <20120427021501.GC7988@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87aa21fqg0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aa21fqg0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 24, 2012 at 02:07:47AM -0700, Kuninori Morimoto wrote:
> R8A7740 USB needs many clocks for workaround,
> and it has confusing name "usb24s" and "usb24".
> This "usb24s" will be used by other clocks.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c |  118 +++++++++++++++++++++++++++++++-
>  1 files changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index 99c4d74..30535f4 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> +static unsigned long usb24s_recalc(struct clk *clk)
> +{
> +	return clk->parent->rate;
> +};
> +
You don't need this, just use followparent_recalc() directly.
