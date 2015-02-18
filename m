From: Simon Horman <horms@verge.net.au>
Date: Wed, 18 Feb 2015 21:20:27 +0000
Subject: Re: [PATCH v3 00/15] r8a7778 CCF and multiplatform
Message-Id: <20150218212027.GC12754@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424105939-4910-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424105939-4910-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Ulrich,

On Mon, Feb 16, 2015 at 05:58:44PM +0100, Ulrich Hecht wrote:
> Hi!
> 
> Here's the CCF/MP support for r8a7778 and Bock-W again.  This revision again
> attempts to incorporate all suggestions made and should be more successful
> in that than the last one.  Thank you for the reviews and acks, the changes
> made are detailed below.
> 
> CU
> Uli
> 
> 
> Changes since v2:
> - minor reformatting and code styling
> - renamed *SCU_SRC* -> *SRU_SRC*
> - updated DT bindings to match implementation
> - removed unused Ethernet pins from bockw DT
> - renamed sound node to conform to standards
> - retooled external Ethernet compatible list
> - added more Acks
> 
> Changes since v1:
> - added oki,ml86v7667 to trivial-devices.txt
> - added internal ethernet controller
> - moved pins from external to internal ethernet controller
> - added bsc bus, moved external ethernet controller there
> - removed extal from CPG driver and made it a fixed clock
> - renamed "scu*" clocks to "scu-src*"
> - split SoC/board CCF enablement from CPG driver
> - added "smsc,lan89218" compat string to external net controller
> - added missing clock-names to tmu nodes
> - named Kconfig entry properly
> - added Acks
> 
> 
> Ulrich Hecht (15):
> * ARM: shmobile: r8a7778: synchronize dts with reference platform
> * ARM: shmobile: r8a7778: add CPG register bits header
> * ARM: shmobile: r8a7778: Common clock framework DT description
>   ARM: shmobile: r8a7778: common clock framework CPG driver
> * ARM: shmobile: r8a7778: implement SoC and board CCF support
> * ARM: shmobile: r8a7778: add MSTP clock assignments to DT
>   ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
> * ARM: shmobile: r8a7778: add internal ethernet controller to DT
> * ARM: shmobile: bockw: add USB, VIN pin descriptions to DT
>   ARM: shmobile: r8a7778: add sound to DT
>   ARM: shmobile: bockw: add sound to DT
>   ARM: shmobile: r8a7778: enable multiplatform target
> * ARM: shmobile: r8a7778 dtsi: Add Bus State Controller node
> * ARM: shmobile: bockw dts: Move Ethernet node to BSC
> * ARM: shmobile: bockw dts: set extal clock frequency

I have queued up the patches marked with '*'.

I will now comment briefly on the patches that I have not queued up.

* ARM: shmobile: r8a7778: common clock framework CPG driver

  As noted in another email: This is a clock driver and needs to either an
  Ack from Mike Turquette or for him to take the patch through his tree. I
  have asked him about providing the former in a reply to that patch.

* ARM: shmobile: bockw: add devices hooked up to i2c0 to DT

  As noted in another email: I think the binding change should
  be broken out.

  And that the binding change should most likely accepted before being used.

* ARM: shmobile: r8a7778: add sound to DT
* ARM: shmobile: bockw: add sound to DT

  These depend on:
  "ARM: shmobile: bockw: add devices hooked up to i2c0 to DT"

* ARM: shmobile: r8a7778: enable multiplatform target

  I have omitted this as the result does not compile due to the
  omission of "ARM: shmobile: r8a7778: common clock framework CPG driver"
