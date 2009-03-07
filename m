From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 07 Mar 2009 06:12:08 +0000
Subject: Re: [PATCH] sh: hibernation support
Message-Id: <20090307061208.GB14735@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090306064156.27281.35572.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2009 at 11:05:35AM +0100, Francesco VIRLINZI wrote:
> >>Is it also for sh4 with PMB? If so how are you managing the PMB?
> >>Moreover what about interrupt controller? This means after a resume from
> >>hibernation
> >>you could have a resumed device (and driver) but the interrupt controller
> >>has the right irq-line not initialized.
> >>    
> >
> >I have not tested with PMB.
> On PMB: some entries may be is already OK (the entries the bootloader 
> prepared fot linux)
> but Linux has to force an hw-initialization of the other entries

Yes, this is something we need to add in to the patch, other platforms
have similar issues with their IOMMUs for example. Overall this is quite
trivial though, we just need to add a bit of logic to the PMB management
code to register a nosave region and copy over the memory-mapped PMB
entries. PowerPC already has similar code-paths for the same sort of
thing.
