From: Simon Horman <horms@verge.net.au>
Date: Sat, 15 Dec 2012 08:36:14 +0000
Subject: Re: [PATCH 4/7] ARM: sh7372: add clock lookup entries for DT-based devices
Message-Id: <20121215083613.GG9073@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
 <1355503531-7276-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1355503531-7276-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 14, 2012 at 05:45:28PM +0100, Guennadi Liakhovetski wrote:
> When booting with DT, devices are named differently. To get their clocks
> additional entries have to be added to the lookup table.

Thanks applied.

I have applied this to a temporary 'soc5' branch which is based on 3.7-rc1.
I will rebase this on 3.8-rc1 once it is released and rename the branch
to the more sane 'soc'.

I have also merged this change into the next branch.

