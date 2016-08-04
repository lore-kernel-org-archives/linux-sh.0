From: Jason Cooper <jason@lakedaemon.net>
Date: Thu, 04 Aug 2016 14:31:18 +0000
Subject: Re: [PATCH v6 0/2] J-Core interrupt controller support
Message-Id: <20160804143118.GU4541@io.lakedaemon.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b6529.git.dalias@libc.org>
In-Reply-To: <cover.147018b6529.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Hi Rich,

On Thu, Aug 04, 2016 at 04:30:36AM +0000, Rich Felker wrote:
> Updated based on feedback from Thomas Gleixner. Removal of unnecessary
> data allowed some simplification. Magic numbers have been replaced
> with meaningful (I hope) macro constants, comments added, and minor
> style issues fixed.
> 
> Also, driver was made conditional in Kconfig to avoid it showing up in
> configurations where it's not relevant.
> 
> Rich
> 
> 
> Rich Felker (2):
>   of: add J-Core interrupt controller bindings
>   irqchip: add J-Core AIC driver
> 
>  .../bindings/interrupt-controller/jcore,aic.txt    | 26 ++++++
>  drivers/irqchip/Kconfig                            |  7 ++
>  drivers/irqchip/Makefile                           |  1 +
>  drivers/irqchip/irq-jcore-aic.c                    | 94 ++++++++++++++++++++++
>  4 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/jcore,aic.txt
>  create mode 100644 drivers/irqchip/irq-jcore-aic.c

Once -rc1 drops, I'll put this in a branch, irqchip/jcore.  You can then
include it as a dep for other branches as needed.

thx,

Jason.
