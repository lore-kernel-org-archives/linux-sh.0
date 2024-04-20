Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303C10788
	for <linux-sh@vger.kernel.org>; Sat, 20 Apr 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713650478; cv=none; b=u+BNEoUFClVYiNbyi/n1ihknU2UtRRB8w61yM+H3y7iIKhFM+3YLHvk3vDRsMjsR87b5PXHF/wN+NVoidjjRyx0QTP6CtHZGpS2EYCHKdUKsjAu93aHkM79K9+DX90yZypJoTSKMDyen9YMJQZ71RFK2zr+tQXhHAbOhpWtJ+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713650478; c=relaxed/simple;
	bh=F9S8tdaK5Uu2G2beOU/gLKYa/cG+2n7XtOdEo+24LxA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CSp0pOB4cc3LWUau0JCd4kzmyurR5V8MsJAY52YyyEjeC7xM7QcscqcDyL5AnRnGrkFgH3zapnCvIRyuTaoW/4chX0n+e4WADCMIPaE/3hso5ctuG6JP9WcbfymH5kw7vKpqsACOFX16QJNwuV4pjf9/vl5inMZQS8rbRJoSWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH059Do9; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH059Do9"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47a21267aa8so1151972137.3
        for <linux-sh@vger.kernel.org>; Sat, 20 Apr 2024 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713650476; x=1714255276; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F9S8tdaK5Uu2G2beOU/gLKYa/cG+2n7XtOdEo+24LxA=;
        b=lH059Do9wL5/sCfsra+JYiQQ7r05osPYSUL8UE7d871zC1gGdbwEx5DZqdIL3TShcJ
         eZfhVGX79hqzQBps8YXksOMwBoFRAYrFL1Ae9CkRRqDmbMxElKNt3ZbeABemApSUGBL1
         rbwpEszrFCcnS3IFPPd8cGrFJTIGtpTd3VGVmRkZE9CGK7Yk4KS6desXOR19znymCnYU
         U/bUlQmBNxpQHWz2vhy6XdSd9rse1BCz2TuUICqEsfecQPAX6ieDtYitJkv9s1Mk11Hq
         JuTv+1bohfoUoAVjkoPZwFT+tki+TdBWjX1jYShF6JOoNJnHMn9Wi2J4TR1EVrxR9tP4
         vToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713650476; x=1714255276;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9S8tdaK5Uu2G2beOU/gLKYa/cG+2n7XtOdEo+24LxA=;
        b=vytDQffJIjXl92JM6iFBecT6NznloU3h01AdlhBS6SuaqLDiAiEIWSlm7EHDJfY3Gr
         6vUe9r8Zs3a2epmWrAnkXUqYZz3OVbqvheNYKswhOvxNk47Cyu/wqnw+Tyv2WLBGg7yw
         jLYAEUhA/13D7M+jonJiLyJlx5/Q3w1n59pYlrv+8IeZMLrfZ7Twqp4jCZCP9i1R3gHd
         xIglTzOSLRoxrfqoSrt8gOpL1Fp6IZlZRrTtS7sLGTFcXH7gqTcb+MfpOMmPd5x2uzVT
         LT2sYDWRCNuLKbL9smHJZYIJzcySun6UE82ZqRKOqjUqIuBJBLq4ooIjUZR7eFNGaXS1
         VTPQ==
X-Gm-Message-State: AOJu0Yzjs/zz+3z+fAJoAWB9EO6ivIRK3jAlrZgWNpeZTymCEZH83sly
	TCqy2G4S1H2SbWZ4ezdn3H9LfG/eNsiVT6dehYzha4VqJHnlFx9PyrdRwJ+VYHuLi/9QKyp/50j
	crU+QTafkDYRv8E7FudxvZzwKaVMBqZoWfSM=
X-Google-Smtp-Source: AGHT+IE+loiA3zYwZz4AwCZmOCsg8qgfEjESrKAUxG1VTbepYiuGYVICZhyS5Is776F9WOwsXRUVh8dmMZSg16h/iI4=
X-Received: by 2002:a67:f70e:0:b0:47b:c50e:54f1 with SMTP id
 m14-20020a67f70e000000b0047bc50e54f1mr6733434vso.4.1713650474570; Sat, 20 Apr
 2024 15:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: The Mariocrafter <kayvonkamyar@gmail.com>
Date: Sat, 20 Apr 2024 15:01:03 -0700
Message-ID: <CAEgzAWy-vA=t5tBzaqe4h-esNwtC2pML5NE_uPWnAxvrUmFxxg@mail.gmail.com>
Subject: Unmerged DreamCast Drivers
To: linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, the LinuxDC project got abandoned long ago (and got merged with
the main kernel), with a few drivers that were never merged.

The VMUFAT filesystem, to get the DreamCast VMU filesystem working:
https://www.uwsg.indiana.edu/hypermail/linux/kernel/0904.1/02520.html
, a reply with a critique shows at
https://www.uwsg.indiana.edu/hypermail/linux/kernel/0904.1/02545.html
saying that making it not a dependency for the VMU would be
problematic for promoting it's use as a general purpose filesystem,
but being useful for emulator developers. VMUFAT support would be nice
for having Linux on the Dreamcast be able to manage saves, especially
if a homescreen replacement is developed. I think it's better to keep
it Dreamcast-dependant for now, due to security concerns, and due to
having little use outside the Dreamcast, as emulator users can use a
userspace FUSE driver.

Other than that, two full drivers for the VMU's display and the SEGA
LAN Adapter (HIT-0300) have been created, but were not merged nor
pulled, located on the open directory site
https://linuxdc.sourceforge.net/berger/ .

I don't expect the LinuxDC project to return officially, maybe an
unofficial revival, but it's better to get these drivers reviewed and
submitted, and not have it unmerged indefinitely.
