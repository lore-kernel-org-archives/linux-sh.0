From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Jan 2013 03:53:00 +0000
Subject: Re: [PATCH 6/9] ARM: shmobile: kzm9g: Add pin control device in device tree
Message-Id: <20130108035300.GA18154@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357260060-32164-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357260060-32164-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 04, 2013 at 01:40:57AM +0100, Laurent Pinchart wrote:
> Add a pfc node in the sh73a0 device tree and include it in kzm9g.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Laurent,

could you please split this patch in two?

A patch to sh73a0-kzm9g which I can add to a boards branch.
And a patch to arch/arm/boot/dts/sh73a0.dts which I can add to an
soc branch.

Thanks
