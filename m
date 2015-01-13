From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 Jan 2015 02:08:14 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Introduce multiplatform support
Message-Id: <20150113020811.GA21265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1420808932-3899-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420808932-3899-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 09, 2015 at 02:08:48PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series (by Magnus) introduces multiplatform support for the
> sh73a0 platform. After this kzm9g can boot a sh73a0 multiplatform
> kernel fine, except for working Ethernet (the ZB clock is disabled by
> clk_disable_unused()).
> 
> This series has been sent before by Magnus as part of the series
> "[PATCH v2 00/05] ARM: shmobile: sh73a0 and kzm9g Multiplatform
> revisit" (http://www.spinics.net/lists/linux-sh/msg38384.html).
> I've updated the kzm9g DTS sync patch for recent changes to the
> kzm9g-reference DTS.
> 
> Thanks for applying!

Thanks, done.
