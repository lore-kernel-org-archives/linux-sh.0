Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77220389DE3
	for <linux-sh@vger.kernel.org>; Tue, 13 Jan 2026 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299818; cv=none; b=jxKYYeC3M0LLvGdHBRh6SLoxCDy4YMmQQV/WpobM5UM9r8pQ249F7oNsdV12JvZpQhov2QK5dnNAK23tnXxVaXU1CRaN9NlvSpQDoqRJ6LFga/bBRA3tPyRyQoJNlivLe2zwhqlD0QM2MN5exqGoJRoIO3j8lFUsiloycz4oZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299818; c=relaxed/simple;
	bh=39NtxAeqpXvhawaLycQSgS8a7QXmm9U/xmb9EyW+PGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NGJWzgoKxtcOqrRuqI0Q9b/G4jvs1aCO69hT0Dpu7BrcYGEN8L19K/16OY4fP3qob2ijjuViXpatsUjfdiq7tKmQMzJW3Av26nRuoPnMSiTgVqo8UagM8qUf0ur9KUlb2Fv1XuSJNxB3n6OdOi3CDaEb8K3MB6KP+cr3lYWRhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy6ZaChy; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy6ZaChy"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59b72a1e2f0so7220294e87.0
        for <linux-sh@vger.kernel.org>; Tue, 13 Jan 2026 02:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768299816; x=1768904616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=Oy6ZaChycwigMF75t2qZj+/xORE9aazMoLW8drWQqjcqKB81tPoq/ia9n8B/Bgvqn3
         LHpUxVbjZfdmzjLNzCz2VFmr0xP9zPzpiXcIPB5iWuM+Sop79Wi4gdFpW1KhYTVZX8zX
         yZx8jFqBpACoeTd2eMfpmfexUTtMgbQIXPYDxFP+yDScpCyuUG8WZjQ/G4G3WnR3wDIP
         azMXS5hHhxQ1yTZC+c9CaGHf/Dx18KiExXL8MCm8Vf2BwtwDWpOm6hL7ejxLgolrykIR
         TiBDLUkmAm+MEOmh34GlYJT6Wl0RGDtwSOH/KowSFFq+uticGfZtNqeVRc9HnZBRhLj4
         CoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768299816; x=1768904616;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=BGPMlz769ccCmg//hYKA3lhUg6HKICxXh0dXdGONk4QJ1QCHiRFGX+Xk9UdLM8eZct
         F4c4P+qTS71DyapMMvAIS2G18/NVM6F493YVeRz/Cc1pIZQboBgA4CpeIpahzeEKd7QY
         Wh41VPWvljrhcVgQtJbcjFyBUDenyp2A8ykn3fB3TdoDY8jrqCwGJlVxxJp/I2NV74vg
         CT4nlsf3tJS85AjqPSjLM5aoLurCwm45LBeXVAC6AKwKO/5A6DlBaW+FEC1pjs+qGoem
         yoHa7+puwgrM1ehpOq7vsYvxFLyPJ21nH6lB1dzzU+iCPk4ydpV6VS6eLqNgntxTx2v0
         YtdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAdSRpH6ROl5kO4eBNdU8FWYNLoJ6qXt8cgXKweizmBzius0e3MxRmrjfzwRs7MGvAmqM9ptwmYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyS5a6kzgtVDKJNGlb0bMTj4zeug7Z4iaWrdzdtzaLOuzZ3WrKV
	xWYkkY8GH9n6ibp/0G2H1ONdrp0VHAeaKS36UIHvt2p7776v9iRThvYf
X-Gm-Gg: AY/fxX7REixd+zp0e6BGr6f4zU3fNOjDjONpMkiSvrqV9XOQdhzJ8G6UOaftcX38Tfz
	F6xRYT2RRjYADJX1G6ayah2j6Ehl7RkgcRQTcmhrZU/YjVc6oeSxepCFOEdhbCFg/hNH+HorLqE
	a/g1TP3+Wxvpn1dojU0/pL8NReNfVCQTfg6kxj1D3K9QNb1e5Xtst8UjVW4n7cvrZVw0mhBtFSg
	DDWD+rISVqBCLh5UqZL7RmfM3LI+/1x1EFaHY8EtUiRT+yXTem3IMkTHLeycqBnHN/seKrEIS8i
	+MHToLJrgnML78jdJZJS8sdqmWhbQv8qt5Alwn2q9E83JkoaFWF3qOf+7vaMKsNVBRd4655H7wx
	Y9o8P2/LVkWDLAubVI7fgJRjEkzSn+Q1BK6XvT2J4N+V1VremN3VGAtS+C/0KFu7lLoGNjbG0f1
	hn42sSXVaWOfhty1w+hpMcLCtLrOcqx9nuiXrDoj9YqAK0ldFEFoq5EjdFkg==
X-Google-Smtp-Source: AGHT+IEOoK2sWcGzQ5k4NJjsFR/RmdeWAB9vvZrFfNJ0u+S6dsEFK74/fdYnqiqEV2XmHMt6sJ390w==
X-Received: by 2002:a05:6512:138b:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59b6ef05760mr8236951e87.11.1768293628066;
        Tue, 13 Jan 2026 00:40:28 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72f3ae82sm4416299e87.71.2026.01.13.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:27 -0800 (PST)
Message-ID: <f861a1c6-7ec7-477c-bc42-f9aaf6724bed@gmail.com>
Date: Tue, 13 Jan 2026 10:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
From: Kalle Niemi <kaleposti@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
 <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Language: en-US
In-Reply-To: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/26 08:50, Kalle Niemi wrote:
> On 1/13/26 00:23, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>>
>>> v3 changes:
>>> * fix empty_zero_page initialization on arm
>>> * fix ZONE_DMA limit calculation on powerpc
>>> * add Acks
>>
>> updated, thanks.  I'll suppress the ensuing email flood.
>>
>> Kalle, can you please retest sometime, see if the BeagleBone Black boot
>> failure was fixed?
>>
>> Seems we haven't heard back from rmk regarding
>> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.
> 
> Hello!
> 
> I will test this v3 patch ASAP and reply results here.
> Collective sorry for the delay; I have been busy!
> 
> BR
> Kalle

Hello!

I tried this patch by cloning 
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=hugetlb-init/v3

Boots succesfully on BeagleBone Black!

BR
Kalle
