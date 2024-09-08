Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237917554A;
	Sun,  8 Sep 2024 19:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725825478; cv=none; b=mVc1EuDb49BWfUG8Sdw3fdezlnBncNr/njCUTn3B3hPRDz0WJMJSxEN3/d6MkXGCL51qYXTSUczfOxSd456Ac++mpDy2EZbjGUaTTmvQMNT2371Y39AAWUeTweTQr09aiBcTj/xk8hmnsXSAsRykwEfwPZtODK4Ew0W7WdYj25A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725825478; c=relaxed/simple;
	bh=6iRQ4ycMPuueLuQbrmkO5BYrgQaV5z5SVussbCyOKoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJXBE+icaEp8SGPWmF3ntaSaOut/1NBNz8tOQ/LXC8ZalDuNy1jrubdYpdIB2McZjwtnH4rdjph7xJyfEf6xpONR1Yh9lCnOxCCDxB+YasX49jQHUfyqbAXQWNQKIPsa4we+6lXePW+4Jq/IAwcpuEKpE+0NPH0XZwrZDIaI5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e02b79c6f21so4218105276.2;
        Sun, 08 Sep 2024 12:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725825475; x=1726430275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iRQ4ycMPuueLuQbrmkO5BYrgQaV5z5SVussbCyOKoM=;
        b=hMYSJXWQveeBIzsHNU6pUQwZ3zdIzJm237c4B3/KA48tmaq076Invff2qT4Fc2aQu6
         oZ3OfC8lzIGgAR8F1n8pBBnjNtHEqqo5bpqIdA7Hpa2osiqLJL2wRTXrzRGkLLpmgs1x
         IT8+ymKZzd3UsELtmCPJX/ASt1JNnoVn3e0FqHrVseB0OTVH7fDK14l93MsRXXVd/s9+
         CKnPNX737uYEGJH6xChcqANWfhvAIlhVOcwV26BbpHj3ExOFOmV1fQMt7ftCnxj93lAx
         mN8WcODhPVA6a0KBaCAJRvYj1zi3IVaNXBBrWMYF1yjkLTmaOORM9tcfO5oCD/oIUbEd
         8MVg==
X-Forwarded-Encrypted: i=1; AJvYcCWeo3507guALs0WN48A/aAIzD9nlCJzboqhfMtu7d6c/h3MMJTWkizWQiGQFzhMufNiy+xHpOP2R7YbKu4=@vger.kernel.org, AJvYcCX6WUWvOteYutmYYxiPC7HkBrmbHSYBNkC457cstD6xnGtSJ3rmHEvmwtTD3u/DpqddQwt/9jMKY5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLJ6HXVwwp9LYeuB5MDCeOK8ooARHwfrxMbrLZQOpLQF6wnsD
	xFTzaPOV3hvpNnjWyc/IGhjgeFbuubkP5M49SRD2yXzX8hK/MatR
X-Google-Smtp-Source: AGHT+IHbDiMdtH2pqnAbxLEMjAlHcuY4ygwDQW8Q8ews50/boV7RDQlibc4OTUwRVZ+TyW4cporrAg==
X-Received: by 2002:a25:cece:0:b0:e1d:436c:3b4f with SMTP id 3f1490d57ef6-e1d436c3bd7mr5094797276.50.1725825474790;
        Sun, 08 Sep 2024 12:57:54 -0700 (PDT)
Received: from [192.168.2.254] ([70.24.204.168])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e7723asm14597531cf.22.2024.09.08.12.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 12:57:54 -0700 (PDT)
Message-ID: <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
Date: Sun, 8 Sep 2024 15:57:42 -0400
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
To: glaubitz@physik.fu-berlin.de, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, mpe@ellerman.id.au,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <20240823125156.104775-1-dave@vasilevsky.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I received a notification from Patchwork that my patch is now in the state "Handled Elsewhere".[0] Does that mean someone merged it somewhere? Or that I should be using a different mailing list? Or something else?

I'd appreciate some guidance.

Thanks,
Dave


[0] http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20240823125156.104775-1-dave@vasilevsky.ca/
