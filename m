From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 04 Jul 2009 15:40:15 +0000
Subject: Re: [PATCH] sh: hwblk base implementation
Message-Id: <20090704154014.GE9933@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 03, 2009 at 07:08:05PM +0900, Magnus Damm wrote:
> This patch is the hwblk base implementation, containing
> structures and shared functions dealing with hardware blocks.
> 
> A each processor model should provide a list of hwblks and 
> describe which module stop bit that is associated with each
> hwblck and how the hwblks are grouped together into areas.
> 
> The shared code keeps track of the usage count for each
> hwblk and the areas. Fallback implementations for processor
> specific code are also kept as weak symbols.
> 
> The clock framework, the runtime pm code and cpuidle will
> all tie into this hwblk implementation.

On Fri, Jul 03, 2009 at 07:15:25PM +0900, Magnus Damm wrote:
> This patch contains the sh7722 specific hwblk implementation.
> 
> Hwblk ids are added to the processor specific header file,
> module stop bits and areas are kept track of as hwblks,
> clocks are converted to make use of the shared hwblk code.
> Code to determine allowed sleep modes is also added.

On Fri, Jul 03, 2009 at 07:28:00PM +0900, Magnus Damm wrote:
> This patch adds cpuidle support for SuperH Mobile.
> 
> The sleep mode selected by cpuidle is compared with
> the mode selected by the hwblk sleep code and the
> best allowed mode is entered.
> 
> At this point "Sleep mode" and "Sleep mode + SF" are
> supported. This code can easily be extended to support
> "Software suspend mode", but the assembly code must
> first be updated to avoid loosing interrupts.
> 
> Also, update the code to only copy the assembly snippet
> into internal memory once at bootup.

All applied, thanks.
