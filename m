From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 10 Apr 2009 22:22:28 +0000
Subject: Re: [PATCH] sh7786: modify usb setup timeout judgment bug.
Message-Id: <20090410222228.GB22417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 10, 2009 at 01:56:09PM +0900, morimoto.kuninori@renesas.com wrote:
> > > I don't see any reason why we can't accomodate the r7a66597 platform data
> > > change within -rc2, so if that is the way you want to fix this, then that
> > > should be fine. Of course if it is too invasive, we will just use the
> > > original fix in the board, but there is not much point in doing a
> > > stop-gap fix if we already have some plan on how to fix it properly.
> > 
> > Thank you for your comment!
> > I will try this changing properly. But I may need much time.
> 
> So, what is the best way about this problem ?
> 
> Can you agree to use this (niche) patch until
> shimoda-san's work will be completed ?
> If you can agree, I would like to send v2 patch.
> 
> Or should I wait for shimoda-san's work ?
> 
You can send a v2 patch. If Shimoda-san does not believe he will be able
to submit a more complete patch within the -rc2 timeframe, then we will
use your v2 patch instead.
