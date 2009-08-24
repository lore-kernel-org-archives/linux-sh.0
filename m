From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 24 Aug 2009 09:55:54 +0000
Subject: Re: Current ms7724se LAN doesn't work
Message-Id: <20090824095554.GA17426@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 24, 2009 at 06:45:45PM +0900, Kuninori Morimoto wrote:
> 
> Dear Paul
> 
> Thank you for your patch
> 
> > This would be a runtime PM issue, which SH-Mobile unconditionally
> > selects. The problem is that the module is most likely disabled via its
> > MSTP bit under the new scheme, so sh-eth will need to tie in to the
> > runtime PM framework to get that resolved.
> > 
> > Can you give this a try?
> 
> hmmm..
> I tried this patch, but it still doesn't work.
> log is 
> 
Ok, we'll have to let Magnus take a look at it then, as it's certainly
runtime PM related.
