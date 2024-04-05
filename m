Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981D16C843
	for <linux-sh@vger.kernel.org>; Fri,  5 Apr 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318935; cv=none; b=Py3noUTxbPxo/JucuFog5Q6IPxpOyyEoVO2+Bh++ZYWP3WpHvk03Kgas7BoV+CyQRdRpjEBdvyRwcpE4UFh6geOKxQZIbznfcobnwImii4CzyZOGzIl6KD8GDKncpGXswJ01KFGUX+MusP5du6wyrVIprieiZ4KbzW1Gp8iCMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318935; c=relaxed/simple;
	bh=S07ELtyuvkDHUgR21/U/D0adJQPl1+VdAEjHFQ2eqjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Coe4nH/HspN+6qZei/Kwr8LJYTHyFyhRORZ780HHtzhyVM5A9O03JYt0iJ/aiFFZoLaU6t8YKN/Kgl0Mw9ftQ93SAzjMHcVeOxGNQbJbo1aOFQtCU8wtNGYMU8c0KE8Bb8sr/crbcf0Is8tdCthxxooYQeIzxCzAwlYBE3No+7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=CshkeI9z; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="CshkeI9z"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-6e6a1d24770so1154575a34.0
        for <linux-sh@vger.kernel.org>; Fri, 05 Apr 2024 05:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1712318932; x=1712923732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8l+8azi+y0dJo6/HycuJF4GP6gyYGz9hh3vkgIavaM=;
        b=CshkeI9z8VAbBvZojDcq+dy4SnBRyZuwMxH4Nm9W/7ZvRYSXICnZSp2kaPvdftp7xi
         Oi0qIzcjwwhAARSbhIx/v+VYUNIy5A4lm0o4DM+uTm/2zNUc+znjnWhYIEXxaM4dwdNo
         Lsac0ZIaLPrFPJGM1NCwZjoUI/9lq12qHYQLkTo+KMbiaFfywaZ/AH9sMLsVL/jrx/Ra
         AvFhAoEmDlV4rLHED53Om9xHdB4D7fZ0hKp8ldvYaQrlf9fImE6ZYsp+BKH9HxSjMmf3
         Cjfa0UnoI0kOqQdrQ9wH/NiLHV1BtPwyI9aojXIISA2JjeRLZEt1twnQZ7GX2l671WtZ
         b5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318932; x=1712923732;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8l+8azi+y0dJo6/HycuJF4GP6gyYGz9hh3vkgIavaM=;
        b=Jyi8xUtjEilYZgms7ZCISabp48tY7Oot9RsxJx28dXm0SOWG+tZnEAZQcPzBHjEpuX
         MBwE1E4Upng09LbA9kE/Fyp69BELWNiSXCk8X+3ixXIfqWqOke8iwfoUw1Cg89/p66kR
         c9UaE4791KF80kFlFrzu1mqiPnhFGmkkZFu4XJvnoN+efXM2e8A/Ial5Mh5UhKDLd+k2
         zMmzR9k8GzRRKaWn315oELR6JtD9fFIBBn2KEmH/+xtZzuICXmunlJ/j+Rm/53+tl8uP
         SmmpBGXs77S1pnfR5Rq5VmPAuADKeHiIabOF+LjdJVkKGdym4W1N4c7WmJrMQACPloZ2
         L36w==
X-Forwarded-Encrypted: i=1; AJvYcCWgqKeIo+X34oLPuBHo6wMuLI3kDRaS08qGWLpU6lqYSZb3yVwLgGPPNIHDvysJFWIE2h3QJbOzsCEGPoJjd8xgucl9fpfJzFM=
X-Gm-Message-State: AOJu0YzJxr0GegpxclO0zaRP5KPqi7ssBx3T4/xNu3Wggmv8UN8Ku2Su
	/DuskfH2o3ZA7ashaSfHMHJK6xH6++SocxP87rOPM6e7mDl5JjOujvUAtsX22PldVRITtlPFwPG
	hcR9qcujc87U=
X-Google-Smtp-Source: AGHT+IF4HzoBl0MxTdcFGUvYE3H4tBHCxi3AzAK8GAIG0mFDCdWahSx/p7P88clGdSdsODQetXE87Q==
X-Received: by 2002:a05:6830:f8d:b0:6e9:fd12:a8cc with SMTP id ez13-20020a0568300f8d00b006e9fd12a8ccmr586104otb.37.1712318932500;
        Fri, 05 Apr 2024 05:08:52 -0700 (PDT)
Received: from ?IPV6:2607:fb90:9aae:8eed:c47d:79ff:fe2a:c1a? ([2607:fb90:9aae:8eed:c47d:79ff:fe2a:c1a])
        by smtp.gmail.com with ESMTPSA id bt50-20020a05683039f200b006e6ff75a1c3sm263330otb.27.2024.04.05.05.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 05:08:52 -0700 (PDT)
Message-ID: <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net>
Date: Fri, 5 Apr 2024 07:17:59 -0500
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
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
From: Rob Landley <rob@landley.net>
In-Reply-To: <cover.1712205900.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 00:14, Yoshinori Sato wrote:
> Sorry. previus mail is thread broken.
> 
> This is an updated version of something I wrote about 7 years ago.
> Minimum support for R2D-plus and LANDISK.
> I think R2D-1 will work if you add AX88796 to dts.
> And board-specific functions and SCI's SPI functions are not supported.
> 
> You can get it working with qemu found here.
> https://gitlab.com/yoshinori.sato/qemu/-/tree/landisk

I was hoping to get a device tree kernel to boot with static device tree on the
existing linux-sh qemu. (The main new features I want from an updated sh4 qemu
are a working battery backed up clock and more physical memory...)

Is there somewhere I can get the kernel patch list in git or something? I
haven't got tooling set up to conveniently fish 37 patches out of an mbox file,
and would like to test this. (I moved last month and my physical sh7751 hardware
is in a storage container.)

Thanks,

Rob
