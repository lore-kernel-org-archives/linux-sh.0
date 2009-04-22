From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Apr 2009 00:36:34 +0000
Subject: Re: [PATCH] sh-sci: fix SCBRR value calculation
Message-Id: <20090422003634.GC23986@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <ud4bf3jpm.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ud4bf3jpm.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 14, 2009 at 02:53:13PM +0900, morimoto.kuninori@renesas.com wrote:
> 
> Dear yoshii
> 
> > Please don't omit that term, that is for "round to near" operation.
> 
> Ahhhhhh....
> Now I could understand !!!
> Sorry I didn't know that this calculation is "round to near" operation.
> 
Is there an updated patch forthcoming for this, or do we just leave SCBRR
as it is?
