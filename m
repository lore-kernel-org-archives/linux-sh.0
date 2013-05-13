From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 13 May 2013 09:58:06 +0000
Subject: Re: [PATCH 07/14] ARM: spear: Remove init_irq declaration in machine description
Message-Id: <CAKohpo=TRXoZ2L0vUor4834QNbf0UxaB9AVYY-r-3mAKYTgjig@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-8-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1368438253-28218-8-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 13 May 2013 15:14, Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for spear as well.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-spear/spear1310.c | 1 -
>  arch/arm/mach-spear/spear1340.c | 1 -
>  arch/arm/mach-spear/spear300.c  | 1 -
>  arch/arm/mach-spear/spear310.c  | 1 -
>  arch/arm/mach-spear/spear320.c  | 1 -
>  arch/arm/mach-spear/spear6xx.c  | 1 -
>  6 files changed, 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
