Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57981AA8
	for <linux-sh@vger.kernel.org>; Mon, 20 Apr 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680434; cv=pass; b=hYo9byYezkYGgpEFbPO0YD4OASKbJEJrbOIwe0vy2VxboYnEqg5hM9BwwWkZglurjWvafA6ZIXJZhvU+MVQpub78395aZAJVlE/Jwj9rp3cPt8it4G7JqcPrnSbU3z87sYb8oJp/KM1yM0x3DZ29/cDehJ3wEEhelIuBzAwZ1F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680434; c=relaxed/simple;
	bh=B6SkrHrTCWL7OA3xcFt0hYh8QwPDw/Iywyn7D8WtvHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2rdWUOoXtmqNGy6Fj0BlPGREoKc0VWgVtLP2W5irGvXX48HsYvlRWYAStovrK18EVIOL0x6Bs/k/S5eZoX/fBPQ6kvboUHuMDSM3mF9nVQoXZPmMG5ctt3wX6viQZi34xAyMMvWhko5PKe8CJ/p3+a3HJV1I3rA9ypSQ9S9Ruo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qP6DoHKc; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qP6DoHKc"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67482e67171so3189746a12.1
        for <linux-sh@vger.kernel.org>; Mon, 20 Apr 2026 03:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776680432; cv=none;
        d=google.com; s=arc-20240605;
        b=VLgCuWCx8yyCoEqLOVqcb+fBLh4o6Gy/ynR0g5eJ03a+78Qq2XZqWNJzyvkivR1f2v
         WdI2evfHdeyZgo2PnX8esEpCU2SH+JEIHWUSScqbiP5CvuELI/3lXixOUIsPnnbuoPSB
         y4fQ10dJnJXKyPo6oTSlgZOwB5jRl1SxdlklR7jV/lm0fW2j1Msa7EYjoVZHmG1RIkxQ
         W6m6A1yFrD0AIsfu+NjDvVoEJ7yTKa90sehCd9u5rYb+nsHpXjpoN89Bv0vnNTYokUjs
         sp8mK5si2DJAazImKYldvn+1xNbjFQK6OXd5628WUFngqU/+y/KhDEqGRxFsl/wLHZhJ
         40tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B6SkrHrTCWL7OA3xcFt0hYh8QwPDw/Iywyn7D8WtvHw=;
        fh=T7yRQISD0yERY0gXvmjYvSbtZGnWtgsippBK2HCeEXc=;
        b=DTgVYUvUAYgYj3dPlCp6F7R0tOawFg8FNLQuexUfq041oJS6MLgkB1boI2r19ir3+j
         5BcKY0D9LtP4SWcQcYwHBdPP31Q2fgfyqiQ1nM/HsASqY6qkbB3swVSDujMQEcOzvhwF
         GhQSKn/2jltT3iT/suN8cXIsppvL1SVDcYF2IXGMLAjxSF8sF1OLkm21Bs0DvRiydkZ6
         ENm70fnm9oL8CSU1IZv2BpHQl3OMYOEyUs6wl+Q3jYC2H4QjfWgLuCEeb3db7tqMMAzK
         /iDnVhAEmoHot0D63qpxDcJiT8WoQfo5jfYmrckKGZCQqX3c8x+JUL+0y9bBgR1ucHBQ
         BSNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776680432; x=1777285232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B6SkrHrTCWL7OA3xcFt0hYh8QwPDw/Iywyn7D8WtvHw=;
        b=qP6DoHKcUEsWltClovAXYPLorpCsrEvxMp4NTq1U1eXNfekF3X15tIGXgXQWoXf27n
         Xlrq3UaMClHJ74r/zj9t7Us43+7ZJK/tMXjte6DR4yOFMcov7gYKLlwblWf2UFN3mElC
         ha3MQloEDFoILzWQcYVrIJktk3X7B9nZK5Yc97kVlPTuCKjZyvnz+yLuvuGg9vb/rbS5
         7pYPEW52+vrMDNmRFRKkLMGABsjgxsXy0XOre9eXzFf7V1KpW4qqSuqcH8YyH5r0Kyrh
         knk2Tq8jocjocA9gjQZ0OEiexGPZFZFVTkhfm0DbcYU+RG0oPaxH+gEcTM9Mtuq4TWzS
         8+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776680432; x=1777285232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6SkrHrTCWL7OA3xcFt0hYh8QwPDw/Iywyn7D8WtvHw=;
        b=lSWB5ZaPgt5eU3euu1kcLE6NklD8queqrm+LOI5CszDar7A/Rx88/3XqCftoHYYbhs
         uiq55JgtQBvyzH/GS3aDDE9t7v0CQCckNEz2q3t+oykyl4YHTIHBsjhcJ+z6uMNiiIIy
         a9VJntanZLiZps6mme4oV9uYy/FB58lWsM9cBCmhJI1NkDjnXAhHtGSI5V5FBfxbrXkx
         sNRNUaz5mVlDcrMh3hw1WlUF8dmcNtr8OZI7lYgl2jnUO8ib53pQ9VvFW8u46vvsB4ob
         LnV2VTY1sEYe2FXylktklPK2Ury2wxwbwq0ZaANa+aND7OatsLvi3CEDWhXZh2vUbfS6
         4s1A==
X-Gm-Message-State: AOJu0YwbJtn3jXp0dsr/K0ADN9MoUtGMkARIJnkKfwLjNx69liaCm6xx
	DWfEx4sn2aK9bSxuvXZrRsArFR88WaDcRMShkL1XdzzJAT4dLx9CfHt0s8FiOC4QkVkey0fFu1m
	ery2QVDdkkDDzj8CXCmDvrHcDTqA8NsQ=
X-Gm-Gg: AeBDieu6TUT94Llw+BISUi+f9es3xqhnFKNN6FwDMavOxO/SlEgHQwQkD6DRqPZ8PGX
	hZCsQMyBRFu8PO82EKxzhS+jK/C02QX+8LYDQGLKr3r3XPCzqCQibBRHPsYgti4+c0o+nDP6+uc
	DljHZeQfxMHHis2gSrKPD/S15T0OHzwDC1o9OPD3pXv75aj8qGV5nYzsjNkR9l9YMBr6vJUCltw
	SpZ/r3U7GPkT165Lm9lt9xhOPknXrEB8K/Ia+4YAQyQx/gGkhdR3qjyCyXEWnQs+Me+lJuImQLT
	1iDzqPPc4Kx4I6eWdL3numycKPpShm63u2z2twIZygjj2OGBLltF36PGrRZ9WfqV3mvTgX1HZ90
	tygrAuGlymn2+zQsYXgD4mw==
X-Received: by 2002:a05:6402:3604:b0:675:a78:1942 with SMTP id
 4fb4d7f45d1cf-6750a781b14mr1827673a12.6.1776680431577; Mon, 20 Apr 2026
 03:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419162823.2829286-1-fuchsfl@gmail.com> <20260419162823.2829286-2-fuchsfl@gmail.com>
In-Reply-To: <20260419162823.2829286-2-fuchsfl@gmail.com>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Mon, 20 Apr 2026 11:20:18 +0100
X-Gm-Features: AQROBzBeYbf5dx_rODIsWccvDzcWgYcchkjyN9R4YBTvayVTPrm0fC14QvKFA7A
Message-ID: <CACwZE5RD2Jm6ssUJMwQBzVcOuT-Dc1jxg5tA+reqPM2aPXrqTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cdrom: gdrom: replace port I/O with MMIO accessors
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Artur Rojek <contact@artur-rojek.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Apr 2026 at 17:29, Florian Fuchs <fuchsfl@gmail.com> wrote:
>
Not tested this on real hardware but I can confirm it addresses the
identified bug and is logically correct.

Adrian McMenamin
