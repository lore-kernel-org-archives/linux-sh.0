From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 05 Mar 2013 04:11:50 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <20130305041149.GC14275@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 05, 2013 at 12:18:52PM +0900, Simon Horman wrote:
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
> 
> To confuse things, I believe there are a batch of PFC changes that
> will make sense to take through the arm-soc tree due to dependencies.
> 
It doesn't particularly matter to me where the updates go, so long as
everyone is kept aware of what changes are being made before they're
silently merged somewhere.

Stuff like this falls more in to the obvious bugfix category, and is
probably fine for arm-soc, given that it's largely SoC-specific. I would
prefer if the sh-pfc core stuff remain independent of arm-soc however,
but it's not terribly important whether I merge it or Linus does.
