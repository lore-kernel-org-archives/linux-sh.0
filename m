Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E884644E
	for <linux-sh@vger.kernel.org>; Sat, 22 Feb 2025 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184454; cv=none; b=qou6XBg6FR9NnCWIPaQR3y1xU8OUTGi5eXembl1/NJ4p7173dLqw5iJfVKDbmZwqqGOikKIXxkJqZC+RakZoyvf/ey+oz9oQPwsjoAe9/6bmdZeuiI7GMjrzhV8G6o6mFww09CNyF2RtNVKGoX1UY7gmFp5iKh1jzZxaB1nwf1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184454; c=relaxed/simple;
	bh=VBQHljTSYFVCaj1bbqPfTOtZckZuFzfefk82naOnO1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGmETVQwgI0JlQ5XFJJKDQB63HWlFCE3Gbfpf5Ix42Is2tz6yUq7T0NjYUeunKj95jolra6Y8LMgeEXenBUeayYzhYpdFbNKoVqi7CwNO4s1NhqOtXej488gMuMlce1pbV/thCmxLfJun50QptGU7xEeAZTY2mvYuLP+pLVpW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OUaLZ8oR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OUaLZ8oR"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6f6ae4846c7so23301307b3.1
        for <linux-sh@vger.kernel.org>; Fri, 21 Feb 2025 16:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740184450; x=1740789250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwm1CmURc5ve7fRU7CIVjr3XJe8XTIamKjt5b8I2oxA=;
        b=OUaLZ8oRu1P66C9ZZZkX3ynr5GVCRqOCfxm+eS10iyjZ/PQSQVzJcOLZ6xUj2SVdYN
         M4K8v7SJJNGtsVfIa8UAf/TytFgQB7jB17v0YqxAZeaJ0z7poxTRKJtsLNNfDGLEzCtl
         seyhz1IBRRwX+if/gK7lWjT9j8r22Ve4Q5tw8y7tH4v0VO86On+zdAarH3tOUkuAZpC+
         42QHcKAyfH9frZU0Zmd2KD7X742j4GBihhNWnbrr+XZUDJUe8nnJrCAFuMuLqqZIBe++
         7xlE0daBQ4baD0AJRZFXYr9quFZHlK3q3UVtm8HMqcrK9PO0mdFobh1wMMbzoIxycBMQ
         K8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740184450; x=1740789250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwm1CmURc5ve7fRU7CIVjr3XJe8XTIamKjt5b8I2oxA=;
        b=QoXgrOK672KJpjoRhw98r09wBci/mtciVqDTQKE1arevJXR8BL1Ey/7Gi7loRnjj/y
         DuzgACzzgPn+ar3zEpqHE/l1QYS9ncrTGxSsMcSn1CXPSMT+5wNnKM6w0Nq+F1yAHBic
         xuwOcdoaaD7DsmrxqQILLLDTPJlIOTDzE7v9JXzTpqXyZ9ORy8VcuVAcTP4Bs4m8IaPR
         6bNEHFRDRDET4oLo4aLYDXy5/bszKXiT3vo8J4XfrYIykjsix+mBbZfymogZaTnbXukp
         iI4qn6m9w8ltGu1hxpjKjV7X7NHqpl9ueSePMLqaRDf5qpsfEL7CtTTZByEdmkKFO+v1
         1SKA==
X-Forwarded-Encrypted: i=1; AJvYcCWL7UzZHlyCsXENvhcmNUNODgZww+jvpG6FbEvzJLG2VXc51yeqH6EvbFFOMmqQBG/Atewh6hU+2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSdGAIba/S2QSdJCHi+P4b5NyGURJZAIC3aCdXzVqDglqK+FZE
	ZLlkpuEKmZ2uBhy8kH2ZJO5Lagt1E31SinWA/yywoIWjunfRaPuLzE7ZXDvB8IsOGZK3owuxLfp
	WSP3l3HGee4FrTMk/KXBaiuRb4d+PcsNTU9Bx
X-Gm-Gg: ASbGncu5f6gkGN2Vy//uRhO2xC6tQKmml/ooxaeMbwzYxvuXjmQI8404UPVq290FOgp
	Czr3+8/Geo3/R2SW+aRVzxmWJqGNA+yJ+aLOmOY7CXY1jMRByv4/V/jrCyXA3xaoB54XDIGrutq
	jxFxHej48=
X-Google-Smtp-Source: AGHT+IHU8mqrXQveakYlLhZ7AQnDt8Huldya+naR0jPDiYuZo2FksnUyR3yBLKwefOB052PduAKRpiO/vKqO0ObiYCs=
X-Received: by 2002:a05:690c:3506:b0:6f6:c937:2cf4 with SMTP id
 00721157ae682-6fbcc81835dmr37934927b3.23.1740184450404; Fri, 21 Feb 2025
 16:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-xattrat-syscall-v3-1-a07d15f898b2@kernel.org> <20250221.ahB8jei2Chie@digikod.net>
In-Reply-To: <20250221.ahB8jei2Chie@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Feb 2025 19:33:59 -0500
X-Gm-Features: AWEUYZkJvdf7eQZPTJrwhKnqZP-Y8wnVSUpipQ3Me6WvrrB1wQej040Y9lsHrww
Message-ID: <CAHC9VhSnP=j_T30ctVmzQ8TwhD6YFcrWhLbqa_oG3WSAPUPOaA@mail.gmail.com>
Subject: Re: [PATCH v3] fs: introduce getfsxattrat and setfsxattrat syscalls
To: Andrey Albershteyn <aalbersh@redhat.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 10:08=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> It looks security checks are missing.  With IOCTL commands, file
> permissions are checked at open time, but with these syscalls the path
> is only resolved but no specific access seems to be checked (except
> inode_owner_or_capable via vfs_fileattr_set).

Thanks for reviewing the patch and catching this Micka=C3=ABl.  I agree
with the hooks identified and their placement; it should be fairly
straightforward with only a few lines added in each case.

--=20
paul-moore.com
