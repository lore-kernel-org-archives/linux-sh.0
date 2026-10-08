Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8045FFB8
	for <linux-sh@vger.kernel.org>; Thu,  8 Oct 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487784; cv=pass; b=D8yKqhISGj4gE12Q98dJExlMfnICm7XiekUul7RootM8lS5Wp6wtGmm0Tq1wufOQcobKDgO3UzNt8rz3qB+8cRSMgwWiaj5vc9dSJjyUHwos2sV275gfI4i2lOqJkt3SXaEG61S65wJ6pCiZD2Sye0wbHfCCbnjKlXdRr34ZY2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487784; c=relaxed/simple;
	bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4Gd7jR6lJDo0OZjdMX6BVjq5ehMZ9cx3IQcgCvL26xT/YdsOJojumS2CcERX/APLzYiulnKpdr2VxSYiX2rYb81GT6RSb0oS6qmbyqP/y+AFb4fJJmR0T9zsHLn7OI696AogIBfVuCvFIfj2z8aoT86+7vCqlMdx7C8MWgRpyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wn6s8tb1; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn6s8tb1"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3a9bcdf29a6so5290821fa.1
        for <linux-sh@vger.kernel.org>; Thu, 08 Oct 2026 12:29:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791487781; cv=none;
        d=google.com; s=arc-20260327;
        b=IUbrNll8lggIOxV/qaCyxikjtSRvM3zuo6wPKjvwkcrjQecXuToZV73TkWcgWJCzTR
         s+ykNzVj2NZ0V586pdFxELio0rJXdK1yMohfuygOXTB35C9AFUmRk5R4NPc8LNt/9uai
         WW0rNOaP/kixTWdSFwPKAKEpbHbTgcDvTLMo3AVuKFD1OHrNZrspq5dtfquKtdH04w55
         9eAuCMr1zylI7GFSfnX9xST3SL62D8Vg2CSik/PFZtVRfO2bNN9UqBASSgB90MHajbls
         36Juo8Wr08x83Uuw21aZ82TxXqjJ1w/yx9x9x2aB+/j6TM7hS+VM7WPo/V5hpv4MBM+y
         t5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        fh=30GNiAhmpOJqB2JomqQQRKiBQeQhDOhEYxrKNTJF7qk=;
        b=hazp7Nn5l9pGty10XlJD/qEErjL0I09GrLsgO0OiwlVor6wZxFxo8PavD85d6BmMV3
         TgILFwsGlxeqSIcmgKJ4ykHfu3S3sNDB5HRdA4116vIZ1aSJKeNY1NVrhcBNCZjhpNew
         2uL141yq2jKYAVF7r/HG181Yc7LI2U0vq6ADEdAhnNKpLOgzHG14pu0o/eSeK+x5rCCQ
         sLTF46Q0oPYSc1wct9UeYq1UQTl1e7Ts+z6digjgllhpcwHJTQ6rR1Q/09nihwORPGNu
         c5OCMLxXJtrD7RV2ulFpoQ2IcBwALi2EXh+m3ZxZ3XxOfAeZguB6dB+/RhhYQWIROu+6
         fCLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791487781; x=1792092581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        b=Wn6s8tb1eiVxlv5gZBq8iT3KJpGjQLvnTO/AHZIgEXjIZG+Lhz3cBxz9g6pMTSivp0
         wtTeLJOmaAiPJSlSQOd9Ej4zOx0wKZ4ym1gMaPC+5iNC/XwmE9do2x1yWrR0ZsT3WHTh
         w+VsM0qSr/2GWJx1SzOM6Eby6osj7AxkURxNuREKFU3Ova6vf++oZ9+etNFhyam1NALj
         Od2bQ1cx/eFsFP3UDnGod8REDTBpuxc5k3J6frNul3JoTNVqwgWMjVadxVY7lHJthEaH
         ilc/QMDjwZp2s7n7giziRaMUj+76BvUF4Ofor4aLNHTC8T1qC9C6ChFjGbX5KO1AgKQ0
         k8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487781; x=1792092581;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bH3Ys777xJyJceuaHq+fKZvqaHs2+JI/CEfT6ut+TY0=;
        b=NJ3Lgl2VdSoXtanQyJE3YSk586Le+vf642Mnv97om9b+eoVpmc0FUvWm9voPBn31q/
         2tdbvLwAsbK5yajDoEE39AZ0wAsZgZfVrELhrrNcbhiT9KmjMpTL+sD4z2Z9MstAf3Xd
         nONkS7S/Zcm+BTUxBz4etX/hP0YD0HXbw84P8UTd0YN/icdkc4w9yngiUoy5oGG1/TGS
         qTCmKyNA4/sSYmZunjEalcy9gj/XtWTYA8dKsYVArM3EM4OBrXe0B7IeBpW6fGEiUhHX
         TBC+rir7CCHjCfSt2B2IFL0Oomq/Vw3Ka6c6LiC6BFozLcwL5/Rfv3/xPWTqde8RZ1GV
         F50w==
X-Forwarded-Encrypted: i=1; AKwUvBxWZwMwpJrDkccrC8L4d0TA719nijUeJct6LfxqLE2TzQQ0uw5C4b4aUbHyjtfo2pUZZ7PXDcG2Mw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIeZR1vAGZPSSfAs1gP0JB0llaWLlpcPKs21hsbN0xpUOUXvD0h
	G280D4hm26JDPtQAD+sqSg/yY/fs4ef7FM87RF40+mZnIT9o7PoB5c90jED8MOfZKSoV1f2aZtL
	9b0JQW5Xiouh+BOx4RjYPAzzN2chLehE=
X-Gm-Gg: AYBFou22IrGRxecgJbMP6igwNZNHByaUofJfG8o3ryUNHhJGq93nrb9ygXYVnx2LzLx
	z8wRsXkB7kZZa2IGhpmWiOHhNvJONN9nBQbYBdb2KadNqhoCbg8cA8vMY2aiQaLX1//ab4lNu6y
	FM8slP1Www43MkJATOpvw9Be0rQz4vb2kMcdKZLXx/JvhmXLzvSwlBV3pFvbIYHKyjveQ02suN+
	1KZkGs/JaiExTfj4l1FgdQW6js8qMtLOhQL6VdhdY3+lpi7KYtOoIM8kAkGSHm1Uocs3evRLKyQ
	dEQl/xl6nFcEpx0xaEwa4hHtZEEJEZE5oIv0PD21npAevO0pkEnyCmS/mJQNG1dMpNddgBb8bOs
	qwiqdtpzNS/eKFQ==
X-Received: by 2002:a05:651c:15c4:20b0:3a6:58fb:8540 with SMTP id
 38308e7fff4ca-3a9c2a6f0d9mr491601fa.19.1791487780457; Thu, 08 Oct 2026
 12:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
 <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com>
 <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com> <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
In-Reply-To: <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 8 Oct 2026 15:29:27 -0400
X-Gm-Features: AclHuK-YAox1Xf7NjC5L8Z-SfaibsiX2e4acSu8a9kwaQSKw1rOePouwIqBhWL0
Message-ID: <CAEdQ38EM0FyqYZH6b30oxScZ481dGqnsqu23iePLdx2gCpqzxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 2:13=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi everyone,
>
> Adding Michael, Yoshinori, Rich and Adrian directly, although this
> is an alpha series, patch 3/3 also touches the shared soft-fp code in
> include/math-emu/ (op-common.h, soft-fp.h), which your architectures
> build against too (confirmed by grepping arch/{powerpc,sh,sparc} for
> includes of those headers; parisc/m68k/mips/x86 have their own
> separate math-emu and aren't touched).
> The new _FP_TININESS_AFTER_ROUNDING macro defaults to 0, so the
> intent is no behavioural change on your side. The new guard it adds
> in op-common.h is a regular runtime `if` rather than `#if` though, so
> it still gets compiled against your macro instantiations even if it
> should dead-code-eliminate at -O.
> No action needed if it builds fine for you, just flagging since it's
> tagged for stable. Let us know if it causes any problems, or feel
> free to ack if you're happy with it.
> I've reviewed and tested patch 3/3 on alpha already (Reviewed-by/
> Tested-by posted).
>
> Thanks,
> Magnus

Hello all,

Could a maintainer of this code find time to have a look?

We can take it through the alpha tree, but we'd certainly prefer some
review first.

Thanks,
Matt
