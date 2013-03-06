From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 06 Mar 2013 00:39:58 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <4455134.HTeR80292e@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tuesday 05 March 2013 12:18:52 Simon Horman wrote:
> [ Cc: Linus Walleij ]
> 
> Hi Linus, Hi Paul, Hi Laurent,
> 
> I'm a little unsure how everyone would like to handle
> drivers/pinctrl/sh-pfc/ updates.
> 
> I'm happy to create a pfc branch and send pull requests to Linus.
> Or for Paul to handle things. Or for Laurent to handle things.
> Or for other suggestions.

I would take this kind of patches in my tree, except that in this case the 
patch isn't correct, as pointed out by Phil in his reply.

> To confuse things, I believe there are a batch of PFC changes that
> will make sense to take through the arm-soc tree due to dependencies.

I'm working on the next batch, I will submit it today or tomorrow.

-- 
Regards,

Laurent Pinchart

