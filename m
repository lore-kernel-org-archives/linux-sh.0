Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0763FD159
	for <linux-sh@vger.kernel.org>; Tue,  7 Jul 2026 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430663; cv=pass; b=knXRfcKKrQbGFJHbgCDNHTsCBIsg61B0Fy7k3MPHuvAobpcMNa+kGDVWeMnKEiEn6NEDsGbUqyLRGW4TcNsmeYPAn3N+3WwjbQO9OOHSyKArhm8ly593MCOoENyVbzgWLAB+UjI8ivR+3mCo+1W4KL8O/he6sHadtcfX/b4FPeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430663; c=relaxed/simple;
	bh=9b8BbHxhkf1CoCrJjN2FxRZeuKaAhw6KBsFbbBlQaHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYOL3kX0lvt2/8AfC4qWm6ItbxKa5lDsImT+kZYMUXfrI1SjoK31vIUBdm87jOaZNz8w72lam8GRYCI8M9cCkHR3CSIa5y4NVd6G2kfawwbrdAvMtwlbdS7Plk1H/pXaoz5DQdsUeqHLPVuhBp5YUrxQ17qfvA2kFmNvS0t9Tus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h6f3QVV8; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6f3QVV8"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664dd23829eso3817198d50.3
        for <linux-sh@vger.kernel.org>; Tue, 07 Jul 2026 06:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783430661; cv=none;
        d=google.com; s=arc-20260327;
        b=NfbTHF+JpKCLnNFB4UAyDAhDbFvnS6WPFlZUrmxU2MyccK1QUPsEVd0TKyRFJsthWP
         VwmG/Nbx2bLTuhZoh5G3FV47G8Zd4IRbPRCRH4Hvf24Nk8KFmC/w0bP5bkqt5C8FArs5
         oPcoqoZQjcRysviBhOeNPh/9M1ztq2sOOmf2CvP/7MZNkWlVVhWn3/IVV2SwBaehjyQK
         9GsY9xoUjBdhxUpqWCveNdxT8pwnCfwkW20SFOP3r//0euAqEXqE9s0q18EO1WBZVFYk
         XmjvaKBtKC7kkngplXMCAUhgUkv32JPYTDuNOAowKDcYfVumxOqCAObuIBrAy8QRYJ3H
         ja0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9b8BbHxhkf1CoCrJjN2FxRZeuKaAhw6KBsFbbBlQaHQ=;
        fh=y0vWxso2P1BPhR7+c3C9ksB6GrofaE9vY9TJEwJMyS8=;
        b=kYNvFJlUmP7RzbV/sexVInSEup2aEOyfBiqh08IcrMupRTiOx5Gyot8OYHdAN6iijr
         GhyTZjAVkf437XCyZ2Nm390qmpVVbYiax/XRonzVMpWvjBpPcDvt+T7Pbpau/ODUq3IA
         3pZiEH35pq2Ba39ZqVrXD24f1zfrgHuAMgUGBH3WGflgmzx4GsvooX248qNqpkDzaJLh
         SqNUrkjC/I6bN6NFayMF1pxSGE5YKX7swLaEbFJiL5Fw5oVve8WkArpDIXX6gKWcR6yH
         3m8nSJzPxutJ0JDPY0SdMg1rrhzR9dynOtd7fxsqO4Drtdp3VOSE+uuAilR+kcCWHrWx
         GNGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783430661; x=1784035461; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9b8BbHxhkf1CoCrJjN2FxRZeuKaAhw6KBsFbbBlQaHQ=;
        b=h6f3QVV8r77iq5Zj7UV8opf2QnUbp0+bVJ6XOS9dzuUjYwjeLAm7fBt6LOm3I46ajq
         YROKUEi3AC2F5/1qeV7ZGEHp7h1qlnp8FOXq2fc8VhxA1QIg2NR8wr/uFISg3wh/d4Bw
         ODc4gYUVjJ613psJL2KwjvSWyrQOyKMSs1vv5SR5y7iGRis3ce4SKws1Hb2g0Yl8lSK4
         PYA0U3vkU01zEixWDtaxGz50INOh/UtC8dXUuevvb0mpqrb0Uc1BiAYnYavkjq12Hpnk
         KPcKjS7+KE5DHd2ArWESgk6p56Hyht5plu7GXzFWGiV8c7NdPc75vCYmWDg5+nIksBEe
         lgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783430661; x=1784035461;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9b8BbHxhkf1CoCrJjN2FxRZeuKaAhw6KBsFbbBlQaHQ=;
        b=HAOzlX5SojKatzmxoict4Imy0bq0EKIgm2uPH0bXVOOrw4EI9P8D3DzuHtErhmY1uA
         Snq01fmlcp3P24nWYekQhIxssb3YWg9rorSs3jH0aQxShMR4wby+0KTMXvcUJ0/PDzdt
         xy06mkegZbyLQwI8TQGXi9OcZk3lfZm0uh6F/bUEkW1p6O2p4ZbeXkUhYQYAgDRzU5om
         ISz1yEmdMHrU1eRy8lRWzWoi/m3x+rUJCLk1kkpUMYgqM5lA4Qu8sTEziyMDOlglF2yP
         vv6JrvZEQHmEUPwJ/NqJSIihSNfv7bB9VpW7u9RkPFxLYNzlU1EwcY729h/EyTIf2gI6
         djdQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqydyc9e+1GfWdFTRbrrXq1zpfzbokk0xGvGsue0MRdlpa4r74/sT+HWV32/A19fCFO3soNP5+38Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UBOrGThwShNDwdmfh1LUIliLW6tZWkJVBZrPhY1MpQgUZW0A
	2GICZN+O05bO9atPb/Pb1FKwtOnxkHsiqGNcWd9XBOof9WxmC7Sw5t+GjT54KQLwzKzhp2PBvwA
	pBWF4MttIztqjf/sh2qqiXBQSKA7dY7k=
X-Gm-Gg: AfdE7cnh9dT9774W+c17ZFagaP50bOmgj0HsKWLL7i5ar3VDvoZjik11BqLKaSyqHMb
	7XFRxjWLDUMnA+eDNrBu1/eNDDCyu50PRxIKMxG3vPeVA8uDjmgD6AyDFE9UzueBO10gFY3nHIA
	tBni9Jb0YvdmRr16Lljru6ZVbibQ1oMEri/mzuQnZK5ZXCYnGpqCTjwQZ0sh4/HvKXxAn5S9WH3
	wbgnhNRGlKsKPWTDDY52fQvomhohhs6FxFTiIO5rBXOK6dcBCon7p30qH4VlVCX170OJQ==
X-Received: by 2002:a53:adcf:0:b0:667:8b90:2ecd with SMTP id
 956f58d0204a3-6678b9053c4mr1264848d50.108.1783430661475; Tue, 07 Jul 2026
 06:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706163753.193875-1-ekffu200098@gmail.com> <akyZ5DhIV_Grn1Kc@kernel.org>
In-Reply-To: <akyZ5DhIV_Grn1Kc@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Tue, 7 Jul 2026 22:24:09 +0900
X-Gm-Features: AVVi8CdmNSJCGxYOGWnK5wJL_8NTvAWhpJlXJNdpTu_SgODQvmfDBt7ZZCk7fE4
Message-ID: <CABFDxME7ig1SQDB39TUeUXoAOA2jSRhg6h-bm0kUHrHzGYeE-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] treewide: remove unreachable memblock_reserve()
 return value checks in early boot
To: Mike Rapoport <rppt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Chris Zankel <chris@zankel.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, 
	Thomas Gleixner <tglx@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-mm@kvack.org, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Tue, Jul 7, 2026 at 3:17=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> Hi Sang-Heon,
>
> On Tue, Jul 07, 2026 at 01:37:48AM +0900, Sang-Heon Jeon wrote:
> > memblock_reserve() can only return an error after memblock_allow_resize=
()
> > has been called. Before that it either succeeds or panics, never return=
ing
> > an error.
> >
> > Before memblock_allow_resize() is called, the return value checks of
> > memblock_reserve() are unreachable and can be removed.
>
> I'd rather keep these checks.
>
> Removing them relies on internal details of memblock_reserve() implementa=
tion
> and the existing event sequence. If the code would move around relying on
> panic in memblock_reserve() may not be correct.
>
> And the few bytes and cycles the change saves do not worth the churn.

Makes sense to me.

But most early boot callers of memblock_reserve() don't check the
return value, so I thought we already rely on its internal behavior
anyway. So the few remaining checks just looked a bit inconsistent to
me.

Would you still prefer to keep these checks? If so, I'm fine with
dropping this patch series. It's not a big deal :)

Thank you for taking the time to review this series.

> --
> Sincerely yours,
> Mike.

Best Regards,
Sang-Heon Jeon
