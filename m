From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Nov 2013 03:30:29 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9d: Enable AUTO_ZRELADDR in defconfig
Message-Id: <20131113033029.GF22484@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383954465-6056-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1383954465-6056-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Nov 09, 2013 at 08:47:45AM +0900, Simon Horman wrote:
> This is required to allow the load address to be supplied
> as an environment variable when building a uImage.
> 
> LOADADDR=0x40008000 ARCH=arm make uImage
> 
> This is necessary since "ARM: shmobile: Remove legacy KZM9D board code"
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.
