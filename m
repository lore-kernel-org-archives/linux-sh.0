Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FD61640B
	for <linux-sh@vger.kernel.org>; Fri, 12 Jan 2024 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="oV+eyzUF"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7baa8097064so319276639f.3
        for <linux-sh@vger.kernel.org>; Fri, 12 Jan 2024 12:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1705090303; x=1705695103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+m+8+sn/yrRpMNmoKuVGJnl0KXgHIO06YV19abnxPJI=;
        b=oV+eyzUF9mjPBBKXi7sOi0E6ipHIopSk2V+AaXbE2KUaLX2JkgMQLsZf7EnFyT2A3C
         ty0RCoySkd949j1KrinljI/zljDDs9tALeUOejOWemr1u4xSdt1bIgwrjyPYFOE8fvgC
         LcSLutP4FaKc/2PDkuskMBxkffoR+N8mC0k43Qt8cCPnN7AXQbWM9h5Cvf08xJnZu0xr
         4w1KUu4mrPYMUmxuD8uF/+smMkKKASvPJvZuu5wRknnwdTDR9+xMApk/UYDHsB2HXmjR
         ytQae2aXwBubd8FkypMyujeRZ7vwILeRm6NLaiARwrD11EvsbT6SSQnhDuA4ixLYw9xX
         ZvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705090303; x=1705695103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m+8+sn/yrRpMNmoKuVGJnl0KXgHIO06YV19abnxPJI=;
        b=IcMIU0vWhNOd1Cps+XsTnNDcWoHUccqylCTVyag9mJbdKRlokjRYaqFTKwoJWmsNsT
         3TAU1friLdIKzuEIrd4KjiZAB8yZ5mUO9Rnzpm1dWLIXelMXM00ucqJH29Rh5fKa7AVu
         faEX+St9OZQHpcSCy90WOQ7MG4BlOfh2Y9E1+JyvKTriWsGjF2O1KFciqO8ixHBPMAn7
         Qfeh7GbaG+0S+//2bxBthDYQnuU7B/JedpJEwuTpKNvOjioZYQBYOTL/W7AZKWLYpnlN
         0raZXBZ3WtAitWrxV6cj7PqgNa2lz+jebtqTpuH+Kli7dcAhX4MMyu8iaEkN+sGbWAvK
         aJYA==
X-Gm-Message-State: AOJu0YzndvGIRub1i4zPcDYq1DBaaeiFvaXqnLoDPTc3BpxyZ4qrSr4O
	39w4CRJ2cvIjxxZU3/SOGBZtklWIMfVFWQ==
X-Google-Smtp-Source: AGHT+IHqoFIA5SsY0S6pP9E/YEdP51Pl+qXJMok2jHmvOWgujRF0EPJI7JOUqJM1HPAneMcc2A0bVw==
X-Received: by 2002:a05:6602:89b:b0:7ba:b9fd:a234 with SMTP id f27-20020a056602089b00b007bab9fda234mr1993100ioz.37.1705090303206;
        Fri, 12 Jan 2024 12:11:43 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id bt9-20020a056638430900b0046e25a7bb9esm1063767jab.176.2024.01.12.12.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 12:11:43 -0800 (PST)
Message-ID: <2ff803d9-748c-e168-3775-b05fb11868bb@landley.net>
Date: Fri, 12 Jan 2024 14:18:25 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Content-Language: en-US
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Greg Ungerer <gerg@linux-m68k.org>
Cc: Petr Vorel <pvorel@suse.cz>, Tim Bird <tim.bird@sony.com>,
 Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Li Wang <liwang@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>
References: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <ZZ8JbCPd3rq4u7iG@x1-carbon>
 <7e348eb3-bd34-4c66-9ed6-b5108da80486@linux-m68k.org>
 <ZZ+zB29hRhpjiOrh@x1-carbon>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZZ+zB29hRhpjiOrh@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 03:21, Niklas Cassel wrote:
>> > s/Linaro/Lineo/
>> 
>> Lineo was not founded by Jeff Dionne, see https://en.wikipedia.org/wiki/Lineo
>> for its genisys. Maybe you are thinking of RT-Control.
> 
> Yes, Jeff cofounded Rt-Control which later merged with Lineo.
> 
> My main point is that Linaro is a completely different company,
> which did not "die in the dot-com crash", like stated above.

Sorry, I typo uclibc/uclinux all the time too. (In extreme cases I swap
busybox/toybox, which is personally embarassing...)

Rob
