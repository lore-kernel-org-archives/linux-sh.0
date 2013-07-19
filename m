From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Jul 2013 02:30:17 +0000
Subject: Re: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <20130719023017.GH4403@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 18, 2013 at 03:54:33PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 18-07-2013 3:11, Simon Horman wrote:
> 
> >>>>>sh_eth driver which needs platform data at the time of
> >>>>>registration is used from BockW only.
> >>>>>Now, ARM/shmobile aims to support DT,
> >>>>>and the C code base board support will be removed in the future.
> >>>>>The driver registration method which needs platform data
> >>>>>and which is not shared complicates codes.
> >>>>>This patch registers it on board code as cleanup C code
> 
> >>>>>Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> >>>>    NAK.
> 
> >>>Please provide some reasoning for your objection to this change.
> >>>Likewise for other patches in this series to which you have replied
> >>>in the same manner. I for one do not understand what it is you object to.
> 
> >>    Sorry, I was just out of words when I saw this. I for one do not
> >>understand how this change will help the DT support and to me it
> >>seems no more than a pointless churn and step backward from what we
> >>had. Under no circumstances I will accept this change -- I'm totally
> >>opposed to the idea of moving the SoC devices to the board code.
> 
> >Hi,
> 
> >I believe that the crux of your concern is that the way that
> >SH ethernet support has been added recently is to place SoC portions
> >in setup-xxx.c and board-specific portions into board-YYY.c
> 
>    Not only Ether but all the SoC devices. Hence were the NAKs for other patches.

I believe that I agree with your concerns.
Morimoto-san, could you drop these cleanup patches?
