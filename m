From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 May 2010 04:49:57 +0000
Subject: Re: Missing of "Uncompressing Linux... " message at boot sequence
Message-Id: <20100506044957.GB25493@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BDFCEF4.8010607@dcl.info.waseda.ac.jp>
In-Reply-To: <4BDFCEF4.8010607@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 04, 2010 at 04:38:28PM +0900, Hitoshi Mitake wrote:
> In arch/sh/boot/compressed/misc.c the function puts() is defined like this:
> 
> int puts(const char *s)
> {
> 	/* This should be updated to use the sh-sci routines */
> 	return 0;
> }
> 
> Of course this makes no output.
> So I cannot see the message "Uncompressing Linux... Ok, booting the 
> kernel." now.
> # The change was made at abec86a80247ab3a40d2afc9c8e8c26efcab2391
> 
> So I have a question:
> Do you have any plan to revive the "Uncompressing" message?
> 
I suppose you ran in to this because you are one of the few people still
using sh-bios. The current sh-bios code has been generalized a fair bit,
but we could restore this functionality if it ends up being useful for
you.

In my experience the sh-bios implementation has been unreliable at the
best of times, so this early puts stuff was never really useful in the
first place. I suspect there are also outstanding issues with trapping in
to the bios after the system has booted, as this code doesn't see much
use in general.

> The comment says that puts() should use the routines of sh-sci.
> But sh-sci is the thing built in vmlinux, so I think using it from 
> misc.c is hard.
> To revive it, big change will be required.
> 
Correct. The idea was to reuse parts of the sh-sci code, rather than
linking it in directly. If it were just a simple case we could have
easily accomodated this through the header alone and simply inlined it,
but unfortunately there is not enough consistency between CPUs to make
this terribly realistic. This is largely why things like the sh-bios
abstraction exists in the first place.

> If you have a plan to revive the message, I'd like to co-operate.
> Because I'm working on new board support, serial output is a big problem 
> for me.
> 
I'll have a look at restoring it, but be forewarned that there will
likely be outstanding sh-bios issues. If you're able to assist with
debugging this then of course I have no problem with reinstanting this
sort of support.
