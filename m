From: Vasiliy Kulikov <segoon@openwall.com>
Date: Fri, 26 Nov 2010 17:45:33 +0000
Subject: Re: [PATCH] sh: boards: mach-se: use IS_ERR() instead of NULL check
Message-Id: <20101126174533.GA29507@albatros>
List-Id: <linux-sh.vger.kernel.org>
References: <1290791190-21358-1-git-send-email-segoon@openwall.com>
 <Pine.LNX.4.64.1011261835500.16655@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011261835500.16655@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: kernel-janitors@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Guennadi,

On Fri, Nov 26, 2010 at 18:38 +0100, Guennadi Liakhovetski wrote:
> On Fri, 26 Nov 2010, Vasiliy Kulikov wrote:
> > clk_get() returns ERR_PTR() on error, not NULL.
> > 
> > Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
> 
> Yep, there are, probably, a couple more of these, similar to

I found a bit more, but I'd like to get feedback on these or just see it
applied first ;)


Thanks,

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
