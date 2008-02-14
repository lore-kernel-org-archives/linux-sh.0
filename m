From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 14 Feb 2008 09:34:20 +0000
Subject: Re: [PATCH] SH/Dreamcast - improve detection of attached
Message-Id: <20080214103420.73ec6c89.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1202689502.6237.23.camel@localhost.localdomain>
In-Reply-To: <1202689502.6237.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 12 Feb 2008 10:23:40 -0500
Mike Frysinger <vapier@gentoo.org> wrote:

> is there a reason you guys dont use git to submit your patches ?  it does take 
> time to learn if you arent familiar, but the time spent more than pays off in 
> the long wrong ... it takes care of all these fun bits for you.  a shortened 
> list for arbitrary developers:

I use git daily to maintain the jlime kernel source repository, don't use it to create patches though.

> 1. < make changes to git repo >
> 2. git add < files you want to commit >
> 3. git commit -s
>  - first line is the subject (so you have to follow convention yourself)
>  - one blank line
>  - paragraph for body of changelog
> so the example commit log would be (just the stuff between the dashes):
> ----------------------------
> SH/Maple/Dreamcast: improve detection of attached peripherals
> 
> Blah blah blah this is the long subject explaining why this is wanted.
> 
> Signed-off-line: automatically-added-by-the-s-flag
> ----------------------------
> 4. git-format-patch HEAD^

This assumes that your patch is the only diff against current HEAD right? I have loads of changes, so need
to pick out the certain commit. I usually do "git diff origin > mypatch.patch" The format patch adds other stuff?

> 5. git-send-email --to linux-sh@vger.kernel.org <list of patches produced>

That I should use more often.

> 6. git reset --hard HEAD^
> 
> i'm lazy and dont create branches for the small one-off changes.  so you guys 
> doing more work would probably want to create a branch before doing the work.  
> in that case, just replace "HEAD^" with like "master" to generate patches of 
> all the commits made to your branch.
> -mike
> 

My repositories are based on linus tree, but I should create a branch towards linux-sh (got seperate tree for that).

Big thanks for tips, I guess its worth learning all aspects of git.



