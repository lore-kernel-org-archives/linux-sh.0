From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 10:18:18 +0000
Subject: Re: [PATCH] sh2(A) exception handler update
Message-Id: <20080728101818.GA14825@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87vdzfowr0.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87vdzfowr0.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jul 19, 2008 at 03:35:50PM -0400, Yoshinori Sato wrote:
> I think this problem is GCC(4.1.2) bug.
> Syscall "getdents" returned "dirent->d_off" is always 0.
> I think other EB enviroment have same problem.
> 
> Problem code
> 0c03c954 <filldir>:
>  :
>  c03c97a:       58 f7           mov.l   @(28,r15),r8 !-> offset (high)
>  c03c97c:       59 f8           mov.l   @(32,r15),r9 !-> offset (low)
>  c03c97e:       53 f9           mov.l   @(36,r15),r3
>  c03c980:       54 fa           mov.l   @(40,r15),r4
>  :
>  c03c9a0:       21 82           mov.l   r8,@r1 !offset(high) -> dirent->d_off
> 
> It's workaround patch.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
Good catch! Applied, thanks.
