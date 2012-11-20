From: Simon Horman <horms@verge.net.au>
Date: Tue, 20 Nov 2012 00:43:42 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: Add FLCTL IRQ resource
Message-Id: <20121120004342.GG13829@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1352803609-16669-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1352803609-16669-1-git-send-email-hechtb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 20, 2012 at 01:05:00AM +0100, Bastian Hecht wrote:
> Since commit 3c7ea4e (mtd: sh_flctl: Add support for error IRQ)
> the sh_flctl driver requires the error IRQ line to signal failed
> transactions between the flash controller and the NAND chip.
> This information is mandatory - else the driver refuses to start
> up. We provide it here for the board mackerel.
> 
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
> v1: extended commit
> v2: added commit message of referenced patch

Thanks, I have updated the boards2 branch and sent an
updated pull-request to arm-soc.
