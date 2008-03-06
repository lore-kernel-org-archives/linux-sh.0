From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Mar 2008 04:37:57 +0000
Subject: Re: Various section mismatches
Message-Id: <20080306043757.GA18164@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1202080862.9936.4.camel@localhost.localdomain>
In-Reply-To: <1202080862.9936.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 03, 2008 at 11:21:02PM +0000, Adrian McMenamin wrote:
>   LD      drivers/video/built-in.o
> WARNING: drivers/video/built-in.o(.text+0xd980): Section mismatch in reference from the function pvr2fb_check_var() to the variable .devinit.data:pvr2fb_pci_tbl
> The function  pvr2fb_check_var() references
> the variable __devinitdata pvr2fb_pci_tbl.
> This is often because pvr2fb_check_var lacks a __devinitdata 
> annotation or the annotation of pvr2fb_pci_tbl is wrong.
> 
These should all basically be fixed by now. This was the only outstanding
one, and was a bit of a pain to track down since DEBUG_SECTION_MISMATCH
didn't seem to have any clue what it was talking about. A few updates
later it managed to get a bit closer to the actual offending symbol
(presently it's convinced that pvr2_fix is the proble, which is at least
quite a bit closer to reality), but was still wrong. The problem ended up
being the pvr2_var.vmode reference in pvr2fb_check_var(), which I just
replaced with an explicit reference to FB_VMODE_NONINTERLACED. I'll push
that out for 2.6.25, and hopefully that should be the last of them.
