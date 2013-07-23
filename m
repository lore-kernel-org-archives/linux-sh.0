From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jul 2013 01:24:38 +0000
Subject: Re: [PATCH] ARM: shmobile: lager-reference: Add LED6-LED8 to the device tree
Message-Id: <20130723012438.GB16481@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373967956-3651-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373967956-3651-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 16, 2013 at 11:45:56AM +0200, Laurent Pinchart wrote:
> LED6 to LED8 are GPIO LEDs. Add corresponding DT nodes.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7790-lager-reference.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> The patch is based on renesas-devel-20130716.

Thanks, I have queued this up for v3.12 in the dt2 branch of the renesas tree.
