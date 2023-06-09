Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82274C7EE37
	for <linux-sh@archiver.kernel.org>; Fri,  9 Jun 2023 10:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbjFIKdU (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 9 Jun 2023 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240617AbjFIKcx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 9 Jun 2023 06:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C34696
        for <linux-sh@vger.kernel.org>; Fri,  9 Jun 2023 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686306282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMg53JOrE7LdjfO2Cif2xn5d4s7Q5BrveDabIgOUiSQ=;
        b=g45jyEziDqHBjKVoc0t6jKsmP59aBkwbS+ClR1FZXwJtHNMNegjCo/jUw2rQNcRKEh4/NH
        S08waG0NIjXAuSYLvP6gPbmDAsAY5qNX1iWhKVsukomCOCA+s3iHp3w/z9fuLimCAWJMif
        f1DLxIFct2hG9VJU0D0dMdhfjgz6On0=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-au9nrFQOPZ2ZfkmqFhYpUQ-1; Fri, 09 Jun 2023 06:24:39 -0400
X-MC-Unique: au9nrFQOPZ2ZfkmqFhYpUQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b168e97cdfso12886881fa.2
        for <linux-sh@vger.kernel.org>; Fri, 09 Jun 2023 03:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686306278; x=1688898278;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMg53JOrE7LdjfO2Cif2xn5d4s7Q5BrveDabIgOUiSQ=;
        b=bBjtHV0lwQHesfm8wHZj1Uhor0ixoMsHwjxz7ucNW4kn+kOro0Jty4GRCrow94vTaq
         VNXkf9zYO00ybB4XZnkP0296tiJDL+K1M2B3Q9uoXe6XRwpNlpoQH7SduNNNlD6oP1CM
         QPorr46iOvMm6juacz1XijwCrZFE/MVqngRt42XN0rwdebE+c+MIeZUc2uY2xGUZ7++C
         HQ8daRkARqgOzsj3jRaORt6y9vnDV/lwHuKJTb40b+FKlCwmEprspYhk65dvyZjiE+qR
         AmD5DmjqHNmtLGYknrLmCDxUsaSp49+rztUxXntQY9FvoeiqfP2WY+gspmW8ML8eQh2b
         QPSA==
X-Gm-Message-State: AC+VfDy1tk3irhi3b5rcTx8B+9WBHtjF4xWEAx+HYDne1te4p5+H2ZQx
        RW4eFze3UqyjZgFP17P9z8YVW1qmDM1TqjtN3ySAPex1kHeRqPMRoJVukkvD59RIHSMWemnCZlV
        3uXPENWEqB5YkpJKin4c=
X-Received: by 2002:a19:914f:0:b0:4f3:a483:557 with SMTP id y15-20020a19914f000000b004f3a4830557mr619117lfj.5.1686306277833;
        Fri, 09 Jun 2023 03:24:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6S3RszxExiKf60rjrxsF2OLyJFkoRpusOuEfLcjyVkibfQrgNaGV/G0ODH5bqwWreayNq8WQ==
X-Received: by 2002:a19:914f:0:b0:4f3:a483:557 with SMTP id y15-20020a19914f000000b004f3a4830557mr619101lfj.5.1686306277475;
        Fri, 09 Jun 2023 03:24:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y14-20020adfdf0e000000b003063772a55bsm4046255wrl.61.2023.06.09.03.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 03:24:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        daniel.thompson@linaro.org, linux-staging@lists.linux.dev,
        linux-sh@vger.kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        lee@kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        sam@ravnborg.org
Subject: Re: [PATCH 30/30] fbdev: Make support for userspace interfaces
 configurable
In-Reply-To: <CAMuHMdU27OK1=B6Qgwd+tyda=MmN0EiC8taUpvAJJOYUFcm88A@mail.gmail.com>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-31-tzimmermann@suse.de>
 <CAMuHMdVP2hrgXaZvASnHJ4M+VXaTCtfbeVXrq2dsEJqcs3G6ZA@mail.gmail.com>
 <e5d88ca8-66fe-b5ee-cb6b-2dc8f3a3fb26@suse.de>
 <CAMuHMdWBUKTgfCD9VLDFh_Tm1J-NJQHpxODs-TuYM7V-dtmGjA@mail.gmail.com>
 <873532eurg.fsf@minerva.mail-host-address-is-not-set>
 <77252bc9-e08e-fcee-d140-2b78ab768b42@suse.de>
 <CAMuHMdWUkZDcYfndf1A+cgcN5Fz1hmst4LrpA7iYCFqWSRTNDA@mail.gmail.com>
 <4df23439-462f-47da-890d-2dd2092eea35@suse.de>
 <87h6rh552q.fsf@minerva.mail-host-address-is-not-set>
 <CAMuHMdU27OK1=B6Qgwd+tyda=MmN0EiC8taUpvAJJOYUFcm88A@mail.gmail.com>
Date:   Fri, 09 Jun 2023 12:24:36 +0200
Message-ID: <87edml53x7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:


>> * fbdev drivers + DRM fbdev emulation + fbdev user-space
>
> "fbdev drivers + fbdev user-space", I assume?
>

Right, I meant to also include "only fbdev drivers + fbdev user-space"
but forgot :)

>> * only DRM drivers without fbdev emulation nor fbdev user-space (your series)
>
> Thomas' series includes fbdev emulation here, for the text console.
>

Yes, I meant fbdev emulation for user-space. Probably should had included
fbcon in the options too...

But what I tried to say is that we need all combination of DRM drivers,
fbdev drivers, DRM emulation for fbcon and emulation for fbdev user-space.

And I think that Thomas' series + a FB_CORE as you suggested and done in
my old series should be enough to have that.

--
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

