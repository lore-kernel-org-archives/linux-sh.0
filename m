From: Simon Horman <horms@verge.net.au>
Date: Mon, 07 Dec 2015 06:43:42 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7793: remove deprecated #gpio-range-cells
Message-Id: <20151207064342.GJ22834@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448511980-12173-1-git-send-email-horms+renesas@verge.net.au>
 <20151126090055.GA1531@katana>
In-Reply-To: <20151126090055.GA1531@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Nov 26, 2015 at 10:00:55AM +0100, Wolfram Sang wrote:
> On Thu, Nov 26, 2015 at 01:26:20PM +0900, Simon Horman wrote:
> > Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
> > declares the above property deprecated. That was more than 2 years ago.
> > Remove it, so it doesn't get copied around needlessly.
> > 
> > Based on similar work for the r8a7791 and r8a7794 by Wolfram Sang.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I have queued this up.

