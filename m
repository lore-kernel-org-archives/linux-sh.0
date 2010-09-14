From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Sep 2010 09:26:11 +0000
Subject: Re: [PATCH] sh: ecovec24: modify tsc2007 platform settings
Message-Id: <20100914092611.GQ7336@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pmxs8idw5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pmxs8idw5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 14, 2010 at 06:23:23PM +0900, Kuninori Morimoto wrote:
> 
> Dear Paul
> 
> > > This patch modify x_plate_ohms to correct value for tsc2007 panel,
> > > and removed un-necessary ts_get_pendown_state()
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Applied, thanks.
> 
> Ohh Sorry Paul
> This patch (and ARM: mach-shmobile: ap4evb: modify tsc2007 platform settings)
> has same issue.
> So, please revert it.
> 
Ok, I wasn't sure exactly what was going on. I had applied it in the ARM
case also, but then reverted it in order for

"ARM: mach-shmobile: ap4evb: modify touchpanel judgment condition"

to apply. However, I didn't see any similar patch for ecovec, so should
we just leave ecovec as it is?
