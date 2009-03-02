From: morimoto.kuninori@renesas.com
Date: Mon, 02 Mar 2009 00:24:41 +0000
Subject: Re: [PATCH 2/2] Add support ov772x driver setting to ap325
Message-Id: <u63is22ly.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> > > Please exclude this commit from sh/for-2.6.29.
> > > Because patces for media/ov772x.h is not yet taken in in 2.6.29-rcX,
> > > compiling it fails.
(snip)
> I've reverted it in the 2.6.29 tree, but it is still there for 2.6.30,
> which should now be settled in -next.

Sorry. Please remove this patch from -next.

Best regards
--
Kuninori Morimoto
 
