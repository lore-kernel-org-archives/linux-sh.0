From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 19 May 2012 18:32:09 +0000
Subject: Re: [PATCH 0/8] irqdomain cleanups + identity mapping support
Message-Id: <20120519183209.2C6BF3E03B8@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1337407908-7421-1-git-send-email-lethal@linux-sh.org>
In-Reply-To: <1337407908-7421-1-git-send-email-lethal@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 19 May 2012 15:11:40 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
> Here's the current patch stack I've got against the irqdomain code, which
> is about what I need to start being able to reasonably start converting
> the SH INTC subsystem over to it.
> 
> This whole series is also available via git at:
> 
> 	git://github.com/pmundt/linux-sh.git common/irqdomain
> 
> but I've not yet created a signed tag to pull from as there's likely
> still a fair bit of work to do. The diffstat looks innocuous enough, but
> is obviously of no real value in this case:

I'll look though and cherry pick the patches that I think are ready.

g.

