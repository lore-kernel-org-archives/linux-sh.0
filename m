From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Date: Tue, 19 Apr 2011 16:28:47 +0000
Subject: Re: sh:fixed issue in xchg_u32 function when val==r15.
Message-Id: <4DADB83F.5080301@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050006050908000401090305"
List-Id: <linux-sh.vger.kernel.org>
References: <4D9DB4A5.4010002@st.com>
In-Reply-To: <4D9DB4A5.4010002@st.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------050006050908000401090305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,
Thanks for the suggestion.

Attached is the reworked patch for potential gUSA rollback users.

Thanks,
srini


Paul Mundt wrote:
> On Thu, Apr 07, 2011 at 01:57:09PM +0100, Srinivas KANDAGATLA wrote:
>   
>> Recently we have discovered a bug in xchg_u32 function of GUSA_RB feature.
>> This function breaks if one of the input parameter 'val' is r15.
>>
>>     168:    02 c7           mova    174 <exit_mm+0x54>,r0
>>     16a:    09 00           nop   
>>     16c:    f3 61           mov    r15,r1
>>     16e:    fc ef           mov    #-4,r15
>>     
>
> The -4 here is part of the gUSA login sequence, so if you're seeing the
> problem with gUSA based xchg_u32 it seems like you're going to have to
> apply the same fix for all gUSA rollback users.
>   


--------------050006050908000401090305
Content-Type: text/x-patch;
 name="0001-sh-fixed-issue-in-xchg_u32-xchg_u8-and-__cmpxchg_u32.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-sh-fixed-issue-in-xchg_u32-xchg_u8-and-__cmpxchg_u32.pa";
 filename*1="tch"

From 49cab63ad11688c9b526dc8d14318cad5351cf47 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Date: Wed, 13 Apr 2011 16:22:03 +0100
Subject: [PATCH sh-2.6.32.y] sh: fixed issue in xchg_u32, xchg_u8 and __cmpxchg_u32 function.

This patch addresses a use-case when one of the input parameter to
xchg_u32 or xchg_u8 or __cmpxchg_u32 inline asm function is equal to
r15(stack-pointer).

For example:
Code in exit_mm() function passes address of structure(val) to xchg_u32
which is basically a stack pointer(r15). xchg_u32 always sets m to
-4(0xfffffffc). Which is incorrect(Actual Bug).

Considering there could be one or more instances of this kind in the
current or future code, this patch is must if gUSA is used.

This patch adds input parameters to input/output constraint so that
compiler cannot pass r15 directly and must use a temporary register
instead.
Also reorders the parameters in __cmpxchg_u32 to fit to the order they
are declared.

Originally this bug was discovered as part of stlinux bugzilla##11229
triage.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Reviewed-by: Stuart Menefy <stuart.menefy@st.com>
---
 arch/sh/include/asm/cmpxchg-grb.h |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/sh/include/asm/cmpxchg-grb.h b/arch/sh/include/asm/cmpxchg-grb.h
index 4676bf5..509cd33 100644
--- a/arch/sh/include/asm/cmpxchg-grb.h
+++ b/arch/sh/include/asm/cmpxchg-grb.h
@@ -15,8 +15,10 @@ static inline unsigned long xchg_u32(volatile u32 *m, unsigned long val)
 		"   mov.l   %2,   @%1     \n\t" /* store new value */
 		"1: mov     r1,   r15     \n\t" /* LOGOUT */
 		: "=&r" (retval),
-		  "+r"  (m)
-		: "r"   (val)
+		  "+r"  (m),
+		  "+r"  (val) /* if val == r15 function doesn' work as expected
+				* So val is added to output constriants */
+		:
 		: "memory", "r0", "r1");
 
 	return retval;
@@ -36,8 +38,10 @@ static inline unsigned long xchg_u8(volatile u8 *m, unsigned long val)
 		"   mov.b   %2,   @%1     \n\t" /* store new value */
 		"1: mov     r1,   r15     \n\t" /* LOGOUT */
 		: "=&r" (retval),
-		  "+r"  (m)
-		: "r"   (val)
+		  "+r"  (m),
+		  "+r"  (val) /* if val == r15 function doesn' work as expected
+				* So val is added to output constriants */
+		:
 		: "memory" , "r0", "r1");
 
 	return retval;
@@ -54,13 +58,14 @@ static inline unsigned long __cmpxchg_u32(volatile int *m, unsigned long old,
 		"   nop                   \n\t"
 		"   mov    r15,   r1      \n\t" /* r1 = saved sp */
 		"   mov    #-8,   r15     \n\t" /* LOGIN */
-		"   mov.l  @%1,   %0      \n\t" /* load  old value */
-		"   cmp/eq  %0,   %2      \n\t"
+		"   mov.l  @%3,   %0      \n\t" /* load  old value */
+		"   cmp/eq  %0,   %1      \n\t"
 		"   bf            1f      \n\t" /* if not equal */
-		"   mov.l   %3,   @%1     \n\t" /* store new value */
+		"   mov.l   %2,   @%3     \n\t" /* store new value */
 		"1: mov     r1,   r15     \n\t" /* LOGOUT */
-		: "=&r" (retval)
-		:  "r"  (m), "r"  (old), "r"  (new)
+		: "=&r" (retval),
+		  "+r"  (old), "+r"  (new) /* old or new can be r15 */
+		:  "r"  (m)
 		: "memory" , "r0", "r1", "t");
 
 	return retval;
-- 
1.6.3.3


--------------050006050908000401090305--
