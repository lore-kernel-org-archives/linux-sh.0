Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3249C7EE37
	for <linux-sh@archiver.kernel.org>; Fri,  9 Jun 2023 10:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbjFIKNE (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 9 Jun 2023 06:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241036AbjFIKMe (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 9 Jun 2023 06:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C842A5276
        for <linux-sh@vger.kernel.org>; Fri,  9 Jun 2023 03:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686304784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ro28qLwMycjBPd4B2CfnKUVLQYPM9zhy62Il4fiHOKA=;
        b=H4rp5VYwtWSnkLYlz8b9ul/s1C2/7nh35yCXnswZroRa16qFBSISKJE3Gm5pSK0Gka9nSg
        pgvHtoq0XtB/mIrGFYfJ3+bKU+cf7xa3LV3t80n4yxg+9YOBjexxkyLZSSpDxqb3Dq/6z3
        4DIp6PpH++Y/UT9ft2ng7B+0KvLnso8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-29eUBG2JMz2g88jShqWevg-1; Fri, 09 Jun 2023 05:59:43 -0400
X-MC-Unique: 29eUBG2JMz2g88jShqWevg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30af779d6e6so674862f8f.3
        for <linux-sh@vger.kernel.org>; Fri, 09 Jun 2023 02:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686304782; x=1688896782;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro28qLwMycjBPd4B2CfnKUVLQYPM9zhy62Il4fiHOKA=;
        b=h51bRzniKqso/LMOas9Li5VEUq3DqmJs4A/e8nCM6Cu6v9KL+j7xt0EOjPA8+Jne8y
         yWgNYM+GFHCHA/qcesmx1k1GyvZ+gixCVsBrYMNp6jhC/nyTyS1RhuScxPRb5Wc2dMvd
         HpwEE+j8PomaVb0b+s0bRatp4A2ZssY3Zso02poQbcE4H1/HrDWQBrjf2owJ8Y+mrq4X
         X9GHi/CD5NSJcX0kbvag6Mx59mCO4FWyREEQU7s6WVAeojLur3kyyMkFp1H4IhXSGEBm
         BTtSRu2h8gOv7BdPnCZ3goIxGclNOlQKT0mkUfDio97QsBNCPkojOXxdILB41DIvu4P4
         KGag==
X-Gm-Message-State: AC+VfDxXDJwhNl09Zwi3c1VqpASaVtEG6ANKqkOfrWjDgLhPARQGTfSz
        EXqRrCY1MCX71nedv1kQJFEyRfziCV2u2XQema/sEpdcYJWHDLfJZ1Y+/dNJA6/55Yebyc969N+
        +a3hRz9yn1PUMeU2V4AU=
X-Received: by 2002:a05:6000:1cc1:b0:30d:981d:a049 with SMTP id bf1-20020a0560001cc100b0030d981da049mr475562wrb.4.1686304782623;
        Fri, 09 Jun 2023 02:59:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mbChq3eZ0n/KPDmx58FVgNTALqSeH3ETuPMsy/BuQZAfQWRgbheMcufPP8W0/LTSPFhyPxg==
X-Received: by 2002:a05:6000:1cc1:b0:30d:981d:a049 with SMTP id bf1-20020a0560001cc100b0030d981da049mr475549wrb.4.1686304782266;
        Fri, 09 Jun 2023 02:59:42 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003095bd71159sm4029755wrz.7.2023.06.09.02.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:59:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     daniel.thompson@linaro.org, linux-staging@lists.linux.dev,
        linux-sh@vger.kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        lee@kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        sam@ravnborg.org
Subject: Re: [PATCH 30/30] fbdev: Make support for userspace interfaces
 configurable
In-Reply-To: <4df23439-462f-47da-890d-2dd2092eea35@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-31-tzimmermann@suse.de>
 <CAMuHMdVP2hrgXaZvASnHJ4M+VXaTCtfbeVXrq2dsEJqcs3G6ZA@mail.gmail.com>
 <e5d88ca8-66fe-b5ee-cb6b-2dc8f3a3fb26@suse.de>
 <CAMuHMdWBUKTgfCD9VLDFh_Tm1J-NJQHpxODs-TuYM7V-dtmGjA@mail.gmail.com>
 <873532eurg.fsf@minerva.mail-host-address-is-not-set>
 <77252bc9-e08e-fcee-d140-2b78ab768b42@suse.de>
 <CAMuHMdWUkZDcYfndf1A+cgcN5Fz1hmst4LrpA7iYCFqWSRTNDA@mail.gmail.com>
 <4df23439-462f-47da-890d-2dd2092eea35@suse.de>
Date:   Fri, 09 Jun 2023 11:59:41 +0200
Message-ID: <87h6rh552q.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi
>

[...]
 
>>> I'd also question the argument that there's even fbdev userspace out
>>> there. It was never popular in it's heyday and definitely hasn't
>>> improved since then. Even the 3 people who still ask for fbdev support
>> 
>> There's X.org, DirectFB, SDL, ...
>
> None of these examples has a dependency on fbdev. They can freely switch 
> backends and have moved to DRM. Anything program utilizing these 
> examples has no dependency on fbdev either.
>
> When I say "userspace" in this context, it's the one old program that 
> supports nothing but fbdev. TBH I'm having problems to come up with 
> examples.
>

I personally have two real world examples that can give to you :)

1) I've a IoT device at home that has a bunch of sensors (temperatury,
   humidity, etc) and a SSD1306 display panel to report that. It just
   has small fbdev program to print that info. I could probably port
   to KMS but didn't feel like it. Found a fbdev program that I could
   modify and got the job done.

2) I built a portable retro console for my kids, that uses a ST7735R
   LCD panel. The software I use is https://www.retroarch.com/ which
   uses fbdev by default (I believe that supports a KMS mode but out
   of the box it works with fbdev and that's better tested by them.
   
So even when I'm not interested and don't want to enable any of the
fbdev drivers, I want to use the ssd130x and st7735r DRM drivers and
the DRM fbdev emulation layer.

In other words, there's real use cases for supporting fbdev programs
with DRM drivers. Now, I agree with this patch-set and probably will
disable the user-space fbdev interface in Fedora, but on my embedded
projects I will probably keep it enabled.

That's why I think that we should support the following combinations:

* fbdev drivers + DRM fbdev emulation + fbdev user-space
* only DRM drivers without fbdev emulation nor fbdev user-space (your series)
* only DRM fbdev emulation + fbdev user-space enabled (FB_CORE)

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

