From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 09 Aug 2020 19:21:57 +0000
Subject: Re: [regression fix] Re: "sh: convert to ->regset_get()" breaks linux-sh build
Message-Id: <CAHk-=wi1ocV0dk=DXLgT01Eqg0Xnm65Hfq44=8p5yPu8=jrt5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200809174508.GA3026725@ZenIV.linux.org.uk>
In-Reply-To: <20200809174508.GA3026725@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Aug 9, 2020 at 10:45 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, there are several ways to handle that.  One is to pull vfs.git#fixes -
> that's the first commit of #regset.followups.  Another is to cherry-pick
> the same.  And the minimal fix would be the subset of that commit as below.
> Linus, what would you prefer?

Mind just sending me a proper pull request for the fixes branch with
that one commit?

               Linus
