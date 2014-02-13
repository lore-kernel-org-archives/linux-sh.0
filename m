From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 13 Feb 2014 14:48:04 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: r8a779[01]: Add SSI clocks in device tree
Message-Id: <5275812.0DfTgYCuTW@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Mike,

On Wednesday 25 December 2013 21:34:33 Laurent Pinchart wrote:
> Hello,
> 
> These two patches add the SSI clocks to the r8a7790 and r8a7791 device tree.
> 
> Compared to v1, the SSIn clocks now reference their parent using index 0
> instead of index R8A779[01]_CLK_SSI (which is equal to 5). The clocks
> property is used to look up the clock parent name (possibly before the
> clock parent is even registered), not the clock parent itself. As clock
> parent names are always looked up directly by index, replace the clock
> provider index by the parent index in the clock-output-names list.
> 
> Mike, is this the correct thing to do ? The different meanings of the clocks
> property depending on whether it's located in a clock provider node or a
> clock consumer node are not really intuitive. This should probably be
> documented in Documentation/devicetree/bindings/clock/clock-bindings.txt.

Ping ?

> Laurent Pinchart (2):
>   ARM: shmobile: r8a7790: Add SSI clocks in device tree
>   ARM: shmobile: r8a7791: Add SSI clocks in device tree
> 
>  arch/arm/boot/dts/r8a7790.dtsi            | 18 ++++++++++++++++++
>  arch/arm/boot/dts/r8a7791.dtsi            | 18 ++++++++++++++++++
>  include/dt-bindings/clock/r8a7790-clock.h | 13 +++++++++++++
>  include/dt-bindings/clock/r8a7791-clock.h | 13 +++++++++++++
>  4 files changed, 62 insertions(+)

-- 
Regards,

Laurent Pinchart

