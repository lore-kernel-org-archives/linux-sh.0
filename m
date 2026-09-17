Received: from mail-qk2-f37.google.com (mail-qk2-f37.google.com [74.125.230.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504DC370ADA
	for <linux-sh@vger.kernel.org>; Thu, 17 Sep 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.229
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608745; cv=pass; b=rPpPmmXIyzNk9PJKGi9oz6M3WkcaoelCYGGIYe2aOEF6JrX+1MO5sRiOe/GUPTwzx2ALiAlIYfP7ZOb0eaZ6ulysqTNQVIstLZjXPsOuLzLNQbrXkjY/10wsEW0f31FfBqvwd+nMhmBFI2MCR1V4lJDyNBoXaco/7q1fb/XJIJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608745; c=relaxed/simple;
	bh=A+lyblawb+dgZi1Z+Fh12EBBr9ZxtiKYKrx5lLTeJY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkbBveHw/CytMOwjaV1ECRlfmArGzUrkNqW7T6fksoxxKuvuaZ59c0eiM9XAroEhiWt8E4YZGD2DSLjCVSMdP0xVf4dJFyHMctNiSkyNsOILqDGehQpv0Yi5MH2917nztoIc2eRTmqXkUHAtTKc/9z2Z7RJM4ROa1P467p/YGjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0reQ/xI; arc=pass smtp.client-ip=74.125.230.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0reQ/xI"
Received: by mail-qk2-f37.google.com with SMTP id af79cd13be357-93910cc46c8so21382185a.0
        for <linux-sh@vger.kernel.org>; Wed, 16 Sep 2026 18:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789608741; cv=none;
        d=google.com; s=arc-20260327;
        b=oWT2D6mxFUAgJ7kvs0i9OMzw2em5i3OP6m7epDZXpZdDYcSZQFPc2oQCfl7BMB44AX
         E31y+7ReMtPNrBDo5DkWNCGm5r+6cWFhQdVSeIgzg7ldsmBqrZQOhG2OHyDAHMVUyunl
         PAeG4xncVqGzsBpug+d2bBlRp5aouEta4EGBj9FjEKFwt1IBjcJ8O+ZzqdZ6TaF+k+Vf
         7ROk5SHUyLfhDIg0eV5ZkznapJVsqdJwbBRDeQRpApWsJxvb05DeilO6iTwp9nr36QL+
         7CVvH8QyPpyXXTL/Mb1QBMufWmbFu+wrrRnf8CSFDw89yx0mTyBuNSTON/U3KBpGdm5+
         RURg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQRUPW6YJQIkC46/KpIizzCCGCnEQ9KqApfgS7uijf8=;
        fh=19iL/l1UHNKpfCaioGcqOSU4wfML4W9R9Mxhaz05Uxk=;
        b=PN1/KM46m7oHh2v0U50W/coSwZulCoq7qfv6/1OpkrrECrUyBp35QoDCOGhNz283ic
         Rci01VhgIJAYM8eDbnF+/lXUuDjuXDYj/A+WFGDJUULTC27IvnsvWWKGJ79+zeQ4Yojc
         AzgQEvEgfEjgld4lqFdwovnyBbeiyNNh4Ls4IDHjzbptaaGwOpAdh0r32nJY7aViny3V
         UNo2xsvi3UZ1Hlq6vDMuvqhXMfLctTV1ETLIIthkIItl8tILg2p2qepEotynPfBydwuH
         dtReNcoMOkJLsKzougFTqyGjYsIPzp7+I9QBiEj0sJnbc4TgJ2LTBe8p3UTHMkefm3Bx
         fPXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789608741; x=1790213541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OQRUPW6YJQIkC46/KpIizzCCGCnEQ9KqApfgS7uijf8=;
        b=F0reQ/xItJ0VwokY3OtU4QLiubH1w2NzLbVOUcIFza0DztIZBwX5Ipa2CP5jFq60lI
         8L3gaEirKnzXT7NH1gMhsEv7yo+GB34NyhH7LkisZ6QjaxRsKzBl3rpCdLvLQ3+812rP
         /WMsfQdG2AyAQjkLcKcyfvusBhE2DVmO7DtVmiNdjvAkt1e8StYSgMzK6oOtVysYCaIt
         CpSIOW0yw9Bb6gbXF3l77t9zVubEMrr9sadXgUqzXBEP+lM7G7AT7WP46zrHwPNzaVmZ
         plbL7uPu0u+HMprcbH6yhlhrIG1DOwDhj7d5gsMehHLkZDhtklB0FvxLb/SfCwbrbi03
         PLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789608741; x=1790213541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OQRUPW6YJQIkC46/KpIizzCCGCnEQ9KqApfgS7uijf8=;
        b=y4wuCHCgTV9dbMFLiIOCnCBdOJDaZ/t6DadU5G4/ZHcSXzvXdlgl4WqiLrHWGaQ45Y
         vJNprp8w3+XO4Akmmhua+1w11jWMUhNmkZPR0hE/7W2nOc4yn2tkFh3Chn6u5Uajw84U
         Z90ksaegghob7KZ/OXKbyjK3/e4YEKcxZEixGfTVKKPo8ac7XAIOZcaB3P1BRX8tM/LX
         bCXcFw62jNRANRikEoCR12kOQwEg6fgbN0Nu8jK6QAmzHQPkYurY5OLIWRV8zTFHaivU
         Nw5JxByX3oZdC0a//ls4H0lHtSOQFMDf4y0AK030YcFnVJnKa675f7L2hhl99Fj9jipp
         jDCA==
X-Forwarded-Encrypted: i=1; AKwUvBz6G/64rt9YveBL5K420pCo7vvCNlt1COoWknoDRwIxN7ouH6LPmBhpsLhH+5WT/kDJvJk4gdSxiw==@vger.kernel.org
X-Gm-Message-State: AFuF++mvzrZn1BDPTXmjZ6hvVuhWO3Dem3hklPczcArACBgINMpIOOBV
	xR19XkSmS38BQPEIeHE5d1NmiKH0NLRArcqO6Sq4kzwBK18gpu1OZDSK9N99qneUtyGAAWtD1Gg
	IKumodOXjsMLqNNK9kXqdis1Vt/HJn+8=
X-Gm-Gg: AYBFou3wYW7900gSvJHup5INMQ1v28nAfTx2offgzoD42qOciv2B3RIy1TE/3tsZE+4
	0OaiPiXF2AxqRJz9HcEKUglLTCbPyvRajT4g8RVD5fSP87ldl7LS15opki89AjeZZWG+7ISdXWm
	lBdSQ41T5aYz8eytLfsmSiPJ5boWpm3uc/vcOXDmsOPdnGk/8+M1VasfBW+NsbYpf45JuRFjRtc
	NZJpJaYr1qhXW5mQ0MWX6vNbpfG/iubXRF/DKlWnqFN4TurlIczFJiXFOlTBQC5KlR0c1uKplzb
	ldv8LlSOwc5K3H8ksunifs+6oPOChAjueeopNb++MpBbZCmj8tSPdgNEhIWpJsyfx95DZh2PzS8
	iNB9xUGqruzvUKdyocyY4PHJdzD4ryjaS3UJahaXtspn/iRw50KVoJNMgNgqdfrw5fJ1dRNNeLF
	QSdH3oKmyU
X-Received: by 2002:a05:620a:2b49:b0:939:10dd:9c01 with SMTP id
 af79cd13be357-93bb78ecc33mr880261085a.38.1789608740708; Wed, 16 Sep 2026
 18:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916200215.21774-1-brads@mainlining.org> <20260916200215.21774-6-brads@mainlining.org>
In-Reply-To: <20260916200215.21774-6-brads@mainlining.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 16 Sep 2026 18:32:08 -0700
X-Gm-Features: AcwNN1WCG_JOJrf2Xbrmh8jFY2fRzqOy5q6E4Cc5_T2BPoTD4KB-hY5Oy_mqGNs
Message-ID: <CAMo8BfLSWyDpxZuePsOdwRks9CuwXiUQBOR5ioSx4GHf_NeZAQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] xtensa: Emulate two-byte cmpxchg
To: Bradley Morgan <brads@mainlining.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vineet Gupta <vgupta@kernel.org>, 
	Guo Ren <guoren@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>, 
	"Paul E . McKenney" <paulmck@kernel.org>, David Laight <david.laight.linux@gmail.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-snps-arc@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 1:02=E2=80=AFPM Bradley Morgan <brads@mainlining.or=
g> wrote:
>
> Xtensa has no two-byte atomic compare and swap, so the __cmpxchg()
> switch lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
> which is declared but never defined, so a two-byte cmpxchg() fails at
> link time. Route case 2 through the new cmpxchg_emu_u16(), which takes
> natural u16 arguments, so the unsigned long old and new narrow at the
> function boundary.
>
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/xtensa/include/asm/cmpxchg.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max
