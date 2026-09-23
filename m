Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018049DB85
	for <linux-sh@vger.kernel.org>; Wed, 23 Sep 2026 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160209; cv=none; b=OCmlygwyg487x5eG1iEtysXRtcR/SJDE3ujJcKSBYC4OtaI6gKrbvciFLHenGWEfiXyLCfEpIaepsuO2VYxvP3Q5s0ZDfVEPvO3p+ERPBH2CkOly4WD9imgoEUwXxSMrcpuIJTMj6aWQG8dWha3HMKoF40J62FckDJPAHpYwUck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160209; c=relaxed/simple;
	bh=/hAmY6yG2+OCPMJTvRs5ChswnMAkCdLCUN+/9Q9fZh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIQg5Ih02Jfu4XGVXCNTdFd2en6rVtHokLZ4ZjD4S+YsZfrzUlUzyxG2QLBInyiDzQb7jkgTxyImCnhUcyFym8D665e6bk5p8XDDTDVDKP8UxAAA2PUHw1VkEsN/Xsbyb5SWf39dV7FW/ygPgW0C+eTxh9oMNKGsTIsCOmJETVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPn+PcDu; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPn+PcDu"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so505171f8f.1
        for <linux-sh@vger.kernel.org>; Wed, 23 Sep 2026 03:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160195; x=1790764995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t1Z4i78iFUVYmXdwkSYq7EkiOAX8N+OcOOj8F5FsldA=;
        b=CPn+PcDupM2GLmmXqlMvdfReA/3wAJMMUSYOaS0cjHThc+wAddPU6ProYKR6TX3Op8
         s5yp4NHCPEyjnz7+u4HLA0GZuhA0Oj8otUoWv8l47UgGGRHC7RB+QKgleMtdEGjeacfa
         cwEabG/Wu8LWuc8bIYyGd5xPBPTKhj+h6H/S0tmTY0FALjfJyBWvjhnn/7VulmBeSwdo
         kCPPPwzI8RbocchihueTj+H9IkBO631KrCldStcev3UFlDv2I9e43Sa0IglFTP0ilagV
         IGoXnifX2h3lYXLiIng8I1BlirUsIfWEbUsc2wBKREgeXUo6mN+LqTu5n8+SmdxH3DVi
         7McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160195; x=1790764995;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t1Z4i78iFUVYmXdwkSYq7EkiOAX8N+OcOOj8F5FsldA=;
        b=BqdJHPM8BgbIFbuJzJ7KlZJf529mauizlg28TLa0qfLdHEOMqM0E3yQEU+UYghD2Ul
         xkAFT6L5aRj9YxKBAGUTmK2d+eFX0TWKbDM8L27Dr7Ql7p3KNgc4ugLbW+o9SuYfUPeZ
         XfVjqCnPz/q2AT3fFZbrpoVr1cKDHzlImmiH4DtxQyPfpicH+XLGmuNDHQmmpOJpgwnw
         cc04/GsSPRKcb7SZnHMBlu4D2PPIYFwbkZQsUAFWnWElVvg99OodUsCwuvafMMov3/n9
         Y8ljE0nAMqFV8kNFyxjOAtQkDbSTG3wJApRSBWepOnFkokLcvNG7XSZlXUHKlDNNwtMy
         SRdA==
X-Forwarded-Encrypted: i=1; AKwUvBy066U7XMsXfnAOzLliahs8k3bv/wd0N/gXac34lvu+TapCY1aKnx64egoTB/3uCFeMoEMKWkY5Gg==@vger.kernel.org
X-Gm-Message-State: AFuF++lnTbNon8DjGkvJ572K1HYa2EfLlyb1ZUep6J8WfRY9zA7D7M9P
	yi55Q4e5CQssnQyFytpPoYD5bsjsy0wCniEJTKSh9JmyQR9+JcPgosmk
X-Gm-Gg: AYBFou36L3/jMEWL4x6xuBkJ1LKoWagNcsQ1P2Ao01/8VVllE4WNt+YqRjuvZu1Niky
	ccsDn4txsN1tZ9YW3KY+NeNwan5EuOHr41oSgNn68MVBlmBbzBFNFqQtV/kv+Wp/Vm1G6R7e18r
	OXHxLKiCqGVGaIE5hlRDJzqlEf6DzUKxyUCQxVRYpqmguU2VvWwSSqonHe64ZcunJV3Mfqvx9q9
	fMejUFK5uS2MkGjmAZHzBIy+ySWvR4JfoiT3tPdExKUzg4byXPVQLy72uYfRoB+IeWJpv7zIULm
	BEnNyRbzwypwPAvW6zrrY5QPSXk0MtXENx7NXnkvkGRCpAcnCu0nVCwM4bqI99g8ZM5tZW1CDRd
	jOZOreMF3lDkOkYHeO9ifvrtaspWoeevpD6tLuyE/cknD4azJFp8dfFx++A8hWRqn/Z6kSWP1Yj
	R3yWVXqKEhbbkYjerWxg+EO1NFk439wCqsaktQug2AQ67gvcTH2C6Zy2taKvhOIyusO+frDwCax
	bU87VRY6KzWJN+VbPh7aipke3jPtfqbwjlpuMe3CNsW/g==
X-Received: by 2002:a5d:64cc:0:b0:487:81c:6de with SMTP id ffacd0b85a97d-48867093ce7mr3896298f8f.34.1790160194918;
        Wed, 23 Sep 2026 03:43:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488687791cdsm5534038f8f.22.2026.09.23.03.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:43:14 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:43:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, boqun@kernel.org, joelagnelf@nvidia.com,
 rcu@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>, "Arnd
 Bergmann" <arnd@arndb.de>, linux-arch@vger.kernel.org, "Vineet Gupta"
 <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org, "Russell King"
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, "Guo Ren"
 <guoren@kernel.org>, linux-csky@vger.kernel.org, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Rich Felker" <dalias@libc.org>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org,
 "Chris Zankel" <chris@zankel.net>, "Max Filippov" <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
Message-ID: <20260923114313.75494970@pumpkin>
In-Reply-To: <20260911192540.20983-2-brads@mainlining.org>
References: <20260911192540.20983-1-brads@mainlining.org>
	<20260911192540.20983-2-brads@mainlining.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 19:25:34 +0000
Bradley Morgan <brads@mainlining.org> wrote:

> cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
> cmpxchg() for the architectures lacking native one-byte atomics.
> The same architectures also lack native two-byte cmpxchg(), where
> such an operation is not supported and either fails to compile via
> BUILD_BUG() or fails to link, because the bad pointer sentinels
> these architectures declare are never defined.
> 
> Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
> word with READ_ONCE(), splices the two target bytes through a union
> and loops on cmpxchg() of the full word until the compare succeeds.
> Like cmpxchg_emu_u8() it is fully ordered.
> 
> The Kconfig symbol gating this file is renamed from
> ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
> selects both the one-byte and the two-byte emulation.
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/Kconfig                |  2 +-
>  arch/arc/Kconfig            |  2 +-
>  arch/arm/Kconfig            |  2 +-
>  arch/csky/Kconfig           |  2 +-
>  arch/sh/Kconfig             |  2 +-
>  arch/xtensa/Kconfig         |  2 +-
>  include/linux/cmpxchg-emu.h |  1 +
>  lib/Makefile                |  2 +-
>  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
>  9 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 3bb2e568f5b1..d56064797e09 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -1817,7 +1817,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
>  	# strict alignment always, even with -falign-functions.
>  	def_bool CC_HAS_MIN_FUNCTION_ALIGNMENT || CC_IS_CLANG
>  
> -config ARCH_NEED_CMPXCHG_1_EMU
> +config ARCH_NEED_CMPXCHG_1_2_EMU

Is it actually worth the churn of changing the name?
Maybe just a comment that say it adds both 1 and 2 byte emulation?

David

>  	bool
>  
...
