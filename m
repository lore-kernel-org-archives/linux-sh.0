From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Oct 2012 05:13:38 +0000
Subject: Re: __raw_xxx() :: compile warning on sh-arm
Message-Id: <20121015051337.GA32566@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87626ccwr2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87626ccwr2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Oct 14, 2012 at 07:08:55PM -0700, Kuninori Morimoto wrote:
> 
> Hi Paul, Simon, Magnus
> 
> Current linus/master tree has compile warning on __raw_xxx() if it was "sh-arm" kernel.
> It doesn't happen on "sh" kernel.
> 
> I guess it from
> 195bbcac2e5c12f7fb99cdcc492c3000c5537f4a
> (ARM: 7500/1: io: avoid writeback addressing modes for __raw_ accessors)
> 
Yes, unsurprisingly this is what happens when you are told how to fix
something properly and then simply drop that part of your patch rather
than doing the bare minimum in classic ARM style.

It's fixed in my tree now via:

	sh: Fix up more fallout from pointless ARM __iomem churn.

I'll send it off to Linus.
