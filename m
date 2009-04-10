From: morimoto.kuninori@renesas.com
Date: Fri, 10 Apr 2009 04:56:09 +0000
Subject: Re: [PATCH] sh7786: modify usb setup timeout judgment bug.
Message-Id: <uzlepm7iu.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> > I don't see any reason why we can't accomodate the r7a66597 platform data
> > change within -rc2, so if that is the way you want to fix this, then that
> > should be fine. Of course if it is too invasive, we will just use the
> > original fix in the board, but there is not much point in doing a
> > stop-gap fix if we already have some plan on how to fix it properly.
> 
> Thank you for your comment!
> I will try this changing properly. But I may need much time.

So, what is the best way about this problem ?

Can you agree to use this (niche) patch until
shimoda-san's work will be completed ?
If you can agree, I would like to send v2 patch.

Or should I wait for shimoda-san's work ?

Best regards
--
Kuninori Morimoto
 
