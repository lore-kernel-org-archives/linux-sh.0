From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 Jan 2014 05:15:08 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7790: add Audio-DMAC support
Message-Id: <20140109051506.GJ2132@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 06, 2014 at 12:32:12AM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These patches add Audio DMAC support on r8a7790.
> These are used from R-Car sound driver.
> 
> Current Simon's branch doesn't have R-Car
> sound driver support, since it needs ASoC branch merge.
> (= it has Gen2 support)
> But, this DMAEngine support can be applied without
> sound driver support.
> 
> These are based on renesas-devel-v3.13-rc5-20131230 tag

Hi Morimoto-san,

these look good to me.

Magnus,

could you review them?
