From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 17 Jul 2008 14:46:34 +0000
Subject: Re: [PATCH] sh2(A) exception handler update
Message-Id: <8763r4y3ed.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87vdzfowr0.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87vdzfowr0.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At Thu, 17 Jul 2008 16:09:43 +0900,
Paul Mundt wrote:
> 
> On Thu, Jul 10, 2008 at 01:20:03AM +0900, Yoshinori Sato wrote:
> > This patch is
> > 
> > By sh2
> > - Remove duplicate code
> > - Reduce stack usage
> > - Cleanup and little optimize 
> > 
> > By sh2a
> > - Add missing handler(256 to 511)
> > - Use sh2a instructions handler
> > 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > 
> There still seems to be something buggy here, which may or may not be
> toolchain related. Booting the current git kernel, does the 'ps aux'
> output look sane on your board?

Hmm...
'ps aux' is unfinished.
proc readdir is return non NULL always.

I check it.

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
