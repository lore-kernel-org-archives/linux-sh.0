From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 28 Dec 2015 10:10:27 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: LPAE memory bank CMA assignment prototype
Message-Id: <2868316.ceRkbP7uHp@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20151219014005.6274.87661.sendpatchset@little-apple>
In-Reply-To: <20151219014005.6274.87661.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Monday 28 December 2015 12:17:15 Magnus Damm wrote:
> On Sun, Dec 27, 2015 at 5:51 PM, Laurent Pinchart wrote:
> > On Saturday 19 December 2015 10:40:05 Magnus Damm wrote:
> >> From: Magnus Damm <damm+renesas@opensource.se>
> >> 
> >> This prototype patch extends the kernel to also reserve CMA memory
> >> in the top memory bank on R-Car Gen2 boards and ties this larger
> >> CMA area to the DU device for testing purpose.
> >> 
> >> This top portion of the memory requires 40-bits addressing support
> >> in bus master devices including LPAE for the ARM CPU cores.
> >> 
> >> The patch assigns a 512 MiB CMA area to the DU device that may be
> >> used with the IPMMU hardware to perform 40-bit bus master access.
> >> Without IPMMU the DU hardware only supports 32-bit addresses.
> >> 
> >> Tested on r8a7791 Koelsch HDMI output using the modetest utility:
> >> # modetest -M rcar-du -s 33:1024x768@AR24
> >> 
> >> Not for upstream merge.
> > 
> > I tried to understand where the setup-rcar-gen2.c code you're patching
> > came from. Due to a rebase the commit message of 83850b04ae77 ("ARM:
> > shmobile: rcar-gen2: Update for of_get_flat_dt_prop() update") is
> > incorrect, but I've traced the original commit to ae8bf91c80b0 ("ARM:
> > shmobile: Add shared R-Car Gen2 CMA reservation code") in Simon's tree.
> 
> Right, I recall adding that CMA reservation code.
> 
> > That patch doesn't look like a very good approach to me, and neither does
> > this one :-) drivers/staging/board is a hack, and we're starting to abuse
> > it.
>
> At the time the Gen2 CMA reservation code was written there was no DT
> memory reservation support available.

Good point.

> Regarding this patch, it is just a proof of concept to test allocation
> from a high memory address without modifying any hardware description.
> 
> > I don't want to see board code coming back through the back door. What's
> > wrong with just reserving memory in DT with the reserved-memory bindings
> > and assigning it to the DU ?
> 
> Describing device-to-memory bank assignment in DT equals mixing
> software policy with hardware description. I prefer to keep the
> software policy in C and the hardware description in DT.
> 
> If you think there are better ways to reserve memory, why don't you
> cook up a counter proposal and post it in a public space? =)

Doing it in DT is the better way in my opinion :-) There are established DT 
bindings for that purpose, and that's what upstream is using.

-- 
Regards,

Laurent Pinchart

