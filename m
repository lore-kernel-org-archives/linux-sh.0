From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 05 Jul 2013 01:21:16 +0000
Subject: Re: [PATCH 1/6] ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
Message-Id: <CANqRtoSN1vq0Bn5ODG9n3KKDAFBd3XqOm5+oSsKR14cvd3qhOw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369573557-11071-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1369573557-11071-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 5, 2013 at 5:38 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Add a DMAC platform device and clock definitions for it on r8a73a4.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a73a4.c        |    4 +-
>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |   15 +++
>  arch/arm/mach-shmobile/setup-r8a73a4.c        |  117 +++++++++++++++++++++++++
>  3 files changed, 135 insertions(+), 1 deletions(-)
>

> @@ -200,6 +314,9 @@ void __init r8a73a4_add_standard_devices(void)
>         r8a73a4_register_irqc(1);
>         r8a73a4_register_thermal();
>         r8a7790_register_cmt(10);
> +       platform_device_register_resndata(&platform_bus, "sh-dma-engine", 0,
> +                               dma_resources, ARRAY_SIZE(dma_resources),
> +                               &dma_platform_data, sizeof(dma_platform_data));
>  }

This goes without saying, but please follow the same style as previous
commits for this file. So, in detail, instead of adding the
platform_device_register_resndata() directly then add a macro that
makes this more readable.

Thanks,

/ magnus
