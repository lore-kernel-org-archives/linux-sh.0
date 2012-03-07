From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 07 Mar 2012 02:32:12 +0000
Subject: Re: [PATCH 00/17] sh and mach-shmobile struct sh_clk_ops rename
Message-Id: <20120307023211.GA10151@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120229131605.29154.8330.sendpatchset@w520>
In-Reply-To: <20120229131605.29154.8330.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 06, 2012 at 11:24:20PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, March 06, 2012, Paul Mundt wrote:
> > There are a few ways to do this I suppose. A common topic branch that we
> > can pull in to either the SH or ARM side makes sense. We can do the
> > entire series in one topic branch that gets merged twice and we just make
> > sure that no rebasing takes place, or we can do patches 1-2 on a common
> > branch, then 3-8 on an rmobile branch based on the common on, 9-16 on an
> > sh one, and then leave 17 for the end of the merge window.
> > 
> > Ultimately it depends on how much more work there is going to be done
> > built on top of this. The sh changes are minimal, so I'm not too worried
> > about merge conflicts even if we just keep all of these batched together.
> 
> OK, so would you mind if I created a clk_ops-rename branch in the renesas
> tree at git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git
> and put the whole $subject series into it?
> 
Sounds fine to me.
