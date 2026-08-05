Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B313F4DCA
	for <linux-sh@vger.kernel.org>; Wed,  5 Aug 2026 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922152; cv=pass; b=jrAEt9bdMRZ1XDu4QlfN4LH9aMhuCBTQUWULeFwCHnrmfNlUcmQu1nZ792aVzxFwW3UVQqY2yS9OTVl9m1YwKXtM9In+N8Wkzx7jrPo0JnD0uQicJ/z0diUbiE1OugXWPSp934UOVVDh7r46/eyNoLCITAdQP2lpCJEsbla2Ho4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922152; c=relaxed/simple;
	bh=2CYxhUN06atxgyD+NuqEfp0FHRHqnrmTcjPfadvW5lM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgqXwOsR2N473OvQYQSRFJdUeugDkR6nuKVtzvm5OZQhAHz+nQg4lBYmdZROPMLJ++c539V7tcjOhfWQbl0krvAKI+ILEY7qYpPPMEJIVY0C9qmM3/CpWyHiaAfWWydTGa8p2Ar9f9O40tB+drNnPkNiHiqQI6v0yFSd18cCCp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oRaHTj72; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRaHTj72"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a097f5ab95so1073639a12.2
        for <linux-sh@vger.kernel.org>; Wed, 05 Aug 2026 02:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785922148; cv=none;
        d=google.com; s=arc-20260327;
        b=f/ElWFXr/0MS5PgxfTKEcSUidd4C+p/ZiJaooMWG2SsJgkAk5zKgTlkBc87ZJF+k9d
         Hf8fXH4biyxiJtxc54GNV7yw+LmWRVsoGmqHELRn51R3pZVUrrOUg5XQv4qhtk7+ARpv
         xQIZ5kQkQMWnHNXW+vDUPyNg84G3wg1VctDXhSxmu0fRthDxygNLyyUi037PFNPCwN9i
         2rwjsvwaaGGcYPMIME/MdDq4Ztkvwo44bEl/VfQiwuvOMfImUuZmzTArBp9If+pyMwY3
         uVEK4YNnfCrx6NdEdOKK9/AGCEaA0tO6o9QR2lWbtIxHm6p6rniVtwaAUUrZw8stKeBe
         ymiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        fh=9G7q0M7HZouHe2qZYUGqYTlfPATjWZuUqZqjzy5YpCE=;
        b=ZNO+AFWJ/4RndvRuzuHeA46MaknEaFscBwPCR9bQCx1AT+AvBD6buBhowBxKkQV3t/
         E40D3CWswFuxXXpkSYlabQEq73F9z4iSVKnOtlOQaZ6YXJz/kwJpS8pi9B3xzvcd8Aec
         0Ks4VWvwZhkQijmf4MJrPsFvVsJUa6OGCa53Yb6C0nTDRcDwfTzaE5ldpJZqPTpLEPQh
         8k5vxmPO3VPG4pm8kA7c5FRvd8TrgZP1d6ixc1ElRwWOBQUIm2fNLvL9BR8mMhygcuUM
         TG2b8KcZqmlQNvWQbEYPfS0TkpITTzOe1+FkGUnvsSCXxR4yOlx7narhWhLhNwkXhP0T
         19DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785922148; x=1786526948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        b=oRaHTj72e/XrckuRkA497cnrlo9Fzk7mRBhBXJ1RaHvG+7+2R4vfQrOftchvPQCl/P
         k38QsTQmHSL+o3EqszzoPmxowRxK5l6gqFLnPydloJ6xxUi5if5535ZIQAYitjcu0O1h
         HPKlnfL3fOxxo5uv/mNQpNaK4C87gz3GvP03hg7viPShIQaEPK4/Va4yQSRtx4yN71sh
         7xebecoFtAEsMGmUSloibOVe69FFBOnuJ2IZeqeYn9PUE0zUR3wALOwo4xTWieb6caEd
         5yxFYxilUTzGGFmWNqfK11/uoPLsvyvM/a6IwhXO5V9wvTsI/+rs65fsWVeKLolF3nSn
         NRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922148; x=1786526948;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyPWfyEFm2OExA3jphd/8vOHsrgk8sKB4KgKaoO1auA=;
        b=ls4L+T9plWLm8TkMbf2ciOPlmookrgAMS+KU1DYBNS0elZAEEQLLvUqoVsVMRjCimq
         kYLvV8S7pBX0yfWez/6alNjEu3PbpsccnmrX0gQYNLzCkpst6Cq1fkfTVstYkzJ82XKg
         Hh/44EkBXpDEApqqL5GS3+kpxbNYcPYuIaSlUvvTjg7yoUrrQLPxOZRrjSINA/zh+Cpg
         rGXsfmftGUU+6CJmJXqVqOyQI6BdcnB1lNX37w/FaqHU1Ugex7/j4tweq7ufFe/qfdNh
         q8Vj86d8P8qmbwwyJ8rrcchZJptXn34mEb8ZbTc7JI+jhti712jm4vtCALMdHNR26w3y
         nkQQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqk0/Yj9z7U0gnRx4TD9t1WTloxVCjMUVFStOD1iYxKguFJihBaSC9nCRrltiue98Kd7qJUZDbrXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hPmZNCqSWM8J/nSgHN+LRv2Gg8xOxVqLO1bKpgTDsr+Os3Tt
	fgXfyMdoNSKVscvVDMm0o38uM5WIGFNwSEGiFSiMYJrZVZzKHty3VYrEDMAzfEAl4+SWKZbF/Wz
	BbZb2MVFTwnGiCaeajK8LOhjCeXAgEwY=
X-Gm-Gg: AR+sD10sbu1vOoy6RaMi5d1qtRmlLxkhENJeBv9dTw7D6f9UntTb1HE+vGRgwIOsfFf
	3VT2EwXEZx0yHXAX5599mWhXcpaWXmgLMWHkxuwW8Tcd1nvNNFV5Jf3qQFmdJv4iwumLJQ59L8/
	RwqpmxfVcZ+0s44YD2hL23WSe6A3i788/cvUQywlA/Ispai1XfIS9Sqx94lBmrj5tisWL1P81Kz
	AA3L7hc1z8WFnV09K5t2k/H5cBxAzEwabMV6rkoF2mysa3vKJ+F5rfmGb55lrLGWtGBeu/oHfbM
	5V8uDeRQ20rwvxCrh5+Tkb4Sw48ri8xBqVmx8kvFOsbimDs9ByPlJWPmxuHos6DJwOz2TYH4ZK+
	D6uVnt+ZOSyd+dK5IKPBHX4KZlcUyb1M=
X-Received: by 2002:a05:6402:4543:b0:69f:2c1d:d83c with SMTP id
 4fb4d7f45d1cf-6a14f2893e6mr2121332a12.21.1785922147806; Wed, 05 Aug 2026
 02:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-alpha-fp-exceptions-v1-0-c99d75608e60@gmail.com> <20260803-alpha-fp-exceptions-v1-1-c99d75608e60@gmail.com>
In-Reply-To: <20260803-alpha-fp-exceptions-v1-1-c99d75608e60@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 5 Aug 2026 11:28:56 +0200
X-Gm-Features: AUfX_mytZOAo7u-Z1H4SHvHV7AI6aSPHWr2nPnsXtr8HsGmlt0ibWkok5AeeFvA
Message-ID: <CA+=Fv5RaZZeRvixhLYZVmNsWowBw7oWC5Z6AvbL8=c80CM6XLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] alpha: fix ieee_swcr_to_fpcr setting FPCR_DNOD unconditionally
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:40=E2=80=AFAM Matt Turner <mattst88@gmail.com> wro=
te:
>
> ieee_swcr_to_fpcr() converts the software IEEE trap-enable and status
> bits kept in thread_info.ieee_state into the hardware FPCR format.  It
> contained:
>
>         fp |=3D (~sw & IEEE_TRAP_ENABLE_DNO) << 41;
>
> FPCR_DNOD (bit 47) disables denormal operand traps: with it set the
> hardware handles a denormal operand itself, treating it as zero, instead
> of trapping for software completion.  The intent was to set DNOD when the
> user has not asked for SIGFPE on denormal operands, but
> IEEE_TRAP_ENABLE_DNO is clear by default, so ieee_swcr_to_fpcr(0) always
> set DNOD.
>
> Instructions built with the software completion suffix therefore never
> trapped on a denormal operand.  The hardware silently substituted zero
> and produced wrong results, affecting every program compiled with -mieee
> and default FPU settings, glibc included.
>
> Set FPCR_DNOD only when IEEE_MAP_DMZ is requested, which is exactly the
> case where flushing denormal inputs to zero is what the user asked for.
> DNOD then encodes MAP_DMZ, which ieee_fpcr_to_swcr() already recovers
> from FPCR_DNZ, so drop its attempt to recover IEEE_TRAP_ENABLE_DNO from
> DNOD; the DNO trap enable lives solely in ieee_state.
>
> Both functions are in a uapi header, so the encoding change is visible to
> userspace, but nothing outside the kernel is known to depend on DNOD
> carrying the DNO trap enable, and the kernel is the only writer of the
> FPCR.
>
> This must not be backported on its own.  Re-enabling denormal operand
> traps exposes a second bug, fixed in the following patch: those traps
> usually find an exact result, and for an exact result the emulator did
> not write the FPCR back, leaving hardware-fabricated exception bits
> visible to user space.  Taken alone this change would make spurious
> exception flags more common.
>
> The bug predates the git history, so there is no commit to reference in a
> Fixes tag.
>
> Cc: stable@vger.kernel.org # 5.15+
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/uapi/asm/fpu.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/fpu.h b/arch/alpha/include/uapi/=
asm/fpu.h
> index cea9eafa056f..d28dc36786e2 100644
> --- a/arch/alpha/include/uapi/asm/fpu.h
> +++ b/arch/alpha/include/uapi/asm/fpu.h
> @@ -101,7 +101,12 @@ ieee_swcr_to_fpcr(unsigned long sw)
>                       | IEEE_TRAP_ENABLE_OVF)) << 48;
>         fp |=3D (~sw & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_INE)) << =
57;
>         fp |=3D (sw & IEEE_MAP_UMZ ? FPCR_UNDZ | FPCR_UNFD : 0);
> -       fp |=3D (~sw & IEEE_TRAP_ENABLE_DNO) << 41;
> +       /*
> +        * Disable denormal operand traps only when denormal inputs are t=
o be
> +        * flushed to zero.  Otherwise they must keep trapping, so that /=
S
> +        * instructions reach the kernel emulation handler.
> +        */
> +       fp |=3D (sw & IEEE_MAP_DMZ ? FPCR_DNOD : 0);
>         return fp;
>  }
>
> @@ -116,7 +121,6 @@ ieee_fpcr_to_swcr(unsigned long fp)
>                              | IEEE_TRAP_ENABLE_OVF);
>         sw |=3D (~fp >> 57) & (IEEE_TRAP_ENABLE_UNF | IEEE_TRAP_ENABLE_IN=
E);
>         sw |=3D (fp >> 47) & IEEE_MAP_UMZ;
> -       sw |=3D (~fp >> 41) & IEEE_TRAP_ENABLE_DNO;
>         return sw;
>  }
>
>
> --
> 2.54.0
>
Hi,

The new mapping of FPCR_DNOD to IEEE_MAP_DMZ looks correct to me.

I tested the complete series with CONFIG_MATHEMU=3Dy on the same machine
and using the same glibc build. The kernel boots normally, and the
glibc math testsuite improves from 48 to 28 failing test programs, with
no new failing tests.

Reviewed-by: Magnus Lindholm linmag7@gmail.com
Tested-by: Magnus Lindholm linmag7@gmail.com
