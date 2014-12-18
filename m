From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Dec 2014 03:17:16 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: sh73a0: Set control-parent for all irqpin nodes
Message-Id: <CANqRtoQB9fJUF-xq84r8YJYS0O68oizPEPxOF2=0=jj6jF5dnw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418869570-13529-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418869570-13529-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Dec 18, 2014 at 11:26 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The sh73a0 INTC can't mask interrupts properly most likely due to a
> hardware bug. Set the control-parent property to delegate masking to the
> parent interrupt controller.

Thanks for your patch. Are you sure it is needed for all interrupts?
If so, perhaps it we should consider to enable this in the driver
based on the SoC compat string?

Cheers,

/ magnus
