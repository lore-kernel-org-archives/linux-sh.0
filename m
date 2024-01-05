Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C455B4403
	for <linux-sh@vger.kernel.org>; Fri,  5 Jan 2024 03:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="ZCrzf3hA"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-680c7cf2ab3so5565016d6.3
        for <linux-sh@vger.kernel.org>; Thu, 04 Jan 2024 19:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704426333; x=1705031133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O8c3ESdi0IpZK01xiWxgeJ4UdiYi9dbopai5vRQAmfM=;
        b=ZCrzf3hAxojmPURXjyhmjP55vobVpOhNUc+p71kECADzYXsC/m78kAwcFOOuZ2k5SL
         +D/CJXn8PDyOT1UgdUw+akNGUaIhYHVAvFxlZfZg9FKnb5VIqGpvoaWof03eiYLsVun5
         +cZMl+K8A56Mq6MCr3uNK5Mja0lNk1Z4pv52W8CJXqG14IfYgw9bCmEBfV9VjOGsYMic
         1VblRaUocYmokkMkJbt3q6AolZsc7neXzpovAjECE0gAbpSrdEHKQApF8OW+MMMiaGMc
         F1pFZQ6v+v7HHaOlx3KTJ0r8vVVRNS+1xVEyHHhFyv3rOAaWu+nF3rjBwWAgIMBp/EAn
         4aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704426333; x=1705031133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8c3ESdi0IpZK01xiWxgeJ4UdiYi9dbopai5vRQAmfM=;
        b=Vr2RVzoxdAZfMGoEOTE0WnGdspaAOdUhYKcQauSbbJvaQ+YC+8YkDFowWAyUVw1XKp
         c5NeT+66M0Dh4nz070qyyv/Qdqb0RV/cQoHH8284GnhjLqDw5Qa0qkma1jxFDVxOExGR
         HL6taJxmGzKLvGBZLNR2DuO5LPJrHU68AL0XqMrebftNU8Am/Dh9Hk3Qa2Y2BzGnjRy4
         agY10/7xD0GQELC3+lSfwgPfz8FP2E6uIaISVk8IeEkWGsT73YodwWgmz9rdu7QW9Ea3
         M/NktRqH5l5tDfGSPLnivbaHImVRGSf4gpinxSj06TvkpBQPztMUJye9KMcbeKLLS2dC
         3HSA==
X-Gm-Message-State: AOJu0YxKqOM3mPAq7X9It6sL3YtUJPgegTBUwcipuk1uIHmhUGAojtEW
	lXJP8narKZ4DACNhmSrO2WUJS+ekTyWaQw==
X-Google-Smtp-Source: AGHT+IFbkA2aPU2aI39vcY4LyLCBENRrl6F3tJNOaay03B3PVHlOWcvhr88DceJ6bvJ0p4z3390ecg==
X-Received: by 2002:ad4:5742:0:b0:680:d233:9d7 with SMTP id q2-20020ad45742000000b00680d23309d7mr1637485qvx.125.1704426332729;
        Thu, 04 Jan 2024 19:45:32 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id n12-20020ad444ac000000b0067f75dbf08fsm307623qvt.11.2024.01.04.19.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 19:45:32 -0800 (PST)
Message-ID: <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
Date: Thu, 4 Jan 2024 21:52:00 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/36] Remove UCLINUX from LTP
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Andrea Cervesato <andrea.cervesato@suse.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>,
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
 <ZZVOhlGPg5KRyS-F@yuki>
From: Rob Landley <rob@landley.net>
In-Reply-To: <ZZVOhlGPg5KRyS-F@yuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/24 06:09, Cyril Hrubis wrote:
> Hi!
>> I am not sure I agree with this series.
>> Removing support for UCLINUX from LTP is almost a guarantee for
>> not noticing when more breakage is introduced.
>> 
>> How exactly is UCLINUX broken in LTP?
> 
> As far as we know noone is using it and nobody is maintaing it for a
> decade,

Nobody is maintaining "uclinux" because that was a distro, but you can build
nommu support in buildroot and such, and people do.

Rob
