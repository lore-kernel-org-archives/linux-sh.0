From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 Nov 2013 05:44:13 +0000
Subject: Re: [PATCH] irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation
Message-Id: <CANqRtoSa9w5yi6aXsWS6w85wdygRv7EvoAC8ozo-eVLzWo=DOg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Sat, Nov 9, 2013 at 9:18 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The SENSE register bitfield position is incorrectly computed for SoCs
> that use 2-bit IRQ sense fields. Fix it.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I checked this against the sh73a0 data sheet which is using 4-bit IRQ
sense and it looks correct to me.

It would nice nice if someone could test this on r8a7778 or r8a7779
which I believe use 2-bit IRQ sense.

Also, in the future, since the INTC hardware is kind of diverse,
please consider including SoC information in the commit message.

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
