From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Aug 2012 06:30:15 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <20120820063014.GF25767@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Aug 19, 2012 at 11:24:51PM -0700, Kuninori Morimoto wrote:
> 
> Hi Paul
> 
> > > I'm not sure why, but this patch solved problem ?
> > > 
> > I'll let Magnus figure this one out, as it was his hack in the first
> 
> Thank you !
> 
> > place. At least we know the irqdomain code isn't at fault anymore.
> 
> We have irq2 fix patch for multi-evt from you ?
>         ~~~~
> 
Yes, I'll be sending that to Linus for -rc3.
