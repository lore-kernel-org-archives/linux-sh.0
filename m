From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 13 Apr 2009 21:34:47 +0000
Subject: Re: [Review request] sh-sci clock
Message-Id: <20090413213447.GC14847@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ur5zxgnmk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 13, 2009 at 01:17:59PM +0900, Kuninori Morimoto wrote:
> Now I'm creating SH7724 sub cpu support patch.
> And I would like to use "bus_clk" for SCIFA on sh-sci.
> Current sh-sci use module_clk only.
> So, I created attached patch to be able to select "bus_clk" or "module_clk".
> 
> It works well on SH7724/SH7723/SH7722
> But I can not check about other CPU.
> 
> Please review it.
> 
I was afraid this was going to happen sooner or later. This is ok for
2.6.30, but we will have to revisit Magnus' patchset for 2.6.31 to do
this properly. Though I really want to avoid per-port platform devices.
