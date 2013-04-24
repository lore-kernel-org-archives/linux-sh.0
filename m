From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Apr 2013 17:37:57 +0000
Subject: Re: [PATCH 3/9] pwm: Add Renesas Mobile TPU PWM driver
Message-Id: <CANqRtoQzuBg7Y=zPGPDfmWzKjuR8nGfgEgK43+7uSdivmyaBjg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1366761969-16759-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1366761969-16759-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366761969-16759-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, linux-leds@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@avionic-design.de>, Paul Mundt <lethal@linux-sh.org>

Hi Laurent,

On Wed, Apr 24, 2013 at 1:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The Timer Pulse Unit (TPU is a 4-channels 16-bit timer used to generate
> waveforms. This driver exposes PWM functions through the PWM API for
> other drivers to use.
>
> The code is loosely based on the leds-renesas-tpu driver by Magnus Damm
> and the TPU PWM driver shipped in the Armadillo EVA 800 kernel sources.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Tested-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/pwm/Kconfig                    |   7 +
>  drivers/pwm/Makefile                   |   1 +
>  drivers/pwm/pwm-rmob.c                 | 462 +++++++++++++++++++++++++++++++++
>  include/linux/platform_data/pwm-rmob.h |  18 ++
>  4 files changed, 488 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rmob.c
>  create mode 100644 include/linux/platform_data/pwm-rmob.h

Thanks for your efforts with this driver. The new code becomes much
nicer compared to my old driver.

The TPU hardware block is used across several different Renesas
product lines, including R-Mobile and R-Car. So with that in mind, can
you please consider renaming this driver?

I propose pwm-renesas-tpu.c or pwm-tpu.c instead of pwm-rmob.c. This
because this driver has nothing to do with the R mobile product line.

Thanks,

/ magnus
