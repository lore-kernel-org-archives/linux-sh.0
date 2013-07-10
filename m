From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 00:59:13 +0000
Subject: Re: [PATCH v3 2/2] ARM: shmobile: ape6evm-reference: add CPUFreq support
Message-Id: <20130710005913.GF32603@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373299498-10044-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373299498-10044-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 08, 2013 at 06:04:58PM +0200, Guennadi Liakhovetski wrote:
> Add CPUFreq support to ape6evm-reference, using a max8973 regulator, that
> is supplying V_DVFS for the 4 CA15 cores on r8a73a4.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> v3: call platform_device_register_simple() directly
> 
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   22 ++++++++++++++++++++++
>  arch/arm/mach-shmobile/board-ape6evm-reference.c |    2 ++
>  2 files changed, 24 insertions(+), 0 deletions(-)

Thanks, I have queued this up for v3.12 in the dt-ape6evm branch                
with Magnus's Ack.  It should appear in renesas-next-20130710

