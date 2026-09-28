Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4F409638
	for <linux-sh@vger.kernel.org>; Mon, 28 Sep 2026 06:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575650; cv=none; b=eSonZHzK9dcT1zGz5Cf5jxuHNeXJnS1BTwxZB8a1Ev1YTfSMUaMneA7+iqgnSloZQ8GWIbtmCNIKa7fPN53kg3J2QVY584F3xaZxyMwFM/SWPa6fmkLMX9tKzO8bxhy9nmSFdbP1kHV4rNP5qnREF0QBLKVxZtv5mCB9uOhz/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575650; c=relaxed/simple;
	bh=YPCJnyNJ12A9jnCHKjDKZ9NGt82rboxnhlTUuEMZZKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwR2x8BYy5d/Mzu7ZCyGszCTDCYqlxqKYMYgmAKjLY2rdHsSSyGv4d3Zi0qMno82f+NDZ21H3DiZPSbLsdIeKAnuy7DTq6CA9P6DRECXPglFhiFhUgC6EteD76aHZg5Ymd+f9cGQlkCQk/j5+vZmqY3lvkAQJRZVlCK1gtZHBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE8y/RMo; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE8y/RMo"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso19409725e9.2
        for <linux-sh@vger.kernel.org>; Sun, 27 Sep 2026 23:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790575646; x=1791180446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q+FDVerP9oAliRZl88sc0pX2EXGksgQKocsyfp2c8Zo=;
        b=HE8y/RMoC6JzgoMeEJ0ZgCa7OUONRVZaVTy2LWqlg1UDzdAtcUHhlGOJktmc4g8J/9
         E0CMRvExGQ/P8HsEiOwde3Y1G6m5EIa7tg+dF0xK8J5sELvG6JtYdUCjKhxaMRpe77Tq
         6rX0njHWwFiwAu2JVy2tlqqR2IimNeFRcGAi3k2lruBbhuDmrb9FoDJ0GmBtixs0tUSt
         f4jTK2g1n6YgWuLvf4pbIrKBFZZqAattVGlv9OvPb6h7hDz8fVr5UXTR3OcC7IguJdXL
         FTZKFBp1+vatSoHY3/jw/8ccS9DDk34fS2iHqM2aR/f1+S9kHmqp4wPT0AwS8URbLj6I
         U5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575646; x=1791180446;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+FDVerP9oAliRZl88sc0pX2EXGksgQKocsyfp2c8Zo=;
        b=Snm3ds39PJbAnPuEKxNGY/ZpgifwT0FdRsH6OXiAQiRgChsbJc0c2W2p12U799ZS/v
         pnPWhRUBHPYmBJFiJWrhs653KrrqXPRpWBeMxB04p6INdJ6OU+IHk9kEVbhDTSNesq7J
         rRdH8XyXrBocilIz+ZnYuSVNlU7x4v3+vBrk7Dix/kElEl6rQb9lXY3fFWI7GPn4HKk9
         8OoVyJ7pYi07nM7SM+D/h2K0kn0IQJjMM910KD3POy0OI8M0lq7xOCFTJeuAq3ctagp8
         ZBzjDT9IZ3swT42rnlsQlrpg6EmCUGr9KeP2od/7Kl9x3uvqxxJnSgfvtagwBiuoV3gH
         z3zA==
X-Forwarded-Encrypted: i=1; AKwUvBwQdDK6JTIDhR5Aeyf0oFNufECtCOvyu5l0n+C93DYHKM7D21hhZ1cOSN4jgFVCMHobDWwfgn4rtg==@vger.kernel.org
X-Gm-Message-State: AFuF++l9kpwUmu1uGolNH0y8RxEgEP7K7R0lfADu3n4YAUSTEuNFDiOc
	txpOQ/ioBQfM7kzv9YEmJ/qxbpAXwtZrYIoQP4/o8m3bDJYLQQvAKVZs
X-Gm-Gg: AYBFou3Fz9dcFhB8+04vABm9Njn//kVo7zzFB56YVPIv6SIMh8Xb28ueSv9PNajk3Il
	bYhKEP9msdBEj0d4B8ZVA0VF/AgDQ2XGLtBgmQYXxxhp1bX+JsadwW/Tb/PxkxbCW9Py8i4l2Wl
	hIWbHpTvnln/o9MD4jbEg5ripLT/dCifIk/y3jBQy7rQh8/WgFcpk7FgYfDgnfxur0h/+OMnEG2
	mERDukSUqiFwo4njsqCiBxjbxJILO9eV4a4a9DZXd00QRNDdHK8Y/n9ohV5hUh5KOH5t07XY59v
	lOjzNXmOVtHaMHrlev6mKAOYgQVuirvPVKo/S7qeSZALt5RTV/+cbanDQnd0D9FlWuNFds1X9zV
	6MhXfsgP3Z+7+9xQD8TaTy+BGsIABbrWyHwp/TZzQvD2zJybwF2SMQL8eLuaELbYh6UBNoabec8
	SsW9yQ11i/j4zE8N70kamL25XXnAIiPXy19pP8gk2gs6vQYE1p11ypoQQyTir3Me4tUNvSAERuE
	sZojTHbhoAIgVnzy+dUFRBylyahvF+tZeC7AbG166RJ1ncQY/+dEvltrlJBjx7NY3mC8ZXbCpQV
	KQJqxvdGBsjLKkKe6B1Jv50Pa7RA58vlNxFfsWfdJhcZovsy+zGyVttj/Qk19oSEukt7ny/+Fkd
	ypUo2VnR5GSaM5Q==
X-Received: by 2002:a05:600c:870c:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-49fe7bd0128mr202295575e9.33.1790575645445;
        Sun, 27 Sep 2026 23:07:25 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm122878225e9.11.2026.09.27.23.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:07:24 -0700 (PDT)
Date: Mon, 28 Sep 2026 08:07:20 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Artur Rojek <contact@artur-rojek.eu>, 
	Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/jcore-aic: Fix lost IPIs on SMP
Message-ID: <aroDuGZBLsAw7tMS@gmail.com>
References: <20260928035408.25871-1-kmehltretter@gmail.com>
 <92e110eef6dac0c6ddceb6ddda1658aeeaf1f0ec.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92e110eef6dac0c6ddceb6ddda1658aeeaf1f0ec.camel@physik.fu-berlin.de>

On Mon, Sep 28, 2026 at 07:57:27AM +0100, John Paul Adrian Glaubitz wrote:
> Can you tell me what toolchain you used to build the kernel for J2?
> 
> Last time I tried to use the one provided by Rob Landley, the build
> failed due to an internal compiler error so I couldn't actually build
> a kernel to test it on my J2 Turtleboard.
> 

Hi Adrian,

musl.cc's sh2eb-linux-muslfdpic toolchain (GCC 11.2.1, binutils 2.37):

  https://musl.cc/sh2eb-linux-muslfdpic-cross.tgz

Your ICE is probably the one in kernel/nstree.c. Since listns() went in
(v6.19), every GCC I tried ICEs there with j2_defconfig. The 64-bit
put_user() asm prints %T (address + 4) of an "m" operand, and GCC can
pick an indexed address that cannot be offset. The asm needs "o".
GCC should still error out instead of crashing, so I filed a GCC bug
too:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=127639

Fix below, formal patch follows. With it, j2_defconfig with SMP=y
builds fine with the musl.cc toolchain.

Would be great if you could test on your Turtleboard!

Karl

-- >8 --
diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
index 5d7ddc092afd7..879d262489219 100644
--- a/arch/sh/include/asm/uaccess_32.h
+++ b/arch/sh/include/asm/uaccess_32.h
@@ -92,7 +92,7 @@ __asm__ __volatile__( \
 	".long	1b + 2, 3b\n\t" \
 	".previous" \
 	:"=&r" (err), "=&r" (x) \
-	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
+	: "o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
 #else
 #define __get_user_u64(x, addr, err) \
 ({ \
@@ -116,7 +116,7 @@ __asm__ __volatile__( \
 	".long	1b + 2, 3b\n\t" \
 	".previous" \
 	:"=&r" (err), "=&r" (x) \
-	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
+	: "o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
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
 
