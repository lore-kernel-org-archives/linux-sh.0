From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Feb 2015 01:46:50 +0000
Subject: Re: [PATCH 0/3] Enable R-Mobile Reset Driver
Message-Id: <20150224014649.GH29878@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1424707169-23007-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Feb 23, 2015 at 04:59:26PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series enables the R-Mobile Reset Driver, which is now in
> v4.0-rc1. It can be used to restart DT-based R-Mobile APE6 (r8a73a4),
> R-Mobile A1 (r8a7740), and SH-Mobile AG5 (sh73a0) through the
> system-controller nodes that have been added for PM Domain support.
> This series also removes the no longer needed restart callbacks on
> multiplatform r8a7740 and sh73a0.
>         
> More detailed depencencies are in the individual patches.
> 
> Thanks for applying!

Thanks, done.
