From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat, 19 Jul 2008 19:35:50 +0000
Subject: Re: [PATCH] sh2(A) exception handler update
Message-Id: <87hcalwtt5.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87vdzfowr0.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87vdzfowr0.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

At Thu, 17 Jul 2008 10:46:34 -0400,
Yoshinori Sato wrote:
> 
> At Thu, 17 Jul 2008 16:09:43 +0900,
> Paul Mundt wrote:
> > 
> > On Thu, Jul 10, 2008 at 01:20:03AM +0900, Yoshinori Sato wrote:
> > > This patch is
> > > 
> > > By sh2
> > > - Remove duplicate code
> > > - Reduce stack usage
> > > - Cleanup and little optimize 
> > > 
> > > By sh2a
> > > - Add missing handler(256 to 511)
> > > - Use sh2a instructions handler
> > > 
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > > 
> > There still seems to be something buggy here, which may or may not be
> > toolchain related. Booting the current git kernel, does the 'ps aux'
> > output look sane on your board?
> 
> Hmm...
> 'ps aux' is unfinished.
> proc readdir is return non NULL always.
> 
> I check it.

OK. I'm fixed.

I think this problem is GCC(4.1.2) bug.
Syscall "getdents" returned "dirent->d_off" is always 0.
I think other EB enviroment have same problem.

Problem code
0c03c954 <filldir>:
 :
 c03c97a:       58 f7           mov.l   @(28,r15),r8 !-> offset (high)
 c03c97c:       59 f8           mov.l   @(32,r15),r9 !-> offset (low)
 c03c97e:       53 f9           mov.l   @(36,r15),r3
 c03c980:       54 fa           mov.l   @(40,r15),r4
 :
 c03c9a0:       21 82           mov.l   r8,@r1 !offset(high) -> dirent->d_off

It's workaround patch.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

diff --git a/include/asm-sh/uaccess_32.h b/include/asm-sh/uaccess_32.h
index ae0d24f..d3baea8 100644
--- a/include/asm-sh/uaccess_32.h
+++ b/include/asm-sh/uaccess_32.h
@@ -76,7 +76,7 @@ do {							\
 		__put_user_asm(x, ptr, retval, "w");	\
 		break;					\
 	case 4:						\
-		__put_user_asm(x, ptr, retval, "l");	\
+		__put_user_asm((u32)x, ptr, retval, "l");	\
 		break;					\
 	case 8:						\
 		__put_user_u64(x, ptr, retval);		\

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
