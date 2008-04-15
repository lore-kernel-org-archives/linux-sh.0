From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Apr 2008 18:30:23 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.25
Message-Id: <20080415183023.GA23098@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>

On Tue, Apr 15, 2008 at 11:01:36AM -0700, Linus Torvalds wrote:
> On Wed, 16 Apr 2008, Paul Mundt wrote:
> >
> > Please pull from:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.25.git
> 
> Paul, your git tree is odd. Not quite corrupt, but it doesn't really 
> follow the rules either.
> 
> In particular, it has empty lines at the top of those commits, and I 
> wonder how you created them. 
> 
> Doing things like "git log" will ignore the spurious empty lines, but they 
> can be seen with things like "git cat-file", eg
> 
> 	git cat-file commit fd785d6b18b930b76ad5076eed6e9af43195b281 
> 
> and I wonder if you used a buggy version of git, or whether you perhaps 
> have some scripts that import these commits from the outside and uses some 
> low-level commands that can generate these kinds of subtly bogus commits.

It was a combination of mbox munging and git-am, I checked with git log
and thought things were ok, but I wasn't aware that it stripped out empty
lines. cat-file shows that it was just the 2 patches from Andrew that had
this particular problem. I had stripped out the subject and thought the
first line would be used for the merge summary, but it looks like git-am
simply wrote out an empty line and inserted one after that before the
rest of the summary.

I've pushed out updated patches that have this corrected, so please pull
again.
