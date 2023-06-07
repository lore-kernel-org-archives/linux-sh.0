Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B22C77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 07:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239322AbjFGHgK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239785AbjFGHfq (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 03:35:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55C7270C
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86qJ/vtJ5+0COg+eCE9cC1XNW8WWzhrqJj3XV1HnHmU=;
        b=LgLRX9tRd2Covg7vKgJXSI2GrQJGlm4sX2GdFdPl4D4GGJc3brO49j0FhnUd0pUz1HEOBk
        9mxHbXn7BxqdBncqUB9adSHIoNi5xWEy3pvOe2LfN/8RPcubnytaFvnIfdKS122jAObgGY
        QN+GedmZolUomLnUUydomn4THB44F/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-7apNhLfUPzqT25qn78JkWQ-1; Wed, 07 Jun 2023 03:31:02 -0400
X-MC-Unique: 7apNhLfUPzqT25qn78JkWQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7ecfccf2eso4505465e9.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 00:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123060; x=1688715060;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86qJ/vtJ5+0COg+eCE9cC1XNW8WWzhrqJj3XV1HnHmU=;
        b=E8hAboIB+dKT3ormYM+QwFQa/XtJXb1yBd9dV78F/5i2plqWVMsHPZCovSW7u/hhRL
         tZ5ozSgKthY2SM7YqhHBIYXXpXXVh+BSlaqeOmHvpGDCTCtEkIPKHTqQDa/vCHKAL5P9
         T0Mz0E1RoNCct6/lanEbrT30M1LDD0iLXtaD9bLpBIJtNX1XRvshPLfu/jNLN6SUbZzy
         bDDKp5gupiHpaftEZ7EuoQD9Pme+8xQ567VZhLv6Bh1PwULqIg8kcEgYTiuvsd45PPCH
         stqCWtTY1SXhqir7P2v7kfHyo0Wnc42qZz3rxAlycxQErxmHH0PTMOckx9t4NyaI0wOl
         bQaw==
X-Gm-Message-State: AC+VfDxfRDTC0sRjev16fGHKKpCbZKJqUZPAOMlLf49AVqBPQWlhwvH0
        tTGVYlXqWxP1LLjezHIf+h5HLjh+FjvzxOUq9NBoo5m46RnREA7sIbE3DKiiJSMK2x2PCgyeRCR
        wlJWGV+BCxS+Iw8ch6xg=
X-Received: by 2002:a05:600c:2117:b0:3f4:2328:b5c2 with SMTP id u23-20020a05600c211700b003f42328b5c2mr3787342wml.35.1686123060796;
        Wed, 07 Jun 2023 00:31:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uGo6zRkvpQ5estM3pdndUe5o7FAstx3xMsdIS0ZhyvoEoxkSKZkfhbKkJxPjpvFo09QUYlQ==
X-Received: by 2002:a05:600c:2117:b0:3f4:2328:b5c2 with SMTP id u23-20020a05600c211700b003f42328b5c2mr3787327wml.35.1686123060473;
        Wed, 07 Jun 2023 00:31:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003f4ddde398csm1142560wmj.21.2023.06.07.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:31:00 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 01/30] backlight/bd6107: Compare against struct
 fb_info.device
In-Reply-To: <20230605144812.15241-2-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-2-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:30:59 +0200
Message-ID: <87bkhrhgp8.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Struct bd6107_platform_data refers to a platform device within
> the Linux device hierarchy. The test in bd6107_backlight_check_fb()
> compares it against the fbdev device in struct fb_info.dev, which
> is different. Fix the test by comparing to struct fb_info.device.
>
> Fixes a bug in the backlight driver and prepares fbdev for making
> struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

