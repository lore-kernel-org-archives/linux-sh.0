From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Mar 2013 08:36:39 +0000
Subject: Re: [PATCH 00/13 v2] sh-pfc: Initial r8a73a4 PFC support
Message-Id: <1474236.BEDSNVfUMl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326134939.31366.42030.sendpatchset@w520>
In-Reply-To: <20130326134939.31366.42030.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 27 March 2013 13:56:28 Simon Horman wrote:
> On Tue, Mar 26, 2013 at 10:49:39PM +0900, Magnus Damm wrote:
> > sh-pfc: Initial r8a73a4 PFC support (V2)
> > 
> > [PATCH 01/13] sh-pfc: Add r8a73a4 pinmux support
> > [PATCH 02/13] sh-pfc: r8a73a4: Support sparse GPIO numbers
> > [PATCH 03/13 v2] sh-pfc: r8a73a4: GPIO IRQ support
> > [PATCH 04/13] sh-pfc: r8a73a4: Add bias (pull-up/down) pinconf support
> > [PATCH 05/13] sh-pfc: r8a73a4: Add SCIF pin groups and functions
> > [PATCH 06/13] sh-pfc: r8a73a4: Add IRQC pin groups and functions
> > [PATCH 07/13] sh-pfc: r8a73a4: Remove SCIF function GPIOS
> > [PATCH 08/13] sh-pfc: r8a73a4: Remove IRQC function GPIOS
> > [PATCH 09/13] ARM: shmobile: r8a73a4: Remove SCIF function GPIOs
> > [PATCH 10/13] ARM: shmobile: r8a73a4: Remove IRQC function GPIOs
> > [PATCH 11/13] sh-pfc: r8a73a4: Remove function GPIOs
> > [PATCH 12/13] ARM: shmobile: r8a73a4: Remove all GPIO enums
> > [PATCH 13/13] sh-pfc: r8a73a4: Remove unused GPIO bias data
> > 
> > This series is V2 of initial PFC support for the r8a73a4 SoC.
> > The patches add a regular old-style GPIO function controller
> > and makes it partially converted over to PINCTRL for SCIF
> > and IRQC that are tied up on the APE6EVM board. The final
> > patches remove the GPIO function support, so when new drivers
> > for r8a73a4 are added then PINCTRL support has to be included.
> 
> Hi Magnus,
> 
> I apologise if the information is obvious or available elsewhere, but could
> you let me know a bit about the dependencies for this series.
> 
> I am assuming it depends on:
> 
> [PATCH 00/03 v3] ARM: shmobile: r8a73a4 APE6EVM board support
> [PATCH/RFC 00/12] Split PFC and GPIO for R8A7779
> 
> Laurent, if/when this series is ready do you want to take it or should I add
> it to my tree directly?

You can add it to your tree directly when it will be ready. I've acked all but 
patches 01/13 and 06/13. I expect Magnus to resubmit 06/13, could you please 
have a look at my comments on the cover letter and tell whether 01/13 should 
be split in a arch/arm/ patch and a drivers/ patch or if that's unnecessary 
from the ARM tree point of view ?

-- 
Regards,

Laurent Pinchart

