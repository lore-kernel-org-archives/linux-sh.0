From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 30 Apr 2014 06:18:29 +0000
Subject: Re: [RFC/PATCH 6/6] ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <1667554.lgOS1qWJLo@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wednesday 30 April 2014 04:55:22 Magnus Damm wrote:
> On Wed, Apr 30, 2014 at 12:31 AM, Laurent Pinchart wrote:
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

The commit message is definitely wrong, and for some reason the aliases are 
missing from the patch. Sorry about that. I'll resubmit.

-- 
Regards,

Laurent Pinchart

