From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 21 Apr 2014 21:09:58 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <2700964.dizX6m2xFI@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 21 April 2014 12:22:02 Geert Uytterhoeven wrote:
> On Mon, Apr 21, 2014 at 11:50 AM, Laurent Pinchart wrote:
> > On Monday 21 April 2014 10:31:14 Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >> 
> >> A simple serial port integration prototype that happens to
> >> target Koelsch. Written to propose how to move one step closer
> >> to integrate DT support for serial ports on mach-shmobile.
> > 
> > I think you've over-engineering it. I would just switch serial devices to
> > DT in one go, like we do for all other devices.
> 
> Having the backwards-compatibility mode for DTSes without the main
> serial console is nice, though. But I agree that we shouldn't introduce
> more steps than necessary.

Sure, that could be useful during development when you regularly have to 
switch between different DTs files. However I don't think we should add too 
many of such hacks to the mainline kernel. Given that we can easily switch in 
one go, I believe the patch can be kept out-of-tree.

> FWIW, I've been using your "ARM: shmobile: koelsch: Enable SCIF0 and SCIF1
> serial ports in DT" on and off.

I keep them in all my working branch and haven't run into any issue so far, so 
I think they should be pretty stable now. Thank you for testing them.

> Last time I tried together with "of: Enable console on serial ports
> specified by /chosen/stdout-path", which allows to boot without any
> "console=" parameters at all.

That's a nice patch, I wasn't aware of it. How is the baud rate selected in 
that case ?

-- 
Regards,

Laurent Pinchart

