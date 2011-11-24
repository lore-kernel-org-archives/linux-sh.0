From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Nov 2011 08:36:41 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Kota2 PINT fix
Message-Id: <20111124083640.GE32112@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111122061557.30983.75780.sendpatchset@w520>
In-Reply-To: <20111122061557.30983.75780.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 22, 2011 at 03:15:57PM +0900, Magnus Damm wrote:
> Support PINT on sh73a0 and Kota2 using INTC PINT macros.
> 
> With this patch applied the Kota2 ethernet is handled
> through one of the chained sh73a0 PINT interrupt controllers.
> 
> sh73a0 PINT support is included in 3.2-rc but the Kota2 board
> code does not make use of this shared code base without this
> patch. Without this patch kota2 on-board ethernet is broken.

On Tue, Nov 22, 2011 at 03:23:17PM +0900, Magnus Damm wrote:
> Keep the ZB clock enabled on sh73a0 to allow the BSC
> to access external peripherals hooked up to CS signals.
> 
> This is needed to unbreak Ethernet support on sh73a0 boards
> such as AG5EVM and Kota2 together with the following patch:
> 
>  794d78f drivers: sh: late disabling of clocks V2

On Tue, Nov 22, 2011 at 03:29:54PM +0900, Magnus Damm wrote:
> Fix IRQ support on the Kota2 board. The sh73a0 and the Kota2
> board make use of the ARM GIC hardware block as main interrupt
> controller. The following commit changed the default behaviour
> for non-device tree platforms and broke Kota2 irq support:

On Tue, Nov 22, 2011 at 03:31:40PM +0900, Magnus Damm wrote:
> Fix IRQ support on the AG5EVM board. The sh73a0 and the AG5EVM
> board make use of the ARM GIC hardware block as main interrupt
> controller. The following commit changed the default behaviour
> for non-device tree platforms and broke AG5EVM irq support:

On Tue, Nov 22, 2011 at 03:44:58PM +0900, Magnus Damm wrote:
> This patch updates the Kota2 board support code to
> use the recently merged TPU LED driver whenever
> possible.
> 
> The sh73a0 SoC has 5 TPU hardware blocks each with
> 4 timer channels which in theory allows a total of
> 20 LEDs to be controlled by "leds-renesas-tpu"
> driver instances. The Kota2 board has 4 LEDs connected
> to GPIO pins that also come with TPU pin functions, so
> this patch ties up these 4 LEDS and leaves the remaining
> 3 LEDS for the GPIO based LED driver.

All applied, thanks.
