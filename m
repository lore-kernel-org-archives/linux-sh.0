From: Simon Horman <horms@verge.net.au>
Date: Sun, 14 Nov 2010 23:22:55 +0000
Subject: Re: [patch v3 2/2] ARM: mach-shmobile: Add zboot support for
Message-Id: <20101114232255.GA19510@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20101014091231.858799238@vergenet.net>
	<20101014091434.501864612@vergenet.net>
	<20101107172310.GG1759@n2100.arm.linux.org.uk>
	<20101108015714.GB15671@verge.net.au>
In-Reply-To: <20101108015714.GB15671@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 08, 2010 at 10:57:14AM +0900, Simon Horman wrote:
> On Sun, Nov 07, 2010 at 05:23:10PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Oct 14, 2010 at 06:12:33PM +0900, Simon Horman wrote:
> > > +LIST "partner-jet-setup.txt"
> > > +LIST "(C) Copyright 2010 Renesas Solutions Corp"
> > > +LIST "Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>"
> > > +
> > > +LIST "RWT Setting"
> > > +EW 0xE6020004, 0xA500
> > > +EW 0xE6030004, 0xA500
> > 
> > Can you explain the necessity of this special scripting language, and
> > where it comes from?
> > 
> > It looks like the file implementing the scripting language comes from
> > something other than Linux, but it isn't clear what the licensing is
> > of that.  Please confirm that it is GPL'd.
> 
> Hi Russell,
> 
> The aim is to allow JTAG scripts to be used in-place.
> The script is constructed from ASM macros which are defined
> in arch/arm/mach-shmobile/include/mach/zboot_macros.h which is
> included later on in the patch. The same macros exist in SH assembly
> in arch/sh/include/asm/romimage-macros.h.
> 
> With regards to the license, I have confirmed that it is GPL.
> Would you be more comfortable if that was stated explicitly
> in the new files?

Hi Russell,

I'm wondering if you have had any time to consider this series again.

Thanks

