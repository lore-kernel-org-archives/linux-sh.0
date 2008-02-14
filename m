From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Feb 2008 10:14:50 +0000
Subject: Re: [PATCH] SH/Dreamcast - improve detection of attached peripherals
Message-Id: <20080214101450.GA14287@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1202689502.6237.23.camel@localhost.localdomain>
In-Reply-To: <1202689502.6237.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2008 at 10:34:20AM +0100, Kristoffer Ericson wrote:
> On Tue, 12 Feb 2008 10:23:40 -0500
> Mike Frysinger <vapier@gentoo.org> wrote:
> > 1. < make changes to git repo >
> > 2. git add < files you want to commit >
> > 3. git commit -s
> >  - first line is the subject (so you have to follow convention yourself)
> >  - one blank line
> >  - paragraph for body of changelog
> > so the example commit log would be (just the stuff between the dashes):
> > ----------------------------
> > SH/Maple/Dreamcast: improve detection of attached peripherals
> > 
> > Blah blah blah this is the long subject explaining why this is wanted.
> > 
> > Signed-off-line: automatically-added-by-the-s-flag
> > ----------------------------
> > 4. git-format-patch HEAD^
> 
> This assumes that your patch is the only diff against current HEAD right? I have loads of changes, so need
> to pick out the certain commit. I usually do "git diff origin > mypatch.patch" The format patch adds other stuff?
> 
git-format-patch will generate a diff for the range you specify. You can
either use a commit-id as a reference, or track the SH tree in a separate
branch and use the symbolic branch name as a reference. HEAD^ will just
pop one off of HEAD.

> > 5. git-send-email --to linux-sh@vger.kernel.org <list of patches produced>
> 
> That I should use more often.
> 
As git-send-email takes a list of patches, you don't need to bother with
cherry picking or anything like that, you can explicitly just select the
ones to send.

git is there to make your life easier, not harder. It helps to use it for
what you can. Note however that I do rebase my tree frequently, so I
don't particularly encourage people to branch off of it. During non
merge-window times, there's basically no reason to reference my tree.
