From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 08 Oct 2009 07:21:07 +0000
Subject: Re: Current ms7724se LAN doesn't work
Message-Id: <20091008072106.GA31816@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 08, 2009 at 03:51:43PM +0900, Magnus Damm wrote:
> Hi Morimoto-san,
> 
> On Thu, Oct 8, 2009 at 1:45 PM, Kuninori Morimoto
> <morimoto.kuninori@renesas.com> wrote:
> >
> > Hi Magnus
> >
> > sorry for my late response
> 
> No worries, you are not late.
> 
> >> Can you give the attached patches a try?
> >>
> >> Apply in this order:
> >> linux-2.6.32-rc-net-sh_eth-platform-data-mac-20091007b.patch
> >> linux-2.6.32-rc-net-sh_eth-runtime-pm-20091007.patch
> >> linux-2.6.32-rc-sh-ecovec-sh_eth-pdata-mac-20091007.patch
> >> linux-2.6.32-rc-sh-ecovec-sh_eth-hwblk_id-20091007.patch
> >>
> >> They seem to work fine on ecovec for me. Do they solve your issue?
> >
> > How cool !!
> > It works well on ecovec / ms7724se !!
> > Thank you
> >
> > Tested-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> 
> Excellent, thanks for testing!
> 
Please send the driver bits on to DaveM, and I'll merge the platform bits
independently.
