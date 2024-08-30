Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52536B0D;
	Fri, 30 Aug 2024 03:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989064; cv=none; b=rieu2T3MOriUudlqE3KgXku+dmd7sHHPU1Ksw0TCz4Bv47/HqUdjs94bOO2cAX32GwWSJDzGUzNdx0oPqOj54uP390//+59ZD1CqzgdO8IJXX/R1zlG+baQcDD1PILtrViLMhvMYiVyDGqAdj+oIRfK1alWyxzgaDFMrUbLAIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989064; c=relaxed/simple;
	bh=FMSFomMO/tzcf9mszOogrFHifHKAs7T3PX3Od76URIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcptIWGax502TcWuKgBcdX2lwv4HT+WIGWkN5UGNUoRIJVqh6UX1GghlrKwYes6yu03Ax58aHiWC5Np517EcgjjrucsqoiNti8goQESkzHSYADy1eK9K4rHw7rwDQncVpkU0cUL9J4U6Z63d8Jxy1/sB76DAC+V6iHx964Q8gk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c159150ff4so7849306d6.2;
        Thu, 29 Aug 2024 20:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724989062; x=1725593862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo9L05Z0QSBRe+YpGa+Uw+0Mfbc5M8wNwQrY2Gw1TrU=;
        b=HAeNqk3JiZxpBG2831ru79rxBG1yq1YxqdJnhpomySrKIjo581wm65Zh3HNhLE2pre
         Ko7ehoQIvuic3qxaNsPuGiEg6txdFD9YeKscbXg7zpSFs6zRgla08p7SpCFoJSVlJVKE
         jMbM7mVddbrzJMo5YbJJvELPqw8oRgU5b0kqYMe+JrG9C7CucBpUGybKjQJNurx3dZEG
         zfg/H5AdC/z2RqgePzyZ83x3Xp6jSdOdSx4LYXzhWxGeR8huDJF5RHRJ6nCktaP3PVaT
         8NjI35p+A3NetfVdEU7B0rUmHkVoV7Z6ngDYKw6lVlXhuaEMZh0hlbCH54Jxu5zHxXuu
         YwAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7FheQmKFJBF/8AOPevGj2pP4l4r7D0hKcKcu8SALTVyqW5IOLEDOgWlL5x3RxpZKk8TmflVeI3l0=@vger.kernel.org, AJvYcCVM2+7B8/a+Ri6nND6kbdSgV+RElMoN0jfveOTb/HeezNzmHi+SOlAhwHJaCL8MOnOlES4TYjPHJa3pyes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9UA5tNCuCf5I9YM+gzUZEFrzMK1v61sJo4CHl6x69nSU3Uu50
	fzSEckgotdSOZFIcBjL23GWUNKahwL8ed0A/ym4CGaCAka1EQIlr
X-Google-Smtp-Source: AGHT+IF5lvFeC41ykAP/5lmiaGuGSVJ62dpKhpYmw92FoqNUdVPe/V37Z2IbmmFTugcCgHwIe+E9QA==
X-Received: by 2002:a05:6214:3d9b:b0:6b5:d73d:918f with SMTP id 6a1803df08f44-6c33e4f053cmr61325206d6.0.1724989061710;
        Thu, 29 Aug 2024 20:37:41 -0700 (PDT)
Received: from [192.168.2.204] ([65.93.184.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bfafaesm11005716d6.22.2024.08.29.20.37.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 20:37:40 -0700 (PDT)
Message-ID: <1568b378-5592-4d23-a572-4e09f3996331@vasilevsky.ca>
Date: Thu, 29 Aug 2024 23:37:29 -0400
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
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Reimar_D=C3=B6ffinger?=
 <Reimar.Doeffinger@gmx.de>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <ZtE5Z/gDR1WixG9S@MiWiFi-R3L-srv>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <ZtE5Z/gDR1WixG9S@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-08-29 23:15, Baoquan He wrote:
>> +config ARCH_DEFAULT_CRASH_DUMP
>> +	def_bool n
> 
> If we don't add ARCH_DEFAULT_CRASH_DUMP at all in sh arch, the
> CRASH_DUMP will be off by default according to the below new definition
> of CRASH_DUMP?

Yes, that's true. But if we don't add it at all in sh arch, it looks confusing
in the search feature of menuconfig:

> Symbol: ARCH_DEFAULT_CRASH_DUMP [=ARCH_DEFAULT_CRASH_DUMP]
> Type  : unknown

So I thought it was better to explicitly set it to 'n'. What do you think?

-Dave
