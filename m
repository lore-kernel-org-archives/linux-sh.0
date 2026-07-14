Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77393F0AB8
	for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784015275; cv=none; b=NQ57ARD2UGKA+ypxRC151S1CRuRtTp4dQI5FCMs0stVJwpVdn3AhFAmQDHuB90nBSnwooSCFbV9v7uEPBIFHZNKk9ZM+ZhkgnpTdhgpzZ4x+uiRUB5Xuhar09YA6v07CI5qZun28jotsEREFsCx9aiEW9ZS7FtnDsHADHskB+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784015275; c=relaxed/simple;
	bh=2zDe0w91X6EY+1XLlwusOqS/yelcCqF76ymdkbIKDQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4svqghtmeOvwLasefuEuxM/G6up6TAh6u7QrJjcwKUBdq7k+dX3ugwhEpXjWhXAVHRwxGZOG+iFfEpwYOXcG2w+1wmQpdOkf3SQbF0seoBcyISTDCH476q7/YuoIn0HBCcJa1rUBx8EAypi43wHoqzkZxWV8DY0TCfoWTdNP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdcAoXoE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdcAoXoE"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-475417f010dso1827444f8f.2
        for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784015271; x=1784620071; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qb41bDsJpNfkX+m419br8C04+ccbwx2pEq76BdCMQuk=;
        b=UdcAoXoEr9rC8KSSfOtUzSmHYZVc6urTofTsAFo5bsZNVztpQBD+gPHA3W53XP8gGh
         37OEKb9bSdtvgKjSDnJeVXDrPrjEdFoGoN/e3J1QBv/7J9ZWPX/MAN5tD6wvrVG0d1cx
         lnqizsyTYxl23icUn2apHuwk5RvdGm32SXipqGCS7aaL+aFE2H6EEATREk1aqp/vnHJk
         FNGDbAL8hr1046W1R0kvudGjzgk7Y9kotsutBGvzwMvUpBP3CXv/dpDPYX64JIMYchd4
         Laol0xNtmkPZT1Ilo7ZNq+wvS21azCBMza52St34tE2RooOhBc1IkVuEeyYBjKy1PvVw
         acgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784015271; x=1784620071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qb41bDsJpNfkX+m419br8C04+ccbwx2pEq76BdCMQuk=;
        b=JnRHTKzL7n3sgE2XzaKCnx58us+3DliqOQi2cxyEqYUU6nfq51HYndAmIWyoyHfQ0I
         JY3zLGv+IMnzEPWy6dHkfcfCgwTiAP/de2l3veqkZnd2i9ALQM4HqzUZ56tnWsRb1N/Y
         PmM0xV4pAj+O2ZN66+D39X/Orm7V4dzrmWkZBOLc6Z2NzqEOmlM5onFmanJrEZqPZkah
         Y6j/ZAW0r1YWRlcp6nd+ab7C0OdyhrfBIJmwJOAmU048DrEyYX0ph8OVH3f6cMV9T6ex
         NI2/CJ+ZCkAsy9XoAohq5RzfVUTpJ1LLcDsoujF+TfL5S2uCyjizHtJTrG27SsQglHh1
         tDXA==
X-Forwarded-Encrypted: i=1; AHgh+RrNSbgVZPasLBJ8JYERj31ZtwXlv5ijLczPT++PKTtX7BC5eMPkWBEZ2lm+zkFztR8tNVa93ddf5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDvWnB3eBUqW7ofm2BBiICGjCMr3vVeebHY0cZx7uwlvrEF2m
	uigwCItOWtSb/k/2woxmNN//D/q1mKbNiSUG6UI5TIhHGL02PiL/D5fgiMdBlxg=
X-Gm-Gg: AfdE7cl3nTxnft5Z5YheL6Ufj3AIMRp4ybvYwa/CPv/uD8+3imxH6ChdsxPEAAkk01N
	AmpjzsQd3e3uvTBzQivBxRRXoCR9y161wrRR+S4ICjxi7FhUJwdopo2XnclW8RTxT7Oz2W+aOXn
	3nPWrbU4v/x1CPeuBIhhZYxjsFmPwlTDLxNIStR7jVGPht1NobZmFozkEtXdzi+MFLldjvHy0uB
	jGAXB+10I6aufqOl5JJQwMp5O/b6dQ0blqAKJqHhCkB5CbBW+zrt4OEskWWIv/QHTfcsxQb6c7n
	FtqZpExEqSVzxGGWKjlp5BWDQNYJsxA3edjZTvklTr1JNqKSMDVobwJ6QPEb/t/hukMEIbB7Klc
	WnvCooObbhBtnxbn/w0x7wZ3anTpscbLJ/yAKTMUd3SaJ1Z0Ra6QsltmMJpQUhU5gaDETI05pGV
	DM99G0Ss2eJUdCx0AyXTk9UoRkGl+lKRoKlPok5oFF/KA1Ge9w08XUPXD0g4hjjALE
X-Received: by 2002:a05:6000:240f:b0:475:f0f0:9f01 with SMTP id ffacd0b85a97d-47f2dd05108mr14242453f8f.56.1784015270714;
        Tue, 14 Jul 2026 00:47:50 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:bae1:d42b:869:1dc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464bbb0esm6131622f8f.28.2026.07.14.00.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:47:50 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:47:44 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rob Landley <rob@landley.net>, linux-sh <linux-sh@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: Toybox make root no longer works as expected
Message-ID: <alXpoJOjg5HrSvhE@lithos>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>

On 30 Apr 08:57, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Wed, 2026-04-29 at 09:46 +0200, John Paul Adrian Glaubitz wrote:
> > I'm trying to build a new root image after updating Toybox but that no longer works:
> > 
> > glaubitz@node54:/data/home/glaubitz/toybox> make root CROSS=sh2eb-linux-muslfdpic- LINUX=/data/home/glaubitz/sh-linux
> > mkroot/mkroot.sh  -- LINUX=/data/home/glaubitz/sh-linux CROSS=sh2eb-linux-muslfdpic-
> > No ccc symlink to compiler directory.
> > make: *** [Makefile:108: root] Error 1
> > glaubitz@node54:/data/home/glaubitz/toybox>
> > 
> > It asks me to create a "ccc" symlink but I have no clue where that link is supposed
> > to point to. The FAQ says the link is supposed to »pointing at a directory full of
> > cross compilers« but I don't have that and that's not my personal setup. I have the
> > cross compilers installed in my home directory and their bin directories added to
> > the PATH variable which has always worked in the past without any problems.
> > 
> > Can you explain how that "ccc" symlink works?
> 
> OK, for some reason it works now. Unfortunately, the toolchain doesn't like the current kernel:
> 
>   CC      net/ipv4/inetpeer.o
> during RTL pass: final
> In file included from kernel/nstree.c:8:
> kernel/nstree.c: In function '__se_sys_listns':
> ./include/linux/syscalls.h:261:9: internal compiler error: in change_address_1, at emit-rtl.c:2275
>   261 |         }                                                               \
>       |         ^
> ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
>   236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>       |         ^~~~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:228:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>   228 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>       |                                    ^~~~~~~~~~~~~~~
> kernel/nstree.c:763:1: note: in expansion of macro 'SYSCALL_DEFINE4'
>   763 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
>       | ^~~~~~~~~~~~~~~
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <https://gcc.gnu.org/bugs/> for instructions.
> {standard input}: Assembler messages:
> {standard input}: Warning: end of file not at end of a line; newline inserted
> {standard input}:1592: Error: missing operand
> {standard input}:1592: Error: invalid operands for opcode
> {standard input}:976: Error: displacement to undefined symbol .L339 overflows 12-bit field
> {standard input}:1014: Error: displacement to undefined symbol .L459 overflows 12-bit field
> {standard input}:1028: Error: displacement to undefined symbol .L340 overflows 12-bit field
> {standard input}:1040: Error: displacement to undefined symbol .L461 overflows 12-bit field
> {standard input}:1060: Error: displacement to undefined symbol .L462 overflows 12-bit field
> {standard input}:1082: Error: displacement to undefined symbol .L463 overflows 12-bit field
> {standard input}:1100: Error: displacement to undefined symbol .L252 overflows 12-bit field
> {standard input}:1201: Error: displacement to undefined symbol .L286 overflows 12-bit field
> {standard input}:1211: Error: displacement to undefined symbol .L468 overflows 12-bit field
> {standard input}:1221: Error: displacement to undefined symbol .L298 overflows 12-bit field
> {standard input}:1234: Error: displacement to undefined symbol .L469 overflows 12-bit field
> {standard input}:1256: Error: displacement to undefined symbol .L349 overflows 12-bit field
> {standard input}:1341: Error: displacement to undefined symbol .L314 overflows 12-bit field
> {standard input}:1488: Error: displacement to undefined symbol .L454 overflows 8-bit field 
> {standard input}:1498: Error: displacement to undefined symbol .L471 overflows 8-bit field 
> make[3]: *** [scripts/Makefile.build:289: kernel/nstree.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 
> Adrian

I also crafted a bit with gcc-17, and my first issue was a duplicate
symbols (LPCS0) compiling libgcc like in
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89012 I could only work
around with explicitly using O1 instead of O2 in INTERNAL_CFLAGS of gcc.

And errors with libbacktrace, I worked around by --enable-languages=c

I got gcc to not ICE, but it then fails with invalid assembler thats why
I became suspicious about the asm in question. turns out, delcaring the
adresses as offsetable, seems to "fix" the ICE and compile and work for
fdpic, means it is maybe not necessarily only a GCC issue.

diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
index 5d7ddc092afd..cef40414bfb1 100644
--- a/arch/sh/include/asm/uaccess_32.h
+++ b/arch/sh/include/asm/uaccess_32.h
@@ -92,7 +92,7 @@ __asm__ __volatile__( \
 	".long	1b + 2, 3b\n\t" \
 	".previous" \
 	:"=&r" (err), "=&r" (x) \
-	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
+	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
 #else
 #define __get_user_u64(x, addr, err) \
 ({ \
@@ -116,7 +116,7 @@ __asm__ __volatile__( \
 	".long	1b + 2, 3b\n\t" \
 	".previous" \
 	:"=&r" (err), "=&r" (x) \
-	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
+	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
 #endif
 
 #define __put_user_size(x,ptr,size,retval)		\
@@ -196,7 +196,7 @@ __asm__ __volatile__( \
 	".long	1b, 3b\n\t" \
 	".previous" \
 	: "=r" (retval) \
-	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
+	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
         : "memory"); })
 #else
 #define __put_user_u64(val,addr,retval) \
@@ -218,7 +218,7 @@ __asm__ __volatile__( \
 	".long	1b, 3b\n\t" \
 	".previous" \
 	: "=r" (retval) \
-	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
+	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
         : "memory"); })
 #endif
 
-- 
2.43.0

Then there is register clobbering in the sh2 shift helpers, thats a
separate runtime issue.

Regards
Florian
