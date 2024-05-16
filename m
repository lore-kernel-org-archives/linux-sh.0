Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB01139F
	for <linux-sh@vger.kernel.org>; Thu, 16 May 2024 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715891459; cv=none; b=Qt/o08WbqA/irRpaHlSgwpp1sqQfpl1wjhC0sQWeG8r/Bp2zKYTUl5zZNpC3pP+DxNeOX9KnAZbRm8oCG5p3XCsli0GbhiPNVrmWWoZsyMUFHpLThoX6gK5D5BaHh2zAncvxXD5KFNo9OrjuvtDvSTRtk463QF9PocTzFeNn9UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715891459; c=relaxed/simple;
	bh=AQFvQ3gEyY1b/nowZGlF+LOuIVEWz7IqKRxK8b+L25A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9mHCLQ1jf6iiWVcMRymunItS9rSt042wmhmDTjsFJRvrEaLcZ9wE8wKawuucM3RnXQZbKnDZYg2pi6iPwHvAuRy8FN/+U1kc5zhzwxHxkk7jW3dwAESfiGVEFQmEVg/8j4N2Q4xoCPzzBJSfgZYMLNQguFP+zIRI1yptsztTto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5LJD/u4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5LJD/u4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715891457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PAA7GiAkKuI0eW3rv0UgjZZD6bWQQlMnXksO+SeSYYM=;
	b=V5LJD/u43BnJJcoxuo0ZBEnbCJ+KqP3Ztp1lma+uWYr4utVEx1buyFIIHd/RcQx2wcLxZB
	XzoVuK1vmEXFkIW4zavd6BwY9VAdUBk6Sf7xYsVexgeqY6dmFnNhbvSKKWmXugDkkGc6nn
	jvPnWfbWpN5fu+TScb4+NcuaeVT2WH8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-Tvnxi9JeOnOhENQn3cbjig-1; Thu, 16 May 2024 16:30:54 -0400
X-MC-Unique: Tvnxi9JeOnOhENQn3cbjig-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da42114485so972039139f.2
        for <linux-sh@vger.kernel.org>; Thu, 16 May 2024 13:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715891454; x=1716496254;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAA7GiAkKuI0eW3rv0UgjZZD6bWQQlMnXksO+SeSYYM=;
        b=lU/EtUKdalcx6ouZcWMkzBTS6OSZMkUeqUcSerkGlER8SfVN9Sz9jErbz6WylotZqy
         /Druff47L/4ZRn4wm7NML9ZtuCC6W6f3C4PJyqQvQ96kGKoStDZlUuN9obunPM4FCFRr
         3z/pdBDxXWIzL2Fl4m/6MsfiAoJ31GPkdhCW4uTi9f9C8qE+dbJwJQftNjo2b3zY0Tqh
         4JEg8b+xT2NP4b+GGXCgtqSjs5TUD8ELdsD6cBpZbzL2/sQ3fqyqm2EvJSxIvI7BX2t6
         +RYKp5cy72hIEWjKMpCfX5Ib6Qz0WKGAYFJCjde36MN+Ty+xHP76GUtIeX9sqPGhkjFr
         fZXg==
X-Forwarded-Encrypted: i=1; AJvYcCWP0A+CSMg4VH39NPgHu+FNnHrvzF8xPJa6VwgyQPEULJqh7OMPR9Q0R7ifLwk66Hc6kceo96HfYQ84QQQewTAM3Zo4QtUGaew=
X-Gm-Message-State: AOJu0YxCKIzaEHvckfkAK/gxzroZrO7c9o0mhsIGg+geHKWdO6R7Nbsn
	kWeQegZkTH2q9SL0zD1b+6HIVAFRgmoqwZmb3L7xa0nzlBh1LbbZYzg3IIJ4SVHXdAuwh5iHlbs
	wicJfqSpVj5kDjQS1FJ0zt9p3jT1KsvFHGyeUtXMW4aOvDH0r7w4AvIMj
X-Received: by 2002:a6b:f20c:0:b0:7de:b438:569b with SMTP id ca18e2360f4ac-7e1b51aa826mr2373351739f.4.1715891453895;
        Thu, 16 May 2024 13:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIGnR02+Iiam/Rdyf+8CP8/AXCLqJX1xgmZ1LrfHU25D5hqL6hxvmytOM/koRxjcurMAZG/g==
X-Received: by 2002:a6b:f20c:0:b0:7de:b438:569b with SMTP id ca18e2360f4ac-7e1b51aa826mr2373348739f.4.1715891453484;
        Thu, 16 May 2024 13:30:53 -0700 (PDT)
Received: from [10.21.161.194] ([65.132.165.41])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489371415a7sm4210441173.70.2024.05.16.13.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 13:30:52 -0700 (PDT)
Message-ID: <eb75bea2-ca49-443e-b789-b022ff29890f@redhat.com>
Date: Thu, 16 May 2024 22:30:51 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drop memory-hotplug on superH
To: Oscar Salvador <osalvador@suse.de>, glaubitz@physik.fu-berlin.de
Cc: geert+renesas@glider.be, linux-sh@vger.kernel.org
References: <ZkZruHmlKd7GaRHs@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZkZruHmlKd7GaRHs@localhost.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.05.24 22:25, Oscar Salvador wrote:
> Hi,
> 
> After talking to Adrian Glaubitz about superH and memory-hotplug, he mentioned
> that currently superH runs only on 32bits (there was a 64bit version but no is
> longer supported?).
> The thing is that since the below commit
> 
>     commit 7ec58a2b941ed88986694d037e38012738323171
>     Author: David Hildenbrand <david@redhat.com>
>     Date:   Fri Nov 5 13:44:28 2021 -0700
> 
>         mm/memory_hotplug: restrict CONFIG_MEMORY_HOTPLUG to 64 bit
> 
> 
> 
> we no longer support memory-hotplug on 32bit platforms, so let us drop the
> memory-hotplug code for superH because it is a no-op at the moment.
> If there is ever a 64bit platform again, we shall re-implement it, and we
> shall do it on CONFIG_SPARSEMEM_VMEMMAP, since we plan do make memory-hotplug
> dependant on that, and drop support for CONFIG_SPARSEMEM &&
> !CONFIG_SPARSEMEM_VMEMMAP environments.
> 
> I prepared two patches at [1] that drop the code and the CONFIG_MEMORY_HOTPLUG_foo
> from the Kconfigs.
> 
> Let me know if you are fine with that and I shall send it.
> 

Sounds good, let's rip it out.

Thanks!

-- 
Cheers,

David / dhildenb

