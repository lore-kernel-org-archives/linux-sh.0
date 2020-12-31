Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82820C433E0
	for <linux-sh@archiver.kernel.org>; Thu, 31 Dec 2020 23:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F02A207A5
	for <linux-sh@archiver.kernel.org>; Thu, 31 Dec 2020 23:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgLaXXs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 31 Dec 2020 18:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgLaXXs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 31 Dec 2020 18:23:48 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5121C061573;
        Thu, 31 Dec 2020 15:23:07 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kv7HZ-005p0B-7o; Thu, 31 Dec 2020 23:23:01 +0000
Date:   Thu, 31 Dec 2020 23:23:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [sh] fix trivial misannotations
Message-ID: <20201231232301.GG3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

	Trivial misannotations in
* get_user() (__gu_addr is a userland pointer there)
* ip_fast_csum() (sum is __wsum, not unsigned int)
* csum_and_copy_to_user() (destination is void *, not const void * - mea culpa)
* __clear_user() (to is a userland pointer)
* several places in kernel/traps_32.c (regs->pc is a userland pointer when regs is a
userland pt_regs)
* math-emu/math.c: READ() and WRITE() casts of address should be to userland pointer.

No changes in code generation and those take care of the majority of noise from sparse
on sh builds.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index 1a391e3a7659..a6501b856f3e 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -84,7 +84,8 @@ static inline __sum16 csum_fold(__wsum sum)
  */
 static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
 {
-	unsigned int sum, __dummy0, __dummy1;
+	__wsum sum;
+	unsigned int __dummy0, __dummy1;
 
 	__asm__ __volatile__(
 		"mov.l	@%1+, %0\n\t"
@@ -197,6 +198,6 @@ static inline __wsum csum_and_copy_to_user(const void *src,
 {
 	if (!access_ok(dst, len))
 		return 0;
-	return csum_partial_copy_generic((__force const void *)src, dst, len);
+	return csum_partial_copy_generic(src, (__force void *)dst, len);
 }
 #endif /* __ASM_SH_CHECKSUM_H */
diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index 73f3b48d4a34..8867bb04b00e 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -68,7 +68,7 @@ struct __large_struct { unsigned long buf[100]; };
 ({									\
 	long __gu_err = -EFAULT;					\
 	unsigned long __gu_val = 0;					\
-	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
+	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);			\
 	if (likely(access_ok(__gu_addr, (size))))		\
 		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
@@ -124,7 +124,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
  * Clear the area and return remaining number of bytes
  * (on failure.  Usually it's 0.)
  */
-__kernel_size_t __clear_user(void *addr, __kernel_size_t size);
+__kernel_size_t __clear_user(void __user *addr, __kernel_size_t size);
 
 #define clear_user(addr,n)						\
 ({									\
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index b62ad0ba2395..b3c715bc254b 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -490,7 +490,7 @@ asmlinkage void do_address_error(struct pt_regs *regs,
 		inc_unaligned_user_access();
 
 		oldfs = force_uaccess_begin();
-		if (copy_from_user(&instruction, (insn_size_t *)(regs->pc & ~1),
+		if (copy_from_user(&instruction, (insn_size_t __user *)(regs->pc & ~1),
 				   sizeof(instruction))) {
 			force_uaccess_end(oldfs);
 			goto uspace_segv;
@@ -614,7 +614,7 @@ asmlinkage void do_reserved_inst(void)
 	unsigned short inst = 0;
 	int err;
 
-	get_user(inst, (unsigned short*)regs->pc);
+	get_user(inst, (unsigned short __user *)regs->pc);
 
 	err = do_fpu_inst(inst, regs);
 	if (!err) {
@@ -699,9 +699,9 @@ asmlinkage void do_illegal_slot_inst(void)
 		return;
 
 #ifdef CONFIG_SH_FPU_EMU
-	get_user(inst, (unsigned short *)regs->pc + 1);
+	get_user(inst, (unsigned short __user *)regs->pc + 1);
 	if (!do_fpu_inst(inst, regs)) {
-		get_user(inst, (unsigned short *)regs->pc);
+		get_user(inst, (unsigned short __user *)regs->pc);
 		if (!emulate_branch(inst, regs))
 			return;
 		/* fault in branch.*/
diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index e8be0eca0444..3495a48b7713 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -51,8 +51,8 @@
 #define Rn	(regs->regs[n])
 #define Rm	(regs->regs[m])
 
-#define WRITE(d,a)	({if(put_user(d, (typeof (d)*)a)) return -EFAULT;})
-#define READ(d,a)	({if(get_user(d, (typeof (d)*)a)) return -EFAULT;})
+#define WRITE(d,a)	({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
+#define READ(d,a)	({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
 
 #define PACK_S(r,f)	FP_PACK_SP(&r,f)
 #define UNPACK_S(f,r)	FP_UNPACK_SP(f,&r)
diff --git a/arch/sh/mm/nommu.c b/arch/sh/mm/nommu.c
index 8b4504413c5f..78c4b6e6d33b 100644
--- a/arch/sh/mm/nommu.c
+++ b/arch/sh/mm/nommu.c
@@ -28,9 +28,9 @@ __kernel_size_t __copy_user(void *to, const void *from, __kernel_size_t n)
 	return 0;
 }
 
-__kernel_size_t __clear_user(void *to, __kernel_size_t n)
+__kernel_size_t __clear_user(void __user *to, __kernel_size_t n)
 {
-	memset(to, 0, n);
+	memset((__force void *)to, 0, n);
 	return 0;
 }
 
