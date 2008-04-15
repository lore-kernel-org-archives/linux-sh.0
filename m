From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Apr 2008 18:18:39 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.25
Message-Id: <alpine.LFD.1.00.0804151115250.2879@woody.linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080415172333.GA29489@linux-sh.org> <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>



On Tue, 15 Apr 2008, Linus Torvalds wrote:
> 
> Paul, your git tree is odd. Not quite corrupt, but it doesn't really 
> follow the rules either.

Anyway, I pulled the result (with my version of git that removes empty 
space at the beginning for the merge summary), and pushed it out. So it's 
merged, but I'd still like to know what tool actually created those extra 
spaces in the commit..

A regular "git commit" or "git am" should always strip whitespace. I 
assume it's something like stgit or other?

				Linus
