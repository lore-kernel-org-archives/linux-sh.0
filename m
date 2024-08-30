Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9F1509BF;
	Fri, 30 Aug 2024 07:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002662; cv=none; b=h7y2UlzjlIJcl0C4yHmH53CwDyYmICTuwAU9gdjH4YUY05xuZocfU3KMiLmh9wPjTANrDXzC3P/49yRdUSB/K7bvoUjHc2TiNuwTSOHY1jM5lvuwbG7XGOmPSGLA5DfhLmGtpQzHHXuqccpfArsuFDmLCJ1x171DWBhgZGdbVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002662; c=relaxed/simple;
	bh=LVVslDV3vhH3TXW75WoEiVqsEhuwKn0gtiz/69L72e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilEqMDfUJjs9cKsZwP+zamq7MsMOdu1egcU3cT9UZzWUUefvdDfsfBZAnDO+EjBU8BB0+hWxr19LjfqOfELXUYY42HyL2wWxq+/WlNrAd8EmaKKp2R75BFFUhudiiMjPk4R1zjq7Iq+nr52491fSyCmZ6Tcp0LCKd95rZoHKkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6bf9ac165d3so8540736d6.0;
        Fri, 30 Aug 2024 00:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725002659; x=1725607459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVVslDV3vhH3TXW75WoEiVqsEhuwKn0gtiz/69L72e0=;
        b=pB+C02vekN8xBfaXu15cSMgqFzvCYehridFsVZgF2G1LvlHXyWHFJzc9b9IVMNHaLJ
         ADeWUP8dD291a5p5q26UGXxs6x4Gi7lStNM3uHxhovruOi3FMeZnUgaGLspOuGvdUJYu
         vCjw0xnFoGWP3sI0nf6aSRCTHFUl/H0wkoAi5mZWHJ4oc8VCu49Q9VG/Y2ddnaj4eqyr
         PqkdbEvE+m0u56M5Tkq97KNosQqHHJbLdg0v7MZP6CIS0pZTba/n+foR6OY7w0jfOMVQ
         wI5Pa0AuZJtry7BGLWLg/uX7qpn1FYV47BXZDTUNzAjyBg+O9FJCD9bbYyCp/IoU7EC1
         cTSw==
X-Forwarded-Encrypted: i=1; AJvYcCW3OlbENhC1glgnA4WqIsS4wtjlkhJ9hqa3JIhVeHqTBbJjW0C3AMQ2agLoUI+iXYez2FVeDs2JVLiyaY0=@vger.kernel.org, AJvYcCX79WgyZDVEWaBxBS6FuZaMsBeQvnOnmoOE8yFkO3zdcnpJz80pxEid3+kuH4tAuEl7wZ1nFKrhZgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0KpsKYJrZhuLtbYbAfr3FN6T/TLVMVUWdVjvFEfPR4FjtX81V
	ufrBBbFmEJvj5itMTz7UXRwDdWPCzJ1yOo5N4n9VmPMT1NW88Qh9
X-Google-Smtp-Source: AGHT+IHTmrzrM2U/eyTLZYz6w/tWs+TLwJZ5juO5eDi0aDfQrqBJTTIuzoqHW54tkQxTg2xYjnmIBA==
X-Received: by 2002:a05:6214:419e:b0:6bf:9281:96b0 with SMTP id 6a1803df08f44-6c33e626c75mr53795666d6.33.1725002659506;
        Fri, 30 Aug 2024 00:24:19 -0700 (PDT)
Received: from [192.168.2.204] (bras-base-mtrlpq3141w-grc-05-65-93-184-127.dsl.bell.ca. [65.93.184.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca65b3sm12308646d6.119.2024.08.30.00.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 00:24:18 -0700 (PDT)
Message-ID: <e12e89e5-9617-4515-a3a5-19cf9a6db624@vasilevsky.ca>
Date: Fri, 30 Aug 2024 03:24:17 -0400
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, glaubitz@physik.fu-berlin.de,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, mpe@ellerman.id.au,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <ZtFoMMsS5PuFw3LF@MiWiFi-R3L-srv>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <ZtFoMMsS5PuFw3LF@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-08-30 02:35, Baoquan He wrote:
> The overrall looks good to me except of the CRASH_DUMP=n on sh, do you
> have a comment about the reasoning since you have discussed with John?
> Is it because of below config items?

I don't yet know why John asked to turn this off by default on sh, though
I'm sure there's a good reason! John, I'd appreciate if you could chime in.

Otherwise, I could split the patch, and we can discuss the default
on sh separately from powerpc.

-Dave
