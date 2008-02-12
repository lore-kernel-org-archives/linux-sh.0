From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Tue, 12 Feb 2008 09:36:12 +0000
Subject: Re: [PATCH] SH/Dreamcast - improve detection of attached
Message-Id: <20080212103612.be92e70a.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1202689502.6237.23.camel@localhost.localdomain>
In-Reply-To: <1202689502.6237.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 12 Feb 2008 17:24:25 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Mon, Feb 11, 2008 at 12:25:02AM +0000, Adrian McMenamin wrote:
> > Improve device detection for maple through longer delay
> > 
> > Experience suggests that a much longer delay in setting up the Maple bus
> > on the Dreamcast leads to better hardware detection.
> > 
> > Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> > 
> > -----
> > 
> 3 -'s only. Not 5, 3.
> 
> Patch subjects should follow the format of 'subsystem: description'. In
> this case, 'maple: improve detection of attached peripherals'.
> 
> On Mon, Feb 11, 2008 at 06:41:49PM +0100, Kristoffer Ericson wrote:
> > Greetings,
> > 
> > shortlog:
> > This patch removes defunct. led support functions from hp6xx.h since they are now 
> > added in a proper driver (see commit below). Also adds tabs instead of spaces before comments.
> > 
> > *commit d39a7a63eb3971b1b3cc5c181ed526bf437b1c72
> > 
> This goes directly in to the commit log. You do not need a greeting, and
> you do not need a shortlog:. Provide a meaningful subject, and then a
> short and concise description in the body, nothing more, and nothing
> less. Also, please ensure that you do not go beyond 80 cols in the text
> of your body. This not only applies to patch descriptions, but also to
> any mail you send to the list.
> 

Ah, that I didn't know. Thought everything after the shortlog was 
automaticly cut&pasted. Thx.

> Also, no attachments or MIME damage of any sort. If you aren't sure
> whether your mailer will mangle the inline patch or not, send it to
> yourself until you have it working.

I wasn't aware my attachments was being mangled in anyway, I'll test on 
myself until I got it sorted.

> 
> > signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> > 
> Signed-off-by. With an upper-case S.

Roger.

> 
> I suggest you both re-read Documentation/SubmittingPatches and look out
> for deviations. This stuff is documented incredibly clearly, and yet
> there is constant trouble with this for whatever reason. Beyond that,
> please try applying your patches to a test tree with git-am _before_
> sending it to the list. You will very quickly see what needs to be
> corrected.
> 
> I don't mind fixing these things up and merging the patches by hand from
> time to time, but when every single patch submission requires manual
> mangling, it simply gets to be a headache.
> 
> Please try to follow the established conventions in the future. It will
> save everyone a lot of time.

Thx for info paul. I'll do that.
