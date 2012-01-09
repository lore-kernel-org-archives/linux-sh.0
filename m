From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Jan 2012 01:44:01 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: r8a7779 SMP support V2
Message-Id: <20120109014401.GH25648@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111222081730.12133.61045.sendpatchset@w520>
In-Reply-To: <20111222081730.12133.61045.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 28, 2011 at 05:00:48PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch contains r8a7779 SMP support V2 - now including
> CPU hotplug offine and online support. The r8a7779 power
> domain code is tied together with SMP glue code which allows
> us to control the power domains via CPU hotplug.
> 
> At this point the kernel boots with the 4 Cortex-A9 cores in
> SMP mode and all CPU cores except CPU0 can be hotplugged.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Depends on the r8a7779 base plus the power domain code:
>  [PATCH] ARM: mach-shmobile: r8a7779 power domain support
> 
Not sure how you want to handle this. I can take the power domain code
since it's the initial merge, or I can just push out the base stuff I
have now, Rafael can merge the power domain stuff on top, and then we can
add the SMP support at a later stage. There won't be a lot of time for
multiple merges this merge window, though.

In any event, I'm not entirely pleased with the direction the platsmp
code is going. Either layer in some function pointers that the CPU code
can set up, add some weak symbols, or move the small bit of common code
somewhere actually common rather than trying to shoe-horn everything in
and then relying on this absurd is_xxx() check (which in itself is
nothing but glorified ifdef abuse).
