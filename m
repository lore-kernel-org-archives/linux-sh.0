From: Simon Horman <horms@verge.net.au>
Date: Wed, 18 Nov 2015 20:52:55 +0000
Subject: Re: [PATCH 0/2] VIN, ADV7180 for r8a7794/alt
Message-Id: <20151118205255.GB10471@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447851067-8214-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1447851067-8214-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 18, 2015 at 01:51:05PM +0100, Ulrich Hecht wrote:
> Hi!
> 
> This series adds VIN support for the Alt board.  The hardware configuration
> for I2C1 and the video decoder of Alt is exactly identical to that of Silk,
> so these are largely identical to Sergei's Silk definitions.
> 
> To be applied on top of Horms's "ARM: shmobile: alt: Add pfc pins to DT"
> patch.

Thanks, I have queued-up this series on top of the patch mentioned above.
