From: Simon Horman <horms@verge.net.au>
Date: Tue, 11 Jan 2011 22:48:48 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add sdhi support
Message-Id: <20110111224848.GD3848@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 11, 2011 at 06:27:30PM +0900, Yusuke Goda wrote:
> Hi Simon-san
> 
> Sorry for the late reply.
> 
> As for AP4 and the mackerel board,
> the I/O voltage of SDHI1 and MMCIF is 1.8v fixation.
> So do not recognize the memory card.(Requires 3.3v)
> The new memory card, 3.3v from 1.8v seems to be able to bring down.
> However, AP4 and mackerel board can not support.
> 
> Perhaps that supports 1.8v eSD and eMMC would be recognized only.

Hi Goda-san,

sorry for not replying to my own post earlier.
Magnus pointed out that the problem I was seeing
was due to not setting SW33 correctly. Other than
the proposed documentation update that I posted
(and you commented on) everything is fine now.
