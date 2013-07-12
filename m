From: Simon Horman <horms@verge.net.au>
Date: Fri, 12 Jul 2013 00:56:03 +0000
Subject: Re: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <20130712005603.GB21095@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 11, 2013 at 03:25:55PM +0400, Sergei Shtylyov wrote:
> On 11.07.2013 12:31, Kuninori Morimoto wrote:
> 
> >sh_eth driver which needs platform data at the time of
> >registration is used from BockW only.
> >Now, ARM/shmobile aims to support DT,
> >and the C code base board support will be removed in the future.
> >The driver registration method which needs platform data
> >and which is not shared complicates codes.
> >This patch registers it on board code as cleanup C code
> 
> >Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
>    NAK.

Please provide some reasoning for your objection to this change.
Likewise for other patches in this series to which you have replied
in the same manner. I for one do not understand what it is you object to.
