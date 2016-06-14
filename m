From: Rob Herring <robh@kernel.org>
Date: Tue, 14 Jun 2016 22:14:50 +0000
Subject: Re: [PATCH v2 14/17] sh: SH3/4 Generic IRQCHIP driever
Message-Id: <20160614221450.GA26671@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-15-git-send-email-ysato@users.sourceforge.jp>
 <1465717426-7520-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465717426-7520-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Sun, Jun 12, 2016 at 04:43:46PM +0900, Yoshinori Sato wrote:
> Sorry. I send old patches.
> Please ignore previous files.

Something like this needs to go below the '---' line.

> 
> IPR based IRQ chip driver.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  .../interrupt-controller/renesas,sh7751-intc.txt   |  25 ++++

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

>  arch/sh/Kconfig                                    |   6 +-
>  arch/sh/boards/Kconfig                             |   1 +
>  drivers/irqchip/Kconfig                            |   5 +
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-renesas-sh7751.c               | 141 +++++++++++++++++++++
>  6 files changed, 176 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt
>  create mode 100644 drivers/irqchip/irq-renesas-sh7751.c
