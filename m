From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Nov 2015 00:35:31 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: remove deprecated #gpio-range-cells from dtsi
Message-Id: <20151125003531.GJ20596@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1448400743-18104-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1448400743-18104-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 24, 2015 at 10:32:23PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
> declares the above property deprecated. That was more than 2 years ago.
> Remove it, so it doesn't get copied around needlessly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I have queued this up.
