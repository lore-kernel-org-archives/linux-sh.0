From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 30 Sep 2009 02:47:34 +0000
Subject: Re: currect MigoR seems doesn't work
Message-Id: <20090930024734.GB25971@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 30, 2009 at 11:46:07AM +0900, Kuninori Morimoto wrote:
> > Do you have NUMA support enabled? It's possible the LMB changes impacted
> > that.
> 
> It start works if I remove NUMA support from .config
> 
Thanks for testing, I'll look in to fixing it up.
