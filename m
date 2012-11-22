From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 22 Nov 2012 01:48:30 +0000
Subject: Re: [PATCH 00/04] ARM: mach-shmobile: sh7372 INTC DT update
Message-Id: <CABMQnV+ibY_hmegkJJyHcSkpD9GUf43stpmkLcqPeqbambeV4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20121116103433.4231.27004.sendpatchset@w520>
In-Reply-To: <20121116103433.4231.27004.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

HI, all.

On Fri, Nov 16, 2012 at 7:34 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: mach-shmobile: sh7372 INTC DT update
>
> [PATCH 01/04] ARM: mach-shmobile: sh7372 INTC DT INTCA/INTCS typo fix
> [PATCH 02/04] ARM: mach-shmobile: sh7372 INTC DT section mismatch fix
> [PATCH 03/04] ARM: mach-shmobile: sh7372 INTC DT init cleanup
> [PATCH 04/04] ARM: mach-shmobile: sh7372 INTC DT consolidation
>
> This series shaves off 100 lines of code from the INTC DT implementation
> available in the devel/of branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
>
> These patches are the result of me trying to get the new INTC DT code
> working on the sh7372 Mackerel board. With these fixes and cleanups
> applied the board boots as expected with DT, but as usual the sh7372
> SoC setup code is using serial ports and timers as platform devices.
>
> I tried using the INTC DT interrupt controller code with external
> interrupt pins on the sh7372 mackerel board with DT, but for some
> reason the following network device refuses to probe due to some
> interrupt issue.
>
>        lan9220@14000000 {
>                compatible = "smsc,lan9220", "smsc,lan9115";
>                reg = <0x14000000 0x2000000>;
>                phy-mode = "mii";
>                interrupt-parent = <&intca_irq_pins_lo>;
>                interrupts = <0x2c0>;
>                reg-io-width = <4>;
>                smsc,irq-push-pull;
>        };

This is a problem of a dtsi file.
I will fix.

>
> The above snippet is nicked and adjusted from my earlier prototype patches:
> [PATCH] sh: INTC IRQ domain and DT support prototype
> [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
>
> I wonder, is there any outstanding INTC work related to IRQ domains?
>
> Perhaps the best way forward is that Iwamatsu-san rolls these
> changes into his current patches and releases a new version after
> updating the other SoCs.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
>
>  arch/arm/boot/dts/sh7372.dtsi        |    8 -
>  arch/arm/mach-shmobile/intc-sh7372.c |  250 +++++++++-------------------------
>  drivers/sh/intc/of_intc.c            |    8 -
>  3 files changed, 80 insertions(+), 186 deletions(-)
>

looks good to me.
I will update other CPU.

Best regards,
  Nobuhiro

---
Nobuhiro Iwamatsu
