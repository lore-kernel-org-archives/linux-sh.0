From: Simon Horman <horms@verge.net.au>
Date: Fri, 05 Apr 2013 01:55:36 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: R8A7778: add Ether support
Message-Id: <20130405015535.GX29203@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201304042255.46986.sergei.shtylyov@cogentembedded.com>
 <87wqshkbzr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqshkbzr.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 04, 2013 at 06:22:19PM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> > Add Ether clock and platform device for R8A7778 SoC; add a function to register
> > this device with board-specific platform data.
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > 
> > ---
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> > This patch is atop of the 'renesas-next-20130404v2' tag of Simon Horman's
> > 'renesas.git'.
> > 
> > Changes since original posting:
> > - use 'struct sh_eth_plat_data *' as an argument to r8a7778_add_ether_device();
> > - use platform_device_register_resndata() in r8a7778_add_ether_device().

Thanks, queued-up in the soc-r8a7778 branch.
