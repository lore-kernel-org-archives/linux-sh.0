Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32E9C433EF
	for <linux-sh@archiver.kernel.org>; Tue, 11 Jan 2022 11:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238265AbiAKLYD (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 11 Jan 2022 06:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238392AbiAKLX5 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 11 Jan 2022 06:23:57 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558C5C06173F
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 03:23:56 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id y13-20020a4a624d000000b002daae38b0b5so4338687oog.9
        for <linux-sh@vger.kernel.org>; Tue, 11 Jan 2022 03:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TL+aaQnHJ+YQDGa4PA70hqqn94yrQ4T94+aueUELYWM=;
        b=ZemixStDd4Z46Dgb04Ynl6+SshuesEoduBjnoO+T8ogYipMBq/lmL4IwOmLQ1hZYry
         QgAF+iIWHhnQvGLLbBWjsWeTzXquRxO+w49pva9puFlPKTEBn6otXSoArc3oCLPNdGfR
         wmgm4R4Uq7lBL7jshFQ3PERXS0K7ggBpkRP8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=TL+aaQnHJ+YQDGa4PA70hqqn94yrQ4T94+aueUELYWM=;
        b=Hs/aprcyjwrJHRgmLldEKIlh8TneLKg+7X/JUl+h8WJ8r+jU6n7MBxZf+mdgcsUChn
         rqMXHtVYwjs4ov4LQfV+JQPzQ9TKyTG+M5LPuHu04MKhdk61TfDc+Nx0u7nm/YE2C9Fo
         Vez2KcbYPASdb23esKvqPtL16L0NG7bNz27fb3cCBiOI1q6WXVNtZZW++FDRoLca0wUV
         2doKGQxqQj8fAcPvWg71ExeX2I+UCtTqAirrG1Tu8CkTLDA1vDkd/gWDZAwaqVxPTHyw
         yir5y4KU8R0UWGUo2lc7nBAOtTRaFSWP0TdyHNnYr+jsbzo0xljWd8P6r90XUJE8PS1j
         0CHA==
X-Gm-Message-State: AOAM531qk2GzKNIHkLY0cc728L+fXvEV9XcV4/sPDCmsjUwE4B95R9cy
        49pBCWtXKyUKlrvnCjUqhzZ1WuTIlNpwXsOiPGGDxGNkAGp7Ng==
X-Google-Smtp-Source: ABdhPJzw1Ykux+Liq0zg/PQ2UL1dAZyC589UGSIBhvc87txMePOWlG32fDr5uykTyPnITQvHEN4Sd8eoTgqow3MHH/g=
X-Received: by 2002:a05:6820:319:: with SMTP id l25mr602425ooe.97.1641900235289;
 Tue, 11 Jan 2022 03:23:55 -0800 (PST)
MIME-Version: 1.0
References: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
In-Reply-To: <CAP145pjk471P9pUzhf-rpZiQvjd499i-VpL8iRECDWkSKM_cyA@mail.gmail.com>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Tue, 11 Jan 2022 12:23:44 +0100
Message-ID: <CAP145pjjyXs40Disg3QhFkkEp8CFXeBCHjn_8Hu=s1cxEjCUQg@mail.gmail.com>
Subject: Fwd: Debian on Linux-SH4
To:     linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

+fwd linux-sh@vger.kernel.org

---------- Forwarded message ---------
Od: Robert =C5=9Awi=C4=99cki <robert@swiecki.net>
Date: wt., 11 sty 2022 o 12:18
Subject: Debian on Linux-SH4
To: <debian-superh@lists.debian.org>

Hi,

Recently I tried to create a working modern disk image for Linux-SH4.
There were many problems, but I finally managed to pull it off.

If anyone needs a working Debian (unstable/experimental) + kernel
5.15.0 - here're the images/kernels/scripts

https://drive.google.com/drive/u/1/folders/1QE59v4goTG-IxMkuev5AB1b-PVhUZq_=
B

Usernames/Passwords:
root / ds
ds / ds
