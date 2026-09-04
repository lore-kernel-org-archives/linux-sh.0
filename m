Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7E141A504
	for <linux-sh@vger.kernel.org>; Fri,  4 Sep 2026 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502439; cv=pass; b=CQD3OKu/nq7LI69ZvMmcrt3JCZJQJmHKLlvHQnMmnm0KO5pMCs+iYlf1i9ztmiDIvW0K8ZK4WZng8lg3wtxEfFHBInUaPaf3WcNutaUunP+6AJF2Vdg+LTit1ibQZh4oGVpacD5KnyN8IphLqux7p3e3Tf3w2s39CbW4jMmdVuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502439; c=relaxed/simple;
	bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wp3XKMoLxy68dKIo91dNU3tia+iA6e8wC2LjerjOm9Wm7wLtEFXFNLIX/OjS6+L/7fVLSlbr+uGdBKxEbYQdpLiaDiEKrDGu9QUsdKckJ6ihxzZZJL+nL0Eo5vMLJbDm/pzj6ZGqgv7OtiBi5ufl5Cfd1Ap6FV1Rjb7XNyNvBqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jdml6mr3; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jdml6mr3"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a68ca482e2so751609a12.0
        for <linux-sh@vger.kernel.org>; Thu, 03 Sep 2026 23:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788502436; cv=none;
        d=google.com; s=arc-20260327;
        b=BhOw1ArjWuh/VE1YIlT8lT3ZFYdIs311SLRVWsN1EJ2ucE2+uLB8vfCA8tMOwSINZY
         Ve9+Dm7unXI9EPsLdoUp+1vEDoIKy23vRyRaka8YUPzCBYa7YUg6m3zb+s/jp9Ust1e/
         Xk3r3m0VLcCFHgYo/3TQki5dMqjHJQAuJmp0llk9cNZBUKx6Z4gLzD8sN7clmOGW1chh
         gwZTdFFS2siHUgsvamPh9n+kGcsRoAQduFgBww2F2+jqgYup6f9n8HZWFtpIExQqJ60k
         SCgKeDNrb0S2a1Vwc8mH81rMFop6+tbO55Z3sVDGLKbpan2Qbnz20GRoJ1Ggs7Kccmiy
         AILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        fh=qUhc60gCXcjtDiNCLb3VRze+bqVP2V3kbERfXa6+0jg=;
        b=ZND5FYPkhX+iwB86JMoWci+NotSBdyqkWoWl4LJHfh2vtHYzfH5PJjf8kLgrifFQ0K
         NeCvwXyW30ljlF1nKU3Jn6WaTbL0qpgVs2eHRZt4Z73tFyu/rRhMZCL5ddVepmdJWqaW
         P7/TdPTgQW+1be7OMYDxPD5xuLN9S1UW07d/9e8nhJo1BJ/Rqc3NVWxrr8dpuURqwpQd
         U+R3jTKHfRzeXqlBLASqtIQoqs7JL/Cx/h/9T5doRG3JPetr+uYMT7oaIc4D550L0rUM
         FcX4tULcufOdb7xtuVzp9k5oBUoyZU6CoyKR/hbJzeBZ55PZzwVleCIRIdqurNOd+gXL
         oB7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788502436; x=1789107236; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        b=Jdml6mr3zaJdqdlBLmwY4XR3DyaMt6UVj+RrpvUccUAgAhxLkAJrowYyrxRQFhIoI4
         SFMo9P6pmG/zs5G0i4r06tFu7OzCsJNsjtIovofmLTCa1ETNmq1ySaCoppH9xw7+jRO5
         kpa+4BFPGENcquNHvcWbiFezTJ7t+UPQTVZ8szMSKH5imCpPBYDpGeJ8oC47XpX6Pc2l
         tOm73krqlGnR5/rddSkj8pDV59Ur+mb8k/X5yfB9bOLqjbCYAbPr8LlREHKCQPjWpHwI
         TaGy6n4nCeZ87ZF8OVjnT3VRS2LFuvBDh+W0zWOjb3AHCngRjwHDiGeXMuAzRIRJxfsy
         xEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788502436; x=1789107236;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dOgcAQlgO1QoOYmAB+wFP5Ip8y+D8KPjRKJ5U4MjNU=;
        b=VxqaGhxsw9a8Qj4+3OQKjTi5FLQ3deVYX+tnvHIpRgla3jqQOiCGTmF1klwdGTow30
         uicF4fpZhoEshkRAfH3mc202kAJYhYCrMWoCpEqbA+TSDeNym+p/v8qD2TdbalIIqKQD
         8obErd68Mn8SsxSr/V40//LOlZ6/Idq5m4EdZohpacfa/4GVuq3xiCEHl4Ee8LjwPDEE
         FDesnTsPM6ZokDECPNIA0aGnXRbmFbb+TiTZstwysTQt/73XTCV3cPcx0usfA3zGWg+A
         c6fPYhYucNv2A01ws1CtyrTwo/EIWFpsXKI8RTJdyWqir+mCCKaWBpj2lex7EgpHtn8l
         J/mg==
X-Forwarded-Encrypted: i=1; AKwUvBwIzmgCXgvE5g2BYfLVvp7kE7QKxGC/woNVhg6HrSUb6l0uGU2aL/zUmYFORLbTMFh2HOaBDG9odw==@vger.kernel.org
X-Gm-Message-State: AFuF++kcOCh8r0PCV4FlT7sIZMoNkKtzlg2RSe0Wl8xEbI8BtXXYaJqB
	zVhD+/HBTh5YFAfkbhxDwAlPUruHnGtQWJzwk8zWhLnf6J2od24FuW4gipDdsCePej/N/fpBrcY
	KL12TuHnwQGkIWgWmltCP60pv6hgqRpQ=
X-Gm-Gg: AYBFou3RcNIW3hVUCAfEfNqx2haqmhp+cxfpxDNsogvaUB1wPxuZY/+vFoGzVVlAteZ
	1Z9wGJWR0coLuOhm8k4LgYrJs0FEiLL81NwM+OQdjbvOYD89pH+f5hp/RYXeG2yxVzfA1+HxWnu
	Znkuf55jjR6YG8zTOkakbknxMSXbL2ImuKh2gsWqkuKVA3DskFFR3TZC/9b4s5tcFhVyIyl+18/
	Lw6IkHepHbRcE+zOQgvEo5b0x7u7YDR5YYqUVYyHGa0Z7ukFQbkuq3295MxJe/IFejGCdLf1Ki7
	/vAak5WYRKa2184dUtdyI3LeFtO+saZ4/TUsmQ7Mbe2lUHqAd+T5RQjft7MFwSxAq/pnrCPWdTj
	/Bcuk9nH7G1HRPcW/PArkRzDzZhmXv7o=
X-Received: by 2002:a05:6402:46d0:b0:6a5:f44e:a009 with SMTP id
 4fb4d7f45d1cf-6a7e8d5a9f1mr1690015a12.7.1788502435914; Thu, 03 Sep 2026
 23:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com>
 <20260803-alpha-fp-exceptions-v1-3-c99d75608e60@gmail.com> <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
In-Reply-To: <CA+=Fv5QUxT-T0XgXccAF=1_6Dz=nCpY=NQu=ruOrYjbB+q7YCA@mail.gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 4 Sep 2026 08:13:44 +0200
X-Gm-Features: AcwNN1VrnhEuSNjXaQkRHQ6SzaIw81uvdMaGdmatxDoxs1iIKPoZwAWCS6BhE2g
Message-ID: <CA+=Fv5S_ZrHedEVPR9Oet2Egg2hwy33pEqEXaQa0zGdQdNjWRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] alpha: determine tininess after rounding in the FP emulation
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Adding Michael, Yoshinori, Rich and Adrian directly, although this
is an alpha series, patch 3/3 also touches the shared soft-fp code in
include/math-emu/ (op-common.h, soft-fp.h), which your architectures
build against too (confirmed by grepping arch/{powerpc,sh,sparc} for
includes of those headers; parisc/m68k/mips/x86 have their own
separate math-emu and aren't touched).
The new _FP_TININESS_AFTER_ROUNDING macro defaults to 0, so the
intent is no behavioural change on your side. The new guard it adds
in op-common.h is a regular runtime `if` rather than `#if` though, so
it still gets compiled against your macro instantiations even if it
should dead-code-eliminate at -O.
No action needed if it builds fine for you, just flagging since it's
tagged for stable. Let us know if it causes any problems, or feel
free to ack if you're happy with it.
I've reviewed and tested patch 3/3 on alpha already (Reviewed-by/
Tested-by posted).

Thanks,
Magnus
