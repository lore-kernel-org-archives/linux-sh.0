From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Apr 2009 02:55:32 +0000
Subject: Re: [PATCH] sh-sci: fix SCBRR value calculation
Message-Id: <20090422025532.GA24515@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ud4bf3jpm.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ud4bf3jpm.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 22, 2009 at 11:50:11AM +0900, Kuninori Morimoto wrote:
> 
> Dear Paul
> 
> > > > Please don't omit that term, that is for "round to near" operation.
> > > 
> > > Ahhhhhh....
> > > Now I could understand !!!
> > > Sorry I didn't know that this calculation is "round to near" operation.
> > > 
> > Is there an updated patch forthcoming for this, or do we just leave SCBRR
> > as it is?
> 
> There is no problem at present for me.
> Sorry for my stupid question/patch.
> 
No problem, there are so many variations that it is pretty easy for there
to be an incorrect setting that still "works" for the general cases. It
is always better to be certain if you spot something that looks
questionable, especially as a lot of this code has not changed
fundamentally in years, while the CPUs have.
