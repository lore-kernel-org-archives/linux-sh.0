From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 00:40:22 +0000
Subject: Re: [PATCH v3 6/7] ARM: shmobile: r8a73a4: add MMCIF and SDHI DT templates
Message-Id: <20130710004022.GF15011@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373298887-9877-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373298887-9877-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 08, 2013 at 05:54:45PM +0200, Guennadi Liakhovetski wrote:
> This adds DT templates for all MMCIF and SDHI controllers on r8a73a4.
> They are added with status="disabled". To use them platform-specific
> DTs have to enable the required ones.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi |   45 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)

Thanks, I have queued this up for v3.12 in the dt branch.
It should appear in renesas-next-20130710
