Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CA1314A84
	for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025998; cv=none; b=aJ8OElymWb2LEWFqqqxEEBcsDHiWqiFYcCySKWz9M3OLT6shZjUBxwL32753hy9DjM49eWkplgJ5XkjNLHsTpNFummBHmRSbQJN10iY/HDRdr/3H1ZuNRLFpsJ7wGEWkw+/xZgWyGTkVIYeAsZUVuveDP6bveKWapTaR0mBqxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025998; c=relaxed/simple;
	bh=TI3NocqUhaBP5KFTUCI4mCe68MJoQ1rg/WNYKuGb1Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1wr486RJdqEj1AmsOyMdbEzTGHowD3NpJYd6CT8xnfWtblr4spogk97MzMBb5af5ynoVFEiORcZLqaYrjJZ0LsHPqgQOnm+cO892Jq02sCH+eYxRU1ds6vKfHKkwSKsPsvcYurgEDwzfmnugcn4gvO5X7TJwa4zadXDEKMvo2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCvA0dj2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCvA0dj2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso30300875e9.0
        for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784025995; x=1784630795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g20+noaAQJJgtA/zWQmtQMomDACltOjRyQBbQnllF5k=;
        b=CCvA0dj2ZwuN2HWtlFJk2UGIwlfCB63J+lS8Wgp1r8GS0RactAkfMIMi/Y7zd90ZjH
         ECgRH3hmbcBa2iP3F59KYPqOvd1bq4EE0a+R6gfQOcKbPeVfRLwcQEygRfVVu//5nSpw
         XPT8gfHbDEqF4uyOoRJxTFRMH4CT7NUSYZFJUDKbmh6mB4aujBuML0Mcbein6jEROy62
         5KChkseIL2Ss+zstIGctd3TJBCARso9X/EG74Q4G7csC9k9UJ/rurGAGWKFfpC97viDP
         yuBshPvvEwxOtz7w503RKPaElKROHb0UDVqQmx28lGocGXs6WzDDjWkb9QcyfZDjOuCu
         HiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784025995; x=1784630795;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g20+noaAQJJgtA/zWQmtQMomDACltOjRyQBbQnllF5k=;
        b=jjtL2Mw68LaYURzpTCg9V7SZIKCaOYWpkYDmZ/Ds1RrooUxcmb5iZmqO/k+KnfkELw
         4ZaooufbxmGMsNFlLn8nhTPBJHO3DBeO9JpIdWC2cAY/nB3+WHtOXQRdLYZqzUdsfxOa
         T0zg67OP9BIy0nmBgTPTu/15yj4C7WWCO/ehOgOdP8DRtr3jcopSlMVv3ntuGc78bp3z
         UEgYxSB4qfNSWRhwxbIiSaarju6EBKfd+XbiIFFLIoUhlw6GDQQ6Ut4SvSfB+pTK84QV
         7dtbysPky0z56PPN3SzMol/+rapAj37ssiPxorZd7Uyw1iremWy/rD5Z0Eq8I5zkB7ye
         Ywsg==
X-Forwarded-Encrypted: i=1; AHgh+RqasDlsu162gCJaeA3P0sgc0kTrVesGoZPp5+WfrKPWTjhGTgLQA8DRQ6sYrXfbVf8A1TiBsdBXyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQrdFvGgASE+pBOBvjFn2dbDbkHRhYoyAoWd7b+ZUF/6tsoM63
	ncv39fAI1gOCVd46IWO2vAk0kaEJcPngWzUzkyzUA4QvKnKi7+oT2bgzkjEzOx8=
X-Gm-Gg: AfdE7cnPspKWnWTKAf5nfVGtXk6QhHgW+ptLQr2z9quCDs6hShOj3FlAiXxJsIX4GwL
	V6nM4h8bz3gS0M8EzVKbMXZO8gstcQhl2+d3CZG5kcSawU1b9JDeFayE3FOHexv0ujsjiXrf+fW
	0mfnUhiL/SQViOFG0v3hrTxx2bhWlAOBL76i/Z0odVvac5IK/Pty10fzpKXUGWzmTDwtgBwSktJ
	gysO9TnKXweEj1OGk4eO7EvMAdk9jY+Ez3bVDA1O4Ea116VS5LhjAyih+QPpH7gsyPSx8tDZGDw
	KLWjN225hjCakDWLTQi3gauN1U/n2PNEammm1u4Lq9j1BS8Wq6YlC9yO8B9YJuWVmC/sNS1Qave
	8msLeOtsJyFYYKwBMspXoZgerIeeQYgaiVc/fVOL7RTQYm/kLJ28Loh2btC8PAO1/NL6P6TGQBA
	zVxpm4nhmNhg9n+v9LMvo7Yxf2d69Xri2Dlf49xMJnTO5OlED8px36TY9HKRAAeB02
X-Received: by 2002:a05:600c:c87:b0:493:fd5b:2d5c with SMTP id 5b1f17b1804b1-49515904a8dmr30751305e9.22.1784025994860;
        Tue, 14 Jul 2026 03:46:34 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:bae1:d42b:869:1dc8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508739c99sm63622365e9.9.2026.07.14.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:46:34 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:46:29 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rob Landley <rob@landley.net>, linux-sh <linux-sh@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: Toybox make root no longer works as expected
Message-ID: <alYThehhPbqgcOn2@lithos>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
 <alXpoJOjg5HrSvhE@lithos>
 <3eeb0f60a3f133bfd3ab5467b35045c904b8a9e8.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eeb0f60a3f133bfd3ab5467b35045c904b8a9e8.camel@physik.fu-berlin.de>

On 14 Jul 10:14, John Paul Adrian Glaubitz wrote:
> Hi Florian,
> 
> On Tue, 2026-07-14 at 09:47 +0200, Florian Fuchs wrote:
> > > OK, for some reason it works now. Unfortunately, the toolchain doesn't like the current kernel:
> > > 
> > >   CC      net/ipv4/inetpeer.o
> > > during RTL pass: final
> > > In file included from kernel/nstree.c:8:
> > > kernel/nstree.c: In function '__se_sys_listns':
> > > ./include/linux/syscalls.h:261:9: internal compiler error: in change_address_1, at emit-rtl.c:2275
> > >   261 |         }                                                               \
> > >       |         ^
> > > ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
> > >   236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> > >       |         ^~~~~~~~~~~~~~~~~
> > > ./include/linux/syscalls.h:228:36: note: in expansion of macro 'SYSCALL_DEFINEx'
> > >   228 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
> > >       |                                    ^~~~~~~~~~~~~~~
> > > kernel/nstree.c:763:1: note: in expansion of macro 'SYSCALL_DEFINE4'
> > >   763 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
> > >       | ^~~~~~~~~~~~~~~
> > > Please submit a full bug report,
> > > with preprocessed source if appropriate.
> > > See <https://gcc.gnu.org/bugs/> for instructions.
> > > {standard input}: Assembler messages:
> > > {standard input}: Warning: end of file not at end of a line; newline inserted
> > > {standard input}:1592: Error: missing operand
> > > {standard input}:1592: Error: invalid operands for opcode
> > > {standard input}:976: Error: displacement to undefined symbol .L339 overflows 12-bit field
> > > {standard input}:1014: Error: displacement to undefined symbol .L459 overflows 12-bit field
> > > {standard input}:1028: Error: displacement to undefined symbol .L340 overflows 12-bit field
> > > {standard input}:1040: Error: displacement to undefined symbol .L461 overflows 12-bit field
> > > {standard input}:1060: Error: displacement to undefined symbol .L462 overflows 12-bit field
> > > {standard input}:1082: Error: displacement to undefined symbol .L463 overflows 12-bit field
> > > {standard input}:1100: Error: displacement to undefined symbol .L252 overflows 12-bit field
> > > {standard input}:1201: Error: displacement to undefined symbol .L286 overflows 12-bit field
> > > {standard input}:1211: Error: displacement to undefined symbol .L468 overflows 12-bit field
> > > {standard input}:1221: Error: displacement to undefined symbol .L298 overflows 12-bit field
> > > {standard input}:1234: Error: displacement to undefined symbol .L469 overflows 12-bit field
> > > {standard input}:1256: Error: displacement to undefined symbol .L349 overflows 12-bit field
> > > {standard input}:1341: Error: displacement to undefined symbol .L314 overflows 12-bit field
> > > {standard input}:1488: Error: displacement to undefined symbol .L454 overflows 8-bit field 
> > > {standard input}:1498: Error: displacement to undefined symbol .L471 overflows 8-bit field 
> > > make[3]: *** [scripts/Makefile.build:289: kernel/nstree.o] Error 1
> > > make[3]: *** Waiting for unfinished jobs....
> > > 
> > > Adrian
> > 
> > I also crafted a bit with gcc-17, and my first issue was a duplicate
> > symbols (LPCS0) compiling libgcc like in
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89012 I could only work
> > around with explicitly using O1 instead of O2 in INTERNAL_CFLAGS of gcc.
> > 
> > And errors with libbacktrace, I worked around by --enable-languages=c
> > 
> > I got gcc to not ICE, but it then fails with invalid assembler thats why
> > I became suspicious about the asm in question. turns out, delcaring the
> > adresses as offsetable, seems to "fix" the ICE and compile and work for
> > fdpic, means it is maybe not necessarily only a GCC issue.
> > 
> > diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
> > index 5d7ddc092afd..cef40414bfb1 100644
> > --- a/arch/sh/include/asm/uaccess_32.h
> > +++ b/arch/sh/include/asm/uaccess_32.h
> > @@ -92,7 +92,7 @@ __asm__ __volatile__( \
> >  	".long	1b + 2, 3b\n\t" \
> >  	".previous" \
> >  	:"=&r" (err), "=&r" (x) \
> > -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> > +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> >  #else
> >  #define __get_user_u64(x, addr, err) \
> >  ({ \
> > @@ -116,7 +116,7 @@ __asm__ __volatile__( \
> >  	".long	1b + 2, 3b\n\t" \
> >  	".previous" \
> >  	:"=&r" (err), "=&r" (x) \
> > -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> > +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> >  #endif
> >  
> >  #define __put_user_size(x,ptr,size,retval)		\
> > @@ -196,7 +196,7 @@ __asm__ __volatile__( \
> >  	".long	1b, 3b\n\t" \
> >  	".previous" \
> >  	: "=r" (retval) \
> > -	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
> > +	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
> >          : "memory"); })
> >  #else
> >  #define __put_user_u64(val,addr,retval) \
> > @@ -218,7 +218,7 @@ __asm__ __volatile__( \
> >  	".long	1b, 3b\n\t" \
> >  	".previous" \
> >  	: "=r" (retval) \
> > -	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
> > +	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
> >          : "memory"); })
> >  #endif
> >  
> 
> Thanks a lot for looking into this, I appreciate the help!
> 
> Did you manage to build a J2 toolchain using GCC 17? I have not looked
> into it myself yet due to time constraints, but I would like to switch
> to a newer compiler to build test kernels for my J2.
> 
> Adrian

Yes, with the O1 workaround in gcc and the above patch, but I did a
shortcut and built a plain sh2eb/fdpic toolchain, so I didn't rebase the
bigger J2 specific patches, only a few lines fdpic specific. So that I
could build a kernel, busybox/toybox with it. As I just wanted to finally
boot a current linux on the J2 Mimas v2 board.

And the ICE in nstree.c/uaccess was still there with gcc-17, that went
away with the above patch.

For the Mimas v2 I also needed to configure some offsets differntly in
the .config/Makefiles [0], but that may be normal. Ah, and it needed the patch
regarding the built-in DTBs, that don't work currently [1] And at
runtime it needed this patch, to prevent the register clobber [2]

[0] Offsets, specific (I guess) to the mimas v2 board, copied from the
    original aboriginal vmlinux image:
     ZERO_PAGE_OFFSET "0x0003F000"
     ENTRY_OFFSET "0x00001000"
     CONFIG_ENTRY_OFFSET "0x00040000"

[1] https://lore.kernel.org/linux-sh/20260711000146.3348854-1-fuchsfl@gmail.com/
[2] https://lore.kernel.org/linux-sh/20260714104147.2016549-1-fuchsfl@gmail.com/
