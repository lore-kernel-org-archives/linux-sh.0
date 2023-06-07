Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD02C7EE25
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 23:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjFGXIk (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjFGXIj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 19:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB511FE3
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 16:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686179271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NeyeiJwB2YnwAcLQJHG8HFbbrzLzOPay5XEB/Mwx9Ig=;
        b=bvPc1YjBh7ObJZHRL5qH0Lim/q1lq+2Noo5bKR/42ZnOPwk90ieRUQx3J3dZCTh2hBwZs/
        NmzZo3dmALiwOBnD7AngKoh+ldISAfQJHViM+9HJfF1CEwTPqL+lAxe6bjy8vqw0VivLR4
        Lkp0j7ZdhfMf+dvAgPgbKe5HDH7CM0M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-2a-sP2ceP8SlgTSirz-ocA-1; Wed, 07 Jun 2023 19:07:49 -0400
X-MC-Unique: 2a-sP2ceP8SlgTSirz-ocA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so39202475e9.3
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 16:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686179268; x=1688771268;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzPJdjd02VNeNLl14O4tReNjsYBGUu/pZADGgCv1i2o=;
        b=ZoRCCPKi4o0p8XEpDjECocGEOJ+vHqlAlYBmxvtFANAhF4z5XVcsWEnaDTgnCQNDnu
         xp0Bgjd2QeYidpNP83Q+W6BsicbwsTQ0SX3R60wkz9jaIcv5xFpsnNgGk+T7YZ1cH+3p
         Jo47pqqvxepuV7mWRspodJqzc4bM+Wb8oWHJfCfLTfzqG/L5vZFEpfvFSL65kxMIb66y
         brUYH/T7l9uCAOjrS1HL6FhpRAXGFR8cqBMQIQJMzLEKZ0Y3Be+YsV3feigGTTnGJIM2
         XPp4kmPhRtuZ1AWAsCYYvsMe/FKCqsUhOaDt4xMZiKMY/4QSt8YLn8gm2QjSC/OaBNOH
         isYA==
X-Gm-Message-State: AC+VfDx9qB38Q+YpkAVdPf46UVSMU/NdASA8h+S7iORWIbL3Pr/npp7x
        9VK4A+HJKWPxtcazvicq28sy8kENVgXhQDEbnSEhIWPa4/dwoH7mbPPqpwLSoj/WWMJfqhUvV/9
        ii1V49Md0hIZmod7MY4kVEbeddYg=
X-Received: by 2002:a05:600c:287:b0:3f6:f7c:b3fa with SMTP id 7-20020a05600c028700b003f60f7cb3famr5617449wmk.31.1686179268612;
        Wed, 07 Jun 2023 16:07:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7yuzlNYlFd9At+efr6s7V++AJjpo4wp6t37d3PBdQ42FjEQ40JOh3bqJjvNUUJHF19hKrWRw==
X-Received: by 2002:a05:600c:287:b0:3f6:f7c:b3fa with SMTP id 7-20020a05600c028700b003f60f7cb3famr5617443wmk.31.1686179268312;
        Wed, 07 Jun 2023 16:07:48 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l8-20020a7bc448000000b003f42328b5d9sm96487wmi.39.2023.06.07.16.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:07:47 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel.thompson@linaro.org, linux-staging@lists.linux.dev,
        linux-sh@vger.kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        lee@kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        sam@ravnborg.org
Subject: Re: [PATCH 30/30] fbdev: Make support for userspace interfaces
 configurable
In-Reply-To: <CAMuHMdWBUKTgfCD9VLDFh_Tm1J-NJQHpxODs-TuYM7V-dtmGjA@mail.gmail.com>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-31-tzimmermann@suse.de>
 <CAMuHMdVP2hrgXaZvASnHJ4M+VXaTCtfbeVXrq2dsEJqcs3G6ZA@mail.gmail.com>
 <e5d88ca8-66fe-b5ee-cb6b-2dc8f3a3fb26@suse.de>
 <CAMuHMdWBUKTgfCD9VLDFh_Tm1J-NJQHpxODs-TuYM7V-dtmGjA@mail.gmail.com>
Date:   Thu, 08 Jun 2023 01:07:47 +0200
Message-ID: <873532eurg.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

Hello Geert and Thomas,

> Hi Thomas,
>
> On Wed, Jun 7, 2023 at 5:15=E2=80=AFPM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>> Am 07.06.23 um 10:48 schrieb Geert Uytterhoeven:
>> > On Mon, Jun 5, 2023 at 4:48=E2=80=AFPM Thomas Zimmermann <tzimmermann@=
suse.de> wrote:
>> >> --- a/drivers/video/fbdev/Kconfig
>> >> +++ b/drivers/video/fbdev/Kconfig
>> >> @@ -57,6 +57,15 @@ config FIRMWARE_EDID
>> >>            combination with certain motherboards and monitors are kno=
wn to
>> >>            suffer from this problem.
>> >>
>> >> +config FB_DEVICE
>> >> +        bool "Provide legacy /dev/fb* device"
>> >
>> > Perhaps "default y if !DRM", although that does not help for a
>> > mixed drm/fbdev kernel build?
>>
>> We could simply set it to "default y".  But OTOH is it worth making it a
>> default? Distributions will set it to the value they need/want. The very
>> few people that build their own kernels to get certain fbdev drivers
>> will certainly be able to enable the option by hand as well.
>
> Defaulting to "n" (the default) means causing regressions when these
> few people use an existing defconfig.
>

Having "dfault y if !DRM" makes sense to me. I guess is a corner case but
at least it won't silently be disabled for users that only want fbdev as
Geert mentioned.

I wouldn't call it a regression though, because AFAIK the Kconfig options
are not a stable API ?

>> > Or reserve "FB" for real fbdev drivers, and introduce a new FB_CORE,
>> > to be selected by both FB and DRM_FBDEV_EMULATION?
>> > Then FB_DEVICE can depend on FB_CORE, and default to y if FB.

Funny that you mention because it's exactly what I attempted in the past:

https://lore.kernel.org/all/20210827100531.1578604-1-javierm@redhat.com/T/#=
u

>>
>> That wouldn't work. In Tumbleweed, we still have efifb and vesafb
>> enabled under certain conditions; merely for the kernel console. We'd
>> have to enable CONFIG_FB, which would bring back the device.
>
> "Default y" does not mean that you cannot disable FB_DEVICE, so
> you are not forced to bring back the device?
>

I think we can have both to make the kernel more configurable:

1) Allow to only disable fbdev user-space APIs (/dev/fb?, /proc/fb, etc),
   which is what the series is doing with the new FB_DEVICE config symbol.

2) Allow to disable all "native" fbdev drivers and only keep the DRM fbdev
   emulation layer. That's what my series attempted to do with the FB_CORE
   Kconfig symbol.

I believe that there are use cases for both, for example as Thomas' said
many distros are disabling all the fbdev drivers and their user-space only
requires DRM/KMS, so makes sense to not expose any fbdev uAPI at all.

But may be that other users want the opposite, they have an old user-space
that requires fbdev, but is running on newer hardware that only have a DRM
driver. So they will want DRM fbdev emulation but none fbdev driver at all.

That's why I think that FB_DEVICE and FB_CORE are complementary and we can
support any combination of the two, if you agree there are uses for either.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

