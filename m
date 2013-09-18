From: Olof Johansson <olof@lixom.net>
Date: Wed, 18 Sep 2013 20:53:48 +0000
Subject: Re: [PATCH] ARM: shmobile: Allow build of the MTU2 timer driver
Message-Id: <CAOesGMhJmFQwcmUzwoVvA3yBjZVLYj0x9fwCpr_kvTWoWc2qew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130918195000.6075.25025.sendpatchset@w520>
In-Reply-To: <20130918195000.6075.25025.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,


On Wed, Sep 18, 2013 at 12:50 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@opensource.se>
>
> Include MTU2 in the list of timer drivers that may
> be used on mach-shmobile. This driver has previously
> only been used by the SH architecture. With this patch
> the MTU2 joins TMU and CMT as timer drivers that may be
> used on ARM or SH.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>  arch/arm/mach-shmobile/Kconfig |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> --- 0004/arch/arm/mach-shmobile/Kconfig
> +++ work/arch/arm/mach-shmobile/Kconfig 2013-09-19 04:17:55.000000000 +0900
> @@ -314,6 +314,12 @@ config SH_TIMER_CMT
>         help
>           This enables build of the CMT timer driver.
>
> +config SH_TIMER_MTU2
> +       bool "MTU2 timer driver"
> +       default y
> +       help
> +         This enables build of the MTU2 timer driver.

It's odd to have the config entry in arch/arm/ when the driver is in
drivers/clocksource. I think this entry should be moved to
drivers/clocksource/Kconfig for that reason (with appropriate
dependencies).


-Olof
