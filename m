From: Simon Horman <horms@verge.net.au>
Date: Wed, 30 Apr 2014 06:24:03 +0000
Subject: Re: [RFC/PATCH 6/6] ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <20140430062400.GB5153@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 30, 2014 at 04:55:22AM +0000, Magnus Damm wrote:
> On Wed, Apr 30, 2014 at 12:31 AM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > SCIF0 and SCIF1 are used as debug serial ports. Enable them and
> > configure pinmuxing appropriately. We can now remove the clkdev
> > registration hack for SCIF devices from the Koelsch reference board
> > file.
> >
> > As a side effect of switching to DT-based serial port instantiation,
> > ttySC6 and ttySC7 get renamed to ttySC0 and ttySC1. As the device tree
> > source if now shared between koelsch and koelsch-reference, we need to
> > update the serial ports in C code as well.
> 
> Hi Laurent,
> 
> Thanks for your efforts. I'm a bit confused, because I thought we
> agreed on keeping the serial order intact earlier?
> 
> With that in mind, shouldn't aliases be updated in this patch to avoid
> rename of ttySC6 and 7?

Given that the patch for the lager contains the aliases required
to avoid the rename I believe that this is an oversight.

For the record I have things working with the following incremental patch.


diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 99a4452..05d44f9 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -19,6 +19,11 @@
 	model = "Koelsch";
 	compatible = "renesas,koelsch", "renesas,r8a7791";
 
+	aliases {
+		serial6 = &scif0;
+		serial7 = &scif1;
+	};
+
 	chosen {
 		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
