From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Feb 2013 08:35:51 +0000
Subject: Re: [PATCH] irqchip: Renesas INTC External IRQ pin driver
Message-Id: <CANqRtoSbiPhRbDsZppkJ+F48tEmuCdSfVRo3dTs9cEUxfvLopA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130218142834.28739.39417.sendpatchset@w520>
	<20130227082335.GB30395@linux-sh.org>
In-Reply-To: <20130227082335.GB30395@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca, horms@verge.net.au, tglx@linutronix.de

On Wed, Feb 27, 2013 at 5:23 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Mon, Feb 18, 2013 at 11:28:34PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> This patch adds a driver for external IRQ pins connected
>> to the INTC block on recent SoCs from Renesas.
>>
> So how exactly does this interact with the existing sh_intc code? Or is
> there some reason why you have opted to bypass it in order to implement a
> simplified reduced-functionality version of INTC support focused only on
> external pins? If both are used together this is going to be a nightmare
> for locking, and it's also non-obvious how the IRQ domains on both sides
> will interact.
>
> This needs a lot more explanation.

Recent GIC-based SoCs do not make use of INTC for any on-chip I/O
devices. This driver is meant to be used as a layer between the actual
IRQ pin and the GIC. Anything else needs the full driver. The existing
non-DT INTC driver can happily coexist with this driver like it does
in the case of sh73a0 here:

[PATCH 02/03] ARM: shmobile: INTC External IRQ pin driver on sh73a0

The driver is not meant to be used with INTC-only based systems like
sh7372 and the SH architecture. I would be very happy if someone could
get their shit together and fix up DT support for the common INTC
code. This has not happened yet though. So if you know anyone with
time to spare then feel free to suggest them to work together with
Iwamatsu-san to get the DT version of the code reviewed together with
Linaro.

Thanks,

/ magnus
