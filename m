Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A91170B
	for <linux-sh@vger.kernel.org>; Mon,  8 Jan 2024 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c2T3111V"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e47dc8b0eso3784305e9.3
        for <linux-sh@vger.kernel.org>; Mon, 08 Jan 2024 00:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704702813; x=1705307613; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
        b=c2T3111V3t9+xUAP2vipi3qNRYeYjNE2BQ0UfqlwHCtuAQbQLcf2qSKxTQcarMM6tV
         o9w2+qUgmcv3RJu0Sv907qG4m/rxNJ+0Wmi/RG0u9PcbwHljd9KcXpO3F7J0vzwAk/cf
         hddJv0TwRt9Y6PPLtDDisnuoPQPS6NBuXTGFRIBC6AJk9N1DCoUwgK+LsCbgLRH0efZm
         ICQQeDp3RozBTBbCQ/z1u11SncBdEDra+jMw7Vzt1UXeOZyShrfa7k/t/OsSCPkH8XFI
         AWHP4Mwlwfc1awYa7EdMg/C3CtEZ8fdbipmS7+xq4ToJM02z256wvqs4ZCvkF/Sv5YRb
         +M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702813; x=1705307613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfLQg2J+OwD4mK8aB87IakjXF3Kgfssqm9r5be44QF4=;
        b=GbegAjKZMEJpMZu45wwZmtkpwiV3lX9L88YBaZkPXOGHHy6JVWBgsAXzO3EgG4hz61
         TNzRbwPaX0qp8cmxS8g8J/b8Drld6SWsZ1FvqaX7uTL4Mw9O2rIj5Sj3IhPnBgwMbMzq
         2km6iG67teec19EWpJReZ7ds2oPGVDg0kTLfVQwfTi/tDhgko/PnqcP7nUXWp1EoAf6u
         E2rmVXcBmDbRjZrs+xU2UzaLPWH6Xo4aSnlxskaGHrOodO90zl5dzYVtwl5nu0X+pvou
         GTKGqeEOkAFJuh7WucdmHSScA4BdcjbJIwT7r46XbyuX12JpUToCnoRS3GKuA9Qf3y+V
         RAlw==
X-Gm-Message-State: AOJu0Ywp4tVkIp9pQIRWgQkvn6z2WRAw5jte9af0agQKyYwC+df9iGoM
	1ewp+FTEH1nB96BKwVcxmIk/OkdbSV4aFg==
X-Google-Smtp-Source: AGHT+IFdr9+p9p3yVvUI5Yb2+RUaaTtc6lK6/0ftFespHQFyJZzml/U22xZUgZCqObC/GxElyekYhg==
X-Received: by 2002:a05:600c:3411:b0:40d:4dce:4a2e with SMTP id y17-20020a05600c341100b0040d4dce4a2emr2008525wmp.26.1704702813400;
        Mon, 08 Jan 2024 00:33:33 -0800 (PST)
Received: from [172.20.10.3] ([37.161.21.69])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b0040d3db8186fsm10246189wmq.5.2024.01.08.00.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 00:33:32 -0800 (PST)
Message-ID: <848d1908-b758-44c2-a7bd-f3e83da18bce@suse.com>
Date: Mon, 8 Jan 2024 09:33:23 +0100
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/36] Remove UCLINUX from LTP
To: Rob Landley <rob@landley.net>, Cyril Hrubis <chrubis@suse.cz>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Greg Ungerer <gerg@linux-m68k.org>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
Content-Language: en-US
From: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

My 2 cents. I'm working on refactoring growfiles test which uses UCLINUX 
flag.
During its development I had occasion to check UCLINUX support and 
(indeed) it seems pretty
broken for LTP, because nobody is maintaining it for a while and such 
tests use old API that will
be replaced in any case sooner or later. I agree with other people about 
removing it, unless there's
a valid reason to keep it.
Just in case we want to keep it, someone should take care about UCLINUX 
support, testing LTP releases for it as well, but it doesn't seem like 
something we can do inside the LTP devs team due to the lack of resources.

Regards,
Andrea

On 1/5/24 04:52, Rob Landley wrote:
> On 1/3/24 06:09, Cyril Hrubis wrote:
>> Hi!
>>> I am not sure I agree with this series.
>>> Removing support for UCLINUX from LTP is almost a guarantee for
>>> not noticing when more breakage is introduced.
>>>
>>> How exactly is UCLINUX broken in LTP?
>> As far as we know noone is using it and nobody is maintaing it for a
>> decade,
> Nobody is maintaining "uclinux" because that was a distro, but you can build
> nommu support in buildroot and such, and people do.
>
> Rob


