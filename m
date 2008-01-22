From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jan 2008 12:32:27 +0000
Subject: Re: debian etch sh3 and sh4
Message-Id: <20080122123227.GA8587@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <82C85C285793D5ebiharaml@si-linux.com>
In-Reply-To: <82C85C285793D5ebiharaml@si-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 22, 2008 at 11:54:16AM -0000, Adrian McMenamin wrote:
> On Tue, January 22, 2008 12:37 am, Paul Mundt wrote:
> > These sorts of efforts seem to pop up almost every other year, and then
> > quickly fall in to disarray. The same can be said for the Fedora Core
> > ports. Is there a plan to have this work merged back in to Debian proper,
> > and to keep it updated?
> >
> > Currently Gentoo is the only viable option for a reasonably maintained
> > port, and the only one supported upstream. Seeing Debian or Fedora Core
> > in the same state would be nice, but the porters need to get serious
> > about what their goals are. A one-shot build is obsolete before it hits
> > the mailing list.
> 
> Whilst I obviously accept a lot of what Paul says is true, I wanted to
> record my appreciation of the effort and let you know that the core at
> least runs on the Dreamcast (though I need to fix it up properly to get
> the filesystem to work).
> 
> If this was going to be a supported project in the longer term I'd be
> willing to consider providing space and bandwidth for a European mirror.
> 
The problem is that this is still just a stop-gap solution. Debian
already has all of the mirror infrastructure in place, so the only thing
that needs to happen is effort to get this work integrated. If that's not
going to happen, this simply isn't going to go anywhere. We've seen this
with both the Debian and the Fedora Core ports in the past, and there's
no reason to imagine things will be any different this time. It's nice to
see that people are putting effort in to this, but without a push to get
it supported upstream, it will simply bitrot like all of the other ports.
This is the reality of things, good intentions aside.

> On gentoo - the link on the wiki points to sources that are 18 months
> old... is there something more up to date?

It points to stage tarballs that are still usable. You of course need
to update once you have it set up on your platform, but the stage
tarballs are a starting point only. There are updates every day, and this
continues to be the only maintained port.
