Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BD63D;
	Mon, 26 Aug 2024 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652229; cv=none; b=q4f6PYcHI0P8VUrRZbPSnf7mA+csOTm2owqRrqltBDctGRyPGXzb0/5WZE4pz4AIyFYsxBNusQeYkbD7bOj1al54s1r3yeRp2HRfxWH4lRc+zZR9UNBJDx2Y7ko9L6ap2GiVd8WC25A/Bo4nCZ59RUJ8M2RA7k5wej0gohwjMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652229; c=relaxed/simple;
	bh=OEc1AA/Hm7QtzuLM/vWQtj2xwRyRGlukW51DLdslNa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDggQugDV0KDrAKpSVX88Rv4JFbnphzTyIISNFAsoDaebFIGThj+Bf9Bcy21TEcG2xxfUw2WqDcPsSIXfsXiLbFCQ77dpWlFkIGtkqoa6bBHQT4Ji38DWJ0Qna1fd3d2EH4PsDzeVf9sggmWN0p85kt+pwH9lR1wm/vruLKCLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vasilevsky.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d984ed52so244393585a.0;
        Sun, 25 Aug 2024 23:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724652227; x=1725257027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKXjBrfmroCoc+jNcJVKdc7dB1QcJh0d700AGCluMS4=;
        b=DC5fiqLcq7N2BM0xC9ijm26UMS/u7oC+8wTQB4V7cc+j27v1VME6keH/cQE9Ynh+9g
         P1xt1X/nByBJc2mTOykFasszybLPg1/iok0AavBB1NIUOL0ILFkcGiEWepHVKSSoiz0/
         jqAiblD6QR7pj+0xYRqv5nGh0w5QgDF2ccidgVvF016VnyPQDRtbjVYZw6Nmt2n2stMx
         GCM//KEXDeZEo9Cj1NnA/Q/g1F890zydFOXLvZ70zepou4PCnn/XYvT3xuZfdbgmzSZx
         gSsRad5vknmVPA6hlYKA3RnVv8uyenMGk5GZGcUsrAi8/WdYQ9xkhDUJaJ6XhkU1fJcy
         7mRg==
X-Forwarded-Encrypted: i=1; AJvYcCUeNU20ZoeNSnCNP4KCqaJVBqFi80hDxcofabwnhz1qeMiSiqZvHuxn26X7kUE1h+DeqifV+XVmaAc=@vger.kernel.org, AJvYcCVL1QYAJxu/KTq/ELpzRfs3Fk6V2+lDIGUpu8TnAKIF5Zo7KP3gXDw5Ri7MpFuS+jx/em382HhrZuuDK54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuqq8TiVSv1nK1JsgkXZAnov30KpE111LHKdhaqQnATv6Bu+BK
	5ihZdmbZxZJrLwAxidZufrozpAxviISsUtiNRM1bCqE4rO24PHbN
X-Google-Smtp-Source: AGHT+IGSGyPTkUxMgB/i4Zy4QLzMECErNv2aanCJjyDmWf6JxbREWcMAfmUgTeNndDbjPNgn8lnisA==
X-Received: by 2002:a05:6214:3d98:b0:6b0:7f36:8ae3 with SMTP id 6a1803df08f44-6c16dc93d89mr90352156d6.32.1724652226893;
        Sun, 25 Aug 2024 23:03:46 -0700 (PDT)
Received: from [192.168.2.219] (bras-base-mtrlpq3141w-grc-05-65-93-184-127.dsl.bell.ca. [65.93.184.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0991sm43641976d6.91.2024.08.25.23.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 23:03:46 -0700 (PDT)
Message-ID: <94540d05-12ab-49b8-9e37-04a29f5cdf77@vasilevsky.ca>
Date: Mon, 26 Aug 2024 02:03:44 -0400
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
 <87frqsghws.fsf@mail.lhotse>
 <c1fd73a3941c54e58420d7555524cd6baeebfb96.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <c1fd73a3941c54e58420d7555524cd6baeebfb96.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-08-26 01:38, John Paul Adrian Glaubitz wrote:
> On Mon, 2024-08-26 at 12:02 +1000, Michael Ellerman wrote:
>> So IMHO having it enabled by default in upstream does make sense,
>> because it more closely matches what distros/users actually run.
> 
> Well, at least Debian did not enable it by default as otherwise we wouldn't
> have noticed this change downstream.

Debian does enable it explicitly on some supported architectures, but not all: https://salsa.debian.org/search?group_id=2107&nav_source=navbar&project_id=18670&repository_ref=master&scope=blobs&search=path%3Aconfig+CRASH_DUMP&search_code=true

By my count, 6.9's new default affected mips, powerpc (32-bit), riscv, and sh in Debian.

-Dave
