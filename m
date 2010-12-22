From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Dec 2010 04:42:06 +0000
Subject: Re: about ap4evb HDMI video
Message-Id: <20101222044206.GI30700@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pbp4g6enp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pbp4g6enp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 21, 2010 at 10:32:13AM +0900, Kuninori Morimoto wrote:
> > Please let us know what the differences are. If you have a config option
> > enabled that causes an -ENOMEM then we need to know what that is, and
> > what is causing it.
> 
> I checked diff my.config guennadi.config
> The critical config was
> 
> CONFIG_FORCE_MAX_ZONEORDER
> 
> guennadi's config was 12
> my         config was 11
> 
> default value seems 11 ?
> 
For boards that need to do large contiguous allocations it of course
makes sense to have this number bumped up. Most boards however do not
require this, so we always stick with a conservative default.

What happened here is that you tried to alloc a large contiguous block
that exceeded the max order and got an -ENOMEM, so we don't have any
option but to bump the max order for this case.
