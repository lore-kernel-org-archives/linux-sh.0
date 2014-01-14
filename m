From: Mike Turquette <mturquette@linaro.org>
Date: Tue, 14 Jan 2014 19:44:41 +0000
Subject: Re: [PATCH V2 0/2] clk: shmobile: clk-mstp fixes
Message-Id: <20140114194441.7168.37136@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Simon Horman (2014-01-09 17:07:01)
> [ CC Ben Dooks ]
> 
> On Mon, Jan 06, 2014 at 08:33:17PM +0400, Valentine wrote:
> > On 12/30/2013 01:54 AM, Mike Turquette wrote:
> > >Quoting Valentine Barshak (2013-12-28 04:09:07)
> > >>This fixes a number of issues with CPG MSTP clock array handling.
> > >
> > >Thanks for the quick respin. Taken into clk-next.
> > 
> > Sorry, I don't see it in https://git.linaro.org/people/mike.turquette/linux.git/shortlog/refs/heads/clk-next
> > Is this the right place to look for?
> 
> Hi Mike,
> 
> I'm not seeing them there either.
> 
> Also, I would like to pull these changes into my "devel" branch
> as they fix problems that developers are hitting. If I could use
> an updated clk-next-shmobile branch that includes these patches
> and commit ids that won't change I would be most grateful.

Hi all,

Thanks for your persistence. This was sitting in a local branch for a
while and I forgot to merge it into clk-next. I've updated the
clk-next-shmobile branch to include these patches and I have applied all
Acks and Tested-bys. That branch includes some other patches as well but
it shouldn't be a problem for a development branch.

I've also merged clk-next-shmobile into clk-next and pushed out to my
Linaro mirror.

Regards,
Mike

> 
> Thanks.
