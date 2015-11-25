From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Nov 2015 00:31:17 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7791: remove deprecated #gpio-range-cells from dtsi
Message-Id: <20151125003117.GI20596@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <a8a8266229787241e1dfdb075a416e31da2fa1d7.1394082270.git.horms+renesas@verge.net.au>
In-Reply-To: <a8a8266229787241e1dfdb075a416e31da2fa1d7.1394082270.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 24, 2015 at 10:32:22PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Commit a1bc260bb5f5d9 ("gpio: clean up gpio-ranges documentation")
> declares the above property deprecated. That was more than 2 years ago.
> Remove it, so it doesn't get copied around needlessly.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I have queued this up.
