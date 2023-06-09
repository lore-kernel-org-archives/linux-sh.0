Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09E9C7EE2E
	for <linux-sh@archiver.kernel.org>; Fri,  9 Jun 2023 11:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFIL2N (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 9 Jun 2023 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjFIL2C (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 9 Jun 2023 07:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0FA273A
        for <linux-sh@vger.kernel.org>; Fri,  9 Jun 2023 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686310036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aq1HmhmHxt8U2DdHW6bpTJ6Q+ZwtPsKU6Rb33d5Ew+Q=;
        b=HfPmQ0IxWoQ+FO0o7dc+sPIuvCEJdbuX1wa86c19123SuD+6AheaeyW4uagJsXJr7P/jUw
        jpCmDPcmmT3dAnhZMY3ZZDpn0v7upWqZPGIE86b0by0OWQDFbLctNYDa3O7xoiVO4QmGgl
        tsyHqu+QovCWc9dumVysia97vDFAdUs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-e_2AxxBiOaeMVOXgBZmJBA-1; Fri, 09 Jun 2023 07:27:12 -0400
X-MC-Unique: e_2AxxBiOaeMVOXgBZmJBA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7e6582938so27769465e9.0
        for <linux-sh@vger.kernel.org>; Fri, 09 Jun 2023 04:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310031; x=1688902031;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq1HmhmHxt8U2DdHW6bpTJ6Q+ZwtPsKU6Rb33d5Ew+Q=;
        b=YBFCDLawbBgrASn2cBNkR8ECeL0toD7MMaXIelLZ4FeDTRp/N4uhgbsSspVh+U8RE2
         hv1bl3sJctr6wt8xT/Zx3zY9zY02IEq6v/smlj5XGWm9zif/QZvz+n/cpOTbkv11hWtb
         I2sB7nE/7JjHBDpFsXtPTH6pOPK5FwWkjo+Y7phFhAP9bPv0ObqepKstKw5/bc9woImL
         5fMpgIlVHpauCmpshRn6vIz9PPda4+vSKozgNJwavreTxjH6fhn/Bh5hX7KjjE7cP7S+
         CZ+45droZztTjapFg38LT7jyi6RIIZGcOgIWjKlHmP2hrC4+syEgDDAYRknDk1jzSuQh
         BVaQ==
X-Gm-Message-State: AC+VfDwM24StDOmyeWcGE2zoUhD6aVK688632J4r0yZJ8oM4DBAl0Xp6
        MaWMJedIcNQx5ZFn1BQFdEj4XaYgdlK3Su6AFuzrXenpZU6MBxXa+qag7ohgk9KVB8vgpa3pgc0
        uCgfDJ2xJJp8ujbuveHQPUpQ5TcU=
X-Received: by 2002:a1c:4b0f:0:b0:3f5:6e5:1689 with SMTP id y15-20020a1c4b0f000000b003f506e51689mr962603wma.17.1686310031580;
        Fri, 09 Jun 2023 04:27:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6w7LsURM3swKe92CefNektpkFsYqmjCbB+q5BkwoFvHxCz92JpRifnJNOzeTnxZcxMM5HBOg==
X-Received: by 2002:a1c:4b0f:0:b0:3f5:6e5:1689 with SMTP id y15-20020a1c4b0f000000b003f506e51689mr962588wma.17.1686310031334;
        Fri, 09 Jun 2023 04:27:11 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d48c4000000b0030903d44dbcsm4191258wrs.33.2023.06.09.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 04:27:11 -0700 (PDT)
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
Date:   Fri, 09 Jun 2023 13:27:10 +0200
Message-ID: <87o7lodgfl.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

[...]

>> 
>> So with FB_CORE, you can have default y if you have a real fbdev driver,
>> and default n if you have only DRM drivers.
>> 

All this discussion about FB_CORE is unrelated to your series though and
that is covered by enabling CONFIG_FB_DEVICE. I think that there's value
on a FB_CORE option to allow disabling all the fbdev drivers with a single
option but still keep DRM_FBDEV_EMULATION enabled.

But I can repost my old series on top of this patch-set once it lands.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

