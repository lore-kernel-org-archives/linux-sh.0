From: Simon Horman <horms@verge.net.au>
Date: Mon, 19 Nov 2012 05:02:36 +0000
Subject: Re: [PATCH 00/04] ARM: mach-shmobile: sh7372 INTC DT update
Message-Id: <20121119050233.GA28001@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20121116103433.4231.27004.sendpatchset@w520>
In-Reply-To: <20121116103433.4231.27004.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 16, 2012 at 07:34:33PM +0900, Magnus Damm wrote:
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

I have rolled these patches into the existing series that
I have and (forcibly) pushed them to the devel/of branch
of my renesas tree on kernel.org.

I will post the resulting series shortly.

I have added you as a "CC" to each patch and noted your changes to patches
in their changelog. Please feel free to respond to invividual patches or
the entire series a s-o-b or ack or whatever as you see fit and I will
update the patches accordingly.

To be clear, these patches are not yet under consideration for
merging and any s-o-b or ack or similar you send will not change that
without an accompanying discussion.

