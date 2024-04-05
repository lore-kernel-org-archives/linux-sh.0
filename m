Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31B15F40B
	for <linux-sh@vger.kernel.org>; Fri,  5 Apr 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342908; cv=none; b=SQj2Fk+WJzm989Q9KmaZ0jJNGGtoOvRxDpFeck/Y6tizXYN8tcvkrMTcntGYzH8PAP6tncgnZ5EBgGLkVPfNyhFOwnAvsD4rsNgNiFSIQko3YZTlhztPh/Y8P3xIlkm9xKuW6xOmoPpVDAn0fhvdQ7sSE53lgNXL7lS+E/kGaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342908; c=relaxed/simple;
	bh=iaZx9Sgb52CZUZ6c9JiZA4O+x2GIRKBOJrT3ExjLlSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7jaJAbOHluHDOt0NoNnCXBCJHlR+8Z0nfxTsfHqHz01meOev86Elc+l2GZFJPB9J8fjPhS634H4zZsz2pmzQfKWpwZJJ5jmaI0XQBaFHqmgg1kkmCzfQiHhk7h0LrodKsP3xlQlPc7ypq4jM14NnWnnzFL/PV/sRGcldnSaJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=jTn9MLDl; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="jTn9MLDl"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d096c4d664so75412939f.3
        for <linux-sh@vger.kernel.org>; Fri, 05 Apr 2024 11:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1712342906; x=1712947706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wO4G8rVhFXwjZCoL5w67/7AQJqQBd61zTBoU9QYI8+E=;
        b=jTn9MLDlC8HjXgH8kRrIcd0JJ5K/XKs74t1+YlF/HDE8nlacpSvjqzOtv4ZO2jsXKX
         VfKlXUZx1uQs+gsrKSptqBJXqWVOEIi9F60sJywSxfmJ2rS6J4z75kOYgHDSDPlgLlRZ
         JKNhGAZDhZqvL8q89WF6YAHdGbAt5S1NsdGLLx9ZiIXy3aei4cEazutouT1WotmBZCkm
         2w4fLcdCx1WXfKVxHfXaelzhwrhNW5qScTeKTV+V5RzaFVqHOdlA1W9qkwbwgvLU0gme
         uKDbADW+Ch+Ub+q9+sEFPEPb/SAR8t0OSxUimZ3Z4mSf6IvFrDPn01WFwCwtFfreQbDx
         y0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712342906; x=1712947706;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wO4G8rVhFXwjZCoL5w67/7AQJqQBd61zTBoU9QYI8+E=;
        b=clVLknxd6DwsNl3OvolvrGMuYAN78FRV3qEg0aKc1yn7LfnaqqrN1OXPZik0351bDu
         XbuoGabHU+utxo7d32iyS8aFxE39PTRTIL7bljEXQmDLelENnfoPLmrnZVeHcHC85XBd
         px8hhUVKkhuo4D9BaM49REH2XiPIR+BwukC+tva/Uxy5pH9Jei0rYHRibj8qYEL9o7+r
         Vdxa1+Y7SMj25R/+yhSp94uURQZfhdNcB9TxMISQSzQPb9wd87fbqCWjl+JuC8M7TEZY
         NBM17YBks+xMTkdE6y+5+HCJ5BdXR1lM3Cm435+NWlrYTBEmuqQnUmnsAwYDa2CeiE01
         xeSw==
X-Forwarded-Encrypted: i=1; AJvYcCU3lqEnoGyLyWzVyuc5hLNKhx3RJFgXJnEvSpkXK4TaAnQvUpsZ/puyVEcIOdFaKqF+qw7S93l+Gx0gGpp2dR3/6Od3A+NKoZs=
X-Gm-Message-State: AOJu0Yy3+qQOPu68O2AKsmN2qhm/8l82RnOWPZacMHQy9FVdtk71QcjO
	EJdk32IDPVLFZ4evDKvmdeq+E2Y4yCtX+dU20PKOLzt+66j3TLgsBEPusWa3Xeg+E0Y+OsutJ0z
	r
X-Google-Smtp-Source: AGHT+IHjBoV1epG10ktmaaS2Cf6zCM0XXOtNwf8023cHNvqd67Kpdb3PtW8XoHkw4O7GifZDo8woOA==
X-Received: by 2002:a05:6602:2d8a:b0:7d3:507a:8348 with SMTP id k10-20020a0566022d8a00b007d3507a8348mr2749280iow.1.1712342905680;
        Fri, 05 Apr 2024 11:48:25 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id t1-20020a6b5f01000000b007d347ecf3cbsm680389iob.55.2024.04.05.11.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 11:48:25 -0700 (PDT)
Message-ID: <aebc1db5-5c3e-dafe-0c35-7d0a4ed4d885@landley.net>
Date: Fri, 5 Apr 2024 13:57:32 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
 <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net>
 <CAMuHMdWL0aHmZS7NuZO5AUhn=zmNDG+fPZzmG--DyZr-LFwZ-Q@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdWL0aHmZS7NuZO5AUhn=zmNDG+fPZzmG--DyZr-LFwZ-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/5/24 07:21, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Fri, Apr 5, 2024 at 2:09 PM Rob Landley <rob@landley.net> wrote:
>> On 4/4/24 00:14, Yoshinori Sato wrote:
>> > This is an updated version of something I wrote about 7 years ago.
>> > Minimum support for R2D-plus and LANDISK.
>> > I think R2D-1 will work if you add AX88796 to dts.
>> > And board-specific functions and SCI's SPI functions are not supported.
>> >
>> > You can get it working with qemu found here.
>> > https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk
>>
>> I was hoping to get a device tree kernel to boot with static device tree on the
>> existing linux-sh qemu. (The main new features I want from an updated sh4 qemu
>> are a working battery backed up clock and more physical memory...)
>>
>> Is there somewhere I can get the kernel patch list in git or something? I
>> haven't got tooling set up to conveniently fish 37 patches out of an mbox file,
>> and would like to test this. (I moved last month and my physical sh7751 hardware
>> is in a storage container.)
> 
> b4 am fe69e328ec617f91a09fa2d00506ba1a664085d8.1712207606.git.ysato@users.sourceforge.jp
> git am ./v7_20240404_ysato_sh_passing_fdt_address_to_kernel_startup.mbx

$ b4
bash: b4: command not found
$ aptitude show b4
E: Unable to locate package b4
$ aptitude search b4
p   b43-fwcutter                    - utility for extracting Broadcom 43xx firmw
...


Let's see, google says it's a random python3 tool, probably wants a newer
python3 version than I've got because everything that uses python3 does, it says
"you can run it directly from the git repository"...

$ ./b4.sh
Traceback (most recent call last):
  File "/home/landley/b4/src/b4/command.py", line 10, in <module>
    import b4
  File "/home/landley/b4/src/b4/__init__.py", line 37, in <module>
    from typing import Optional, Tuple, Set, List, BinaryIO, Union, Sequence,
Literal, Iterator, Dict
ImportError: cannot import name 'Literal' from 'typing'
(/usr/lib/python3.7/typing.py)

Oh well. Good luck with your patches, hope it works out.

Rob
