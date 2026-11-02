Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793618176;
	b=c1t6hhTNPQMR7KnIv72nNhUPMEFDuJynrNYvrU9g2Y79xvM9mtInu3MWaQx+raSIHfWU
	 pLKmmh8P0yFurUnfmm41XTsrCffyvoZ9bJ8FDSFu39cai8YRpbaJca1uYgbc022qLf+Lr
	 JI8Bk02NtxwDk1IfQcwSpteRKMwFWb2v7Nar7IAAkeHLa2+YsweFg+owASER2jK3Od4az
	 txzMWWNbd0OJ+7pHflkI4TWoHg4qwuCHhxKehbbk/UfTUOdTnhw3bWxZGPhvEtnzQxgqa
	 CUTSAD8WFKsOmkDjGZkA+KYXVxZZzPhBuCTBJ/3ArzunM3PIYdxaWpyl9UYZ7IVDcmQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=G4cSiLwicJVmHrLeMpkn4zK8J0hU1kTujxDyRkZxuMY=;
	b=2Edp8HxLsbZZ6mm/n+cJem5qwMfV/6wEghWBbEJRbi+W17oEDRo5cJgzV8o2/rYH4g4f
	 2GRTTLKmdpxmgsb5qVbA29tVVnSKT4O0aTK/WNjjkupIGRQqPhVXISHgUcFid2ZOi5ko5
	 pXr6O35f23oBSJPuU9P2UpOe5r9vox0vCTwV56Oq7zhSiqlYJSv+j3HhUAnbIL1Utqdee
	 SClK0YQqdP7OsIWrw0fwy8zdBgz4M7NUxevSb0s8EU8AYn13EFQbM4Dyecpk8Q7snwdPC
	 y6td3M8EosXKn/MgEsXErKvNzaRg6yzfHu+/L9LbH6BsuNX5ly0F5hARHED+nnx6u7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=LOFmaa+A;
	arc=fail smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926E606A33C
	for <linux-sh@vger.kernel.org>; Mon,  2 Nov 2026 11:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D926E606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=LOFmaa+A
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1aefd1bf74aso1681967c88.1
        for <linux-sh@vger.kernel.org>; Mon, 02 Nov 2026 03:16:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793618174; cv=none;
        d=google.com; s=arc-20260327;
        b=CC9CKF8Sf7dwd9w0QUEY/2Fa8RAVq+5LhdHzIqR5HtE7TlibFfIo4yeiogGfsASAqc
         a6J+ojDwZrVq7m5yRHgZneligD8z64bMv2gMuY3MdoQmXoKUGPbuV8/AbgPN8g0TNLe+
         gh81q7S5Ej8qrrgbMQg7c1d5hrgx72oX4XL4seLeuivo1Lb5yyEorTj4q9M15RHlA/DO
         1Loe7LGCTDYnmqSrsdWX4uG7NHwmUnKiVNbsot1aDAWvlWQXXOUGkEqgew3QhZn/HndH
         piyXBCV48I5RwW8JK4G34S13TPPykjGo3dEPZLqeibJ2roO1sI8ZvxncPm7Fw695BJcE
         wqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G4cSiLwicJVmHrLeMpkn4zK8J0hU1kTujxDyRkZxuMY=;
        fh=Oct6RcOD11UZIpmGBkew4I2WGSdIg2Pt1cRMpADkAxI=;
        b=MA3bHqZW9dOcOyFQrq9k1oXeE/vaLvT9iiNg6y1BMkN/j6kPrA09GVXRkASCYC54Ur
         rYjD1xfS7KdSFWIIIH893pVGqcGY+lRXsUY4yzeRr7VzwfpYlQ+HbT+dsddlGjsbhOhF
         mKZgzru+cf+YxPKjc48Zot5VxK4nAgCo9oCI6Lr2XK3vNGzb1rbFnfaIoUf5G1xp2Dmh
         HgrSpWzF/+Gla/aykspg3ygBsGGNnxpsbVc+tMwHgQszy9BHYFBOPNwl0WX3M6PmVJW5
         aXEB600lmtIsTqWgC3DSoIlcRzDa2cAUIFgj8A6OQ1m1/QOYTL++Xf65t8bFvDV682AH
         g0oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1793618174; x=1794222974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G4cSiLwicJVmHrLeMpkn4zK8J0hU1kTujxDyRkZxuMY=;
        b=LOFmaa+Am17SrsOWZACAb0ay2UBOgyLboNMlmS0WrslonGmwLB6mmGf9+a9F2uYRBp
         t1oGQX4TvYHqqr539NBgu/vWo/t38y7cm2LX28LUKYux0HkRPhHmlHFKvNZZaxP5LbJ/
         aXg3cwGfZ729b9kOu7II14xn/TeXMYRP0udag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618174; x=1794222974;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G4cSiLwicJVmHrLeMpkn4zK8J0hU1kTujxDyRkZxuMY=;
        b=ZB8+ElYpBoOvNbRZXItT7O9dvKarEMkFA5VyvguWF2ZVdmdX+O7A6ftlknXxCRm5z9
         qB68UoxcSGERq7IUotrnNxqgRYiNLRbVKDXHLx8EJFPeunp5vDnvPj/YltXHoiKW8MSv
         VmESw9MGLtTE6tNmwbNgHeWYW7NG6FQLLe/WCavD+Sq1oudtmmPHowWp/sNEhtsZOH8V
         ouJmDJgtDlRiiU6g/PrXnL634gXzuLcV1UPIfEHT+5cjMTV0tRgn6JMCP7T+q8vHrReA
         FkQLDhj5sVU6NX+/vMKM5C8ZFk9fRElWJ3/Aren6kmL3Ost6gRobH5Pfni91VDvFGSQ0
         lUiw==
X-Forwarded-Encrypted: i=1; AKwUvByFPrBJ5qoHde5SAMShsRDEWtK56FErm8g3IdMsRhCj+hrDZKw9aCg2eDLQ7xfypyQcBaTrZ9pA6w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIJVq0D0EeltjjnWXnmsuT1NT0XJ1GrcU0fDrJqQ19kerlqP7Up
	yQu7/1ueowFpNKjlhvyNN0DjmbFEXO5Y0hvcbUD5Wkx230B1lg+jslOwow6kSwhB2Xdxq/5NiG+
	/5EF/nb3FEoV8i3KkEbjZM8PN1woQjZFKQYuVNrj4Zg==
X-Gm-Gg: AYBFou2CklktagEJxPYakRxN2Uvou92+xcAaLp3F3DxanD8DVd5tHg1WIlf+BwiZWBg
	BeajopdFCtJrRfKj7d9pNPHqsDZMZ8uljJ7GmXMc5OsES0Y15eCpf25VReMXyUGKqfgsNVQz5Ds
	kXXwuqTs4eAe15Lwz5uy/zScPNa9qVvAV4mtFnMbcJ5ulssryH1NT8hjlsJaXVtaApDk8a96yTp
	9ENIBezGDF88gnYlWkj6oaMWktKOvD4GFh0t/YnjtcVedC1sv7HZom83v2xijLhWw0JcKHf7bUU
	ZPLgF9OMhzh95IVWwEuOOCT+34RZlgmpDjE4fnmvdNI+QTYIguMLb/xFVTO7kboKuaaf962qYAf
	TPc6GqUtY9x42Iu3CUrmvLDLFQ7teCRmJfayjV9s=
X-Received: by 2002:a05:7022:b903:b0:17a:a3d4:8b17 with SMTP id
 a92af1059eb24-1ac5ac4f0aemr12405133c88.12.1793618173694; Mon, 02 Nov 2026
 03:16:13 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025034410.808796-1-daniel@0x0f.com> <20261025034410.808796-2-daniel@0x0f.com>
 <auhrgteGO3TwU3HD@ryzen>
In-Reply-To: <auhrgteGO3TwU3HD@ryzen>
From: Daniel Palmer <daniel@0x0f.com>
Date: Mon, 2 Nov 2026 20:16:00 +0900
X-Gm-Features: AclHuK_yExg3ifaj_wGpLVEITnJd8FTrPLgBisUUJnC1vT5nQFSQxKqD4ZAFeAM
Message-ID: <CAFr9PXmU3noRcZ=nvm0UsU74gMvNcneXdksOGJ-AGsZ8xaVMog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
To: Niklas Cassel <cassel@kernel.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	dlemoal@kernel.org, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Florian Fuchs <fuchsfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

On Mon, 2 Nov 2026 at 19:52, Niklas Cassel <cassel@kernel.org> wrote:
> Since your cover letter says that this fixes a regression,
> I think we should add a Fixes-tag.

From what I can tell it's had the inb() from the start and at some
point that inb() started crashing sh and maybe other places.

Maybe:
Fixes: 669a5db411d8 ("[libata] Add a bunch of PATA drivers.")

But this is all the way back in 2.6. I would hope anyone using this
with an LTS kernel would have noticed by now :).

Cheers,

Daniel
