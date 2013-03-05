From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Mar 2013 08:58:10 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <20130305085806.GA25236@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 04, 2013 at 08:14:34PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Morimoto-san,
> > 
> > could you comment on how critical this change is.
> > Does anything in 3.9-rc1 depend on it?
> 
> Now, R-Car H1 board is only Marzen,
> and it doesn't have GPIO input/output device (like gpio-key)
> at this point
> I guess, it is not critical in v3.9.

Thanks, it sounds like it can just be queued up for the next release.
