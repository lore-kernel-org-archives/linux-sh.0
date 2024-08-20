Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCC81C57B4
	for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190997; cv=none; b=IY7exKEiwCWhh0q76hBfzvhpkPW9VCAQyV5Ph90brKTjXspuZw3yDLy6+tsABr6Bo7Np1H4NyImCy64jCjIXjiB7O1J5KB9YlOZvjtPmcWLN0k6WsYlhCGxP9Bz5BgC5rf8dZmricRCi9+BQdPZpBocE0TpwYvYR6oJ9T9urclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190997; c=relaxed/simple;
	bh=MQjzVsRoskVav5wmwGwVl6YY70G5XfPvo5+K1w/bqqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FzXUz8M7XF+oubpcjjklSMgTSOv+xMcbZEsLm/5/rDwwBauheKwTPG3DFf9+RLva/bd7QNYBfQFSGErhpx2GA/KMcwlVTEpq3YdOLzrSSbF7TE7+dJoJIcxNeHSQajMZPIVAbqA/W55z/rGY1nV7WT50roM+cDpP+IUyY9C7VBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=MwOAla87; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="MwOAla87"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44ff7bdb5a6so35536801cf.3
        for <linux-sh@vger.kernel.org>; Tue, 20 Aug 2024 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1724190995; x=1724795795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eN6vzCvlT/pCItFp6f4PyJvyvmOiWowl22YtM6dmQFA=;
        b=MwOAla87+7deAUoxWzSqe9jkP64UWEslN9+NgkHu1cTUepEYEYSwn16PcYFBA40itR
         tV0KSR0os2UI9QcFh8ugX6AaTyIGzxY9Y6oOpeSpjTctfmZTgoQn2TQPJ/6TG7DKPYmw
         M6BUtBqmim2akOllY2DDNMaTxboZzZgVMA7smfsZxUrI1O8B5WxVIL6ehyUxKwFBBClF
         d5DXq/zaEK0uqaFG+LVvrnkC5q7Xxe5uN6M6UK1ie2v++ackwplFKP2YzmeSgAwHM3Ht
         jJ0I0sJ8ca8+l4mMzSYUNCr+YovFowTaBi0+pUUaE/JMa3T5cCgZ2BHMMwJAir8YHtUW
         rpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724190995; x=1724795795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN6vzCvlT/pCItFp6f4PyJvyvmOiWowl22YtM6dmQFA=;
        b=XXxnjQrwvaFATncHKQL9+WoIRTkSsyRG+VgjY+kl4C2y2XvSndm29ynRrmSsUUdoD1
         mqsWge9zvsfjtn7bKMoJ/VIHFwoNIFyNssxabqHf7xb9OlovSF0W9h2yVo1nkohVtRen
         ggRsqRtaXZxWVCHGNW0nJa/igadgoFjr4zCwld3cAbDjKsDOcQ+1tHYQh9Iv1O8RuB5D
         T9+FQa2+lLaOjUYSLmCFugYxaYzZVFLx7MKDmDcPugdeppTmInst7JKRwWMdR+o1wvsI
         ChP0ge5nr+X+a/uYMbKZOd3pka99eb4GfhyU/pT+4nGrRN5ZDl1jJ/650loqktZ2TTPo
         RCmw==
X-Forwarded-Encrypted: i=1; AJvYcCV+E9s4D9Y6GgZzA8D0agGawA5UkL1HRc6aU+rwwOy+olLRh42rvSP0zTVfzTN8f58CYgOux9/NXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJYveyg+UpQexCd0QfkMFeNIW1F96fJdkzC6aL1FIYp0UvpVQ
	+qDK3cESmq8prG7FXEnjmrtCOJuVVpo5SMicshZNyan5Rr7by4M+98RkbTh4uqY=
X-Google-Smtp-Source: AGHT+IHXvZQTYbODvbtiWMvtKaWw7MfhUsJrv1XSsVar7SrJFLG58wKSOeDH8tFL+40SZRU1vcMC1A==
X-Received: by 2002:a05:622a:260b:b0:454:ec22:dd79 with SMTP id d75a77b69052e-454f2218babmr3430781cf.24.1724190995315;
        Tue, 20 Aug 2024 14:56:35 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454de4fa40esm18021631cf.21.2024.08.20.14.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:56:35 -0700 (PDT)
Message-ID: <67108df9-7374-a64e-ca82-8c46d67fb55b@landley.net>
Date: Tue, 20 Aug 2024 17:10:32 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com, linux-um@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
 <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X>
 <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse>
 <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
 <dff57198-7955-ec09-8909-671982834673@landley.net>
 <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 16:31, Linus Torvalds wrote:
> On Tue, 20 Aug 2024 at 14:17, Rob Landley <rob@landley.net> wrote:
>>
>> Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
>> somewhere to at least smoketest...)
> 
> The '&&' is just a typo. It should obviously be just a single '&'. As
> mentioned, the only testing that patch got was a x86-64 UML build
> test.
> 
> Fixed locally.

I deleted the extra ; and arch/sh4 built and qemu-system-sh4 booted to shell prompt:

Freeing initrd memory: 556K
Freeing unused kernel image (initmem) memory: 132K
This architecture does not have kernel memory protection.
Run /init as init process
8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
Type exit when done.
# cat /proc/version
Linux version 6.11.0-rc4 (landley@driftwood) (sh4-linux-musl-gcc (GCC) 11.2.0,
GNU ld (GNU Binutils) 2.33.1) #1 Tue Aug 20 16:45:25 CDT 2024
# head -n 3 /proc/cpuinfo
machine		: RTS7751R2D
processor	: 0
cpu family	: sh4

Tested-by: Rob Landley <rob@landley.net>

Rob
