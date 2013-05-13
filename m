From: David Brown <davidb@codeaurora.org>
Date: Mon, 13 May 2013 18:26:49 +0000
Subject: Re: [PATCH 08/14] ARM: msm: Remove init_irq declaration in machine description
Message-Id: <20130513182648.GA26913@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-9-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1368438253-28218-9-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 13, 2013 at 11:44:07AM +0200, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for msm as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-msm/board-dt-8660.c | 1 -
>  arch/arm/mach-msm/board-dt-8960.c | 1 -
>  2 files changed, 2 deletions(-)

I'll pull this into my msm-cleanup tree.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
