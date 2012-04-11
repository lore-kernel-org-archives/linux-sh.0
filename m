From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Apr 2012 04:28:05 +0000
Subject: Re: [PATCH v2] serial: sh-sci: modify sci_break_ctl()
Message-Id: <20120411042805.GC19696@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7E3FE2.4050902@renesas.com>
In-Reply-To: <4F7E3FE2.4050902@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 06, 2012 at 02:39:00PM +0900, Shimoda, Yoshihiro wrote:
> 2012/04/06 14:11, Simon Horman wrote:
> > On Fri, Apr 06, 2012 at 12:50:00PM +0900, Shimoda, Yoshihiro wrote:
> >>
> >> If userland calls ioctl with TIOCSBRK/TIOCCBRK, the sci_break_ctl
> >> is called. After TIOCSBRK we cannot send data from SCIF.
> >> After TIOCCBRK, we can send data from SCIF.
> > 
> > Thanks, that make a lot of sense.
> > 
> > Unfortunately the ecovec doesn't exercise the new code
> > as the regtype of its scif is SCIx_SH4_SCIF_NO_SCSPTR_REGTYPE
> > but your code only operates on SCIx_SH4_SCIF_REGTYPE.
> 
> Sorry I forgot that the SH7724 has SCIF and SCIFA.
> The ecovec uses SCIF, and it doesn't have SCSPTR.

Well, one thing that you can do is test for the SCSPTR existence and
simply not care about the port type. This is roughly what the generic
sci_init_pins() does for example.

You would have to ensure that the bits you are twiddling also exist for
the SCIx_SH2_SCIF_FIFODATA_REGTYPE, SCIx_SH2_SCIF_FIFODATA_REGTYPE, and
SCIx_SH4_SCIF_FIFODATA_REGTYPE, though.

> I checked the ecovec schematics, but it cannot use SCIFA because
> other functions use the multiplex pins.
> 
You should be able to plug them in for the port and let the sh-sci driver
try to grab the port. The port will simply be skipped if pin demux fails.
Take a look at 50f0959ad4f9ac1c5ee208bb820de299a1b3730b for an idea of
how to wire it up.
