From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Jan 2013 11:59:54 +0000
Subject: Re: [PATCH v2] sh: clkfwk: bugfix: sh_clk_div_enable() care sh_clk_div_set_rate() if div6
Message-Id: <20130111115954.GA19781@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9u4x5q1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9u4x5q1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 10, 2013 at 05:30:25PM -0800, Kuninori Morimoto wrote:
> 
> Hi Paul
> 
> I still couldn't find this patch on linus/master branch.
> What is current status of this ?
> 
Looks like it got missed, possibly when I was shuffling trees and
machines around. I've queued it up now.
