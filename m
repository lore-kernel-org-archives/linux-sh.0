From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 22 Apr 2010 06:30:19 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <20100422063019.GA11424@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 22, 2010 at 03:22:06PM +0900, Alexandre Courbot wrote:
> >> We are also trying to get the latest Linux to run on the SH2007
> >> platform, and since the new serial driver boot fails during SCIF
> >> intialization. I have attached a boot log of what is sent to the
> >> serial line. The output gets cut right in the middle of displaying
> >> status for sh-sci.1. Any clue on that issue would be greatly
> >> appreciated.
> >
> > Is the SH2007 board based on sh7780? Perhaps it's a clock issue.
> 
> It's a 7780 indeed. I'm not a specialist of the SH platform (still
> learning), but I'll try to look at this from a clock perspective. FYI,
> the early printk is done through the bios.

Your command line is word wrapped so it's not apparent what options you
are using. One noticeable difference for sh-bios users in sh-sci is the
detach callback via sh_bios_gdb_detach(), you might want to try
commenting this out to make sure you're not trapping in to some bogus
location. If the sh-bios earlyprintk is working for you then you might
also try the 'keep' option to prevent the serial console from taking
control away from it.
