From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Jul 2013 23:11:13 +0000
Subject: Re: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <20130717231113.GC8154@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 12, 2013 at 03:05:28PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 12-07-2013 4:56, Simon Horman wrote:
> 
> >>>sh_eth driver which needs platform data at the time of
> >>>registration is used from BockW only.
> >>>Now, ARM/shmobile aims to support DT,
> >>>and the C code base board support will be removed in the future.
> >>>The driver registration method which needs platform data
> >>>and which is not shared complicates codes.
> >>>This patch registers it on board code as cleanup C code
> 
> >>>Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> >>    NAK.
> 
> >Please provide some reasoning for your objection to this change.
> >Likewise for other patches in this series to which you have replied
> >in the same manner. I for one do not understand what it is you object to.
> 
>    Sorry, I was just out of words when I saw this. I for one do not
> understand how this change will help the DT support and to me it
> seems no more than a pointless churn and step backward from what we
> had. Under no circumstances I will accept this change -- I'm totally
> opposed to the idea of moving the SoC devices to the board code.

Hi,

I believe that the crux of your concern is that the way that
SH ethernet support has been added recently is to place SoC portions
in setup-xxx.c and board-specific portions into board-YYY.c

That much seems reasonable to me.

And furthermore you don't see how this change aids adding DT support.

This question also seems reasonable to me.

Magnus, Morimoto-san, could you explain the motivation for this change
more clearly?
