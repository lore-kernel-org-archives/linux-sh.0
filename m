From: Alex Riesen <raa.lkml@gmail.com>
Date: Wed, 16 Apr 2008 18:54:49 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.25
Message-Id: <20080416185449.GA27015@steel.home>
List-Id: <linux-sh.vger.kernel.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org> <20080415183023.GA23098@linux-sh.org> <alpine.LFD.1.00.0804151222350.2879@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0804151222350.2879@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>

Linus Torvalds, Tue, Apr 15, 2008 21:56:50 +0200:
> 
> 
> On Wed, 16 Apr 2008, Paul Mundt wrote:
> > 
> > It was a combination of mbox munging and git-am, I checked with git log
> > and thought things were ok, but I wasn't aware that it stripped out empty
> > lines. cat-file shows that it was just the 2 patches from Andrew that had
> > this particular problem. I had stripped out the subject and thought the
> > first line would be used for the merge summary, but it looks like git-am
> > simply wrote out an empty line and inserted one after that before the
> > rest of the summary.
> 
> Ahh, looks like a git-am buglet then. It will indeed turn an empty subject 
> line into an empty first line.
> 
> We should run "git stripspace" on the whole thing, so maybe a patch 
> something like the appended will help.
> 
> NOTE! Totally untested! Beware the patch!
> 

t4014-format-patch.sh broke. It probably has to be updated

