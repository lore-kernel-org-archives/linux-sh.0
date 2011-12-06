From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 06 Dec 2011 05:22:17 +0000
Subject: Re: [PATCH 2/4] sh: modify SH_CLK_DIV6_EXT macro parameter
Message-Id: <20111206052217.GC30055@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <874nxf8rgh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nxf8rgh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Dec 04, 2011 at 10:26:09PM -0800, Kuninori Morimoto wrote:
> array size which can be calculated from specific table was removed,
> and the "flags" which can use CLK_ENABLE_ON_INIT became last parameter.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It can, but no, I don't really like these sorts of changes. From a usage
point of view it might look more straightforward but in reality it's just
pushing down complexity in to the macro that's non-obvious without
manually going and looking at the macro definition.

Saving a bit of screen real-estate isn't worth the hassle of having to
track down macro definitions to find out what exactly they're doing.
