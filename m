From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 27 Nov 2010 02:23:15 +0000
Subject: Re: [PATCH] sh: boards: mach-se: use IS_ERR() instead of NULL check
Message-Id: <20101127022315.GF7893@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1290791190-21358-1-git-send-email-segoon@openwall.com> <Pine.LNX.4.64.1011261835500.16655@axis700.grange> <20101126174533.GA29507@albatros>
In-Reply-To: <20101126174533.GA29507@albatros>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, kernel-janitors@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 26, 2010 at 08:45:33PM +0300, Vasiliy Kulikov wrote:
> Hi Guennadi,
> 
> On Fri, Nov 26, 2010 at 18:38 +0100, Guennadi Liakhovetski wrote:
> > On Fri, 26 Nov 2010, Vasiliy Kulikov wrote:
> > > clk_get() returns ERR_PTR() on error, not NULL.
> > > 
> > > Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> > 
> > Yep, there are, probably, a couple more of these, similar to
> 
> I found a bit more, but I'd like to get feedback on these or just see it
> applied first ;)
> 
It's a reasonable change, yes. The old clk_get() scanned multiple lists,
and could return NULL or -ENOENT depending on which path failed. Now that
everything is consolidated through the clk_get_sys() lookup, the NULL
checks should probably all be replaced.
