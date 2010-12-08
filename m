From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 08 Dec 2010 04:40:52 +0000
Subject: Re: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
Message-Id: <20101208044052.GA31508@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<201012071515.25418.vapier@gentoo.org>
In-Reply-To: <201012071515.25418.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 07, 2010 at 03:15:23PM -0500, Mike Frysinger wrote:
> On Tuesday, December 07, 2010 05:20:53 Filippo ARCIDIACONO wrote:
> > Add stack smashing suppurt for SH architecture. This is based on work
> > from Nicolas Pitre for ARM (c743f38013aeff58ef6252601e397b5ba281c633).
> > Use the ARM boot_init_stack_canary function to initialize the guard
> > canary. It has been placed under asm-generic to allow archtectures
> > based on __stack_chk_guard to use a common implementation.
> > Update the __stack_chk_guard global variable with the value stored in
> > the task struct whenever a task switch occurs to allow for different
> > canary values per task. This cannot work on SMP where the initial
> > canary value is always used.
> > 
> >  arch/sh/Kconfig                      |   13 +++++++++++
> >  arch/sh/Makefile                     |    4 +++
> >  arch/sh/include/asm/stackprotector.h |   10 ++++++++
> >  arch/sh/kernel/process_32.c          |    9 +++++++
> >  include/asm-generic/stackprotector.h |   39
> 
> if you're starting asm-generic stuff, why not go the distance and do it all in 
> common code ?  your sh/Kconfig and sh/Makefile changes arent specific to 
> SuperH, nor is the symbol in process_32.c.

Indeed. It would be nice to simply shove this in to lib/ with the
Makefile bits in the top-level Makefile. 
