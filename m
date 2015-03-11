From: Simon Horman <horms@verge.net.au>
Date: Wed, 11 Mar 2015 00:41:15 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: r8a779x: sound DMA support
Message-Id: <20150311004112.GA11701@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4n5skce.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4n5skce.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 10, 2015 at 01:38:25AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon, Arnd
> 
> These patches add DMA DT entry for Renesas sound driver.
> Renesas sound driver needs 1st/2nd DMA, and now,
> 1st DMA is implemented by DMAEngine, and 2nd is implemented
> in sound driver.
> These patches add Renesas sound DMA DT entry for r8a7790/r8a7791.
> 
> Simon
> 
> New sound driver patches are accepted by Mark's branch,
> but, these patches have no dependency with sound driver side.
> Current sound driver (= on renesas-devel base) just ignores these DT entry.
> New sound driver will use these DT entry if sound and SH-ARM branches
> are merged.

Thanks.

It seems to me that it is now safe for me to queue these up.
I have done so. Please let me know if that was not your desired outcome.
