Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6A4C7EE29
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 07:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbjFGHhY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbjFGHge (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 03:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB010C6
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 00:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVXKtyFuQelZnCduaFGaTWYRY9d93/7uXkVVq77/kek=;
        b=CwuqI489c8L2M/pXFsPxJ8FXHy7FRAPQ+5n02PDCFmeiHqWFqFi2M8YzgbPSY4TyapaQj1
        3PSa0wp1HVdsq3BoVKyhSOY3YbrEp1NCQnZb4tYX3IYR+Dq/ZTv4h0i0AT9NUtHWrnse77
        nGp7wWjNeuPoUoiUnSqCmWf2Q2WBagQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-oFkxCP68NSyDL6YyV8Qrvg-1; Wed, 07 Jun 2023 03:35:38 -0400
X-MC-Unique: oFkxCP68NSyDL6YyV8Qrvg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7ef2456dfso2618405e9.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 00:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123337; x=1688715337;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVXKtyFuQelZnCduaFGaTWYRY9d93/7uXkVVq77/kek=;
        b=QJsmU3fZulYcIOOh8BHjOpQa5gsv6bWq2Ua4jbFnCVEgokoYJACYjmbUfQOC6IAQu3
         8GCRgYPfsmQPvpZLfIkE0gcF0aqkCF3fOgqu0uXO+ECKATnRDmirUE8XeoJmglLmz3VE
         MxavDZo3ryWPjSIZH/R24Uc3svlnMqkJ0H0joN854FR6rOPastFHojPKUPUS+jzl3IMy
         cbEUMeJZn1vGQj+bWezYrRnNsHWHTYt8irQ8ntXAY0Z0NXFZAbU0JLWBlGa0BRJ7Ak0Y
         vPDiOyttbF4wI67ycQEKe8ZTZM2Aa48XWms18vupkFODrhaXIL18oFjdyq2ddKtyDKtT
         1hfQ==
X-Gm-Message-State: AC+VfDzoUgr36GMVG28g/54CFNI6KLN3uXt8hMtaP8P6M/CzEtVdcG1x
        HOKIiKOTFPT4E9QR+aZBq3lcc+R8UUUqkwFSnA4ukFkuQQ5KVaikSE3Y0ie4CeVBdycN0XQJHmA
        wbKThu2buSzUX0i7iNTE=
X-Received: by 2002:adf:e94c:0:b0:30e:3ccf:d4b1 with SMTP id m12-20020adfe94c000000b0030e3ccfd4b1mr3545208wrn.4.1686123337741;
        Wed, 07 Jun 2023 00:35:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7c4uJeHgefHAPZBCPOj0COJN3FPjwSoURcR8FFlOhwLdItHYCa5GZjGrjPHZg2iimtHbMokg==
X-Received: by 2002:adf:e94c:0:b0:30e:3ccf:d4b1 with SMTP id m12-20020adfe94c000000b0030e3ccfd4b1mr3545188wrn.4.1686123337473;
        Wed, 07 Jun 2023 00:35:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s15-20020a5d69cf000000b0030af31c8c63sm14618215wrw.47.2023.06.07.00.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:35:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 03/30] backlight/lv5207lp: Compare against struct
 fb_info.device
In-Reply-To: <20230605144812.15241-4-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-4-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:35:36 +0200
Message-ID: <875y7zhghj.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Struct lv5207lp_platform_data refers to a platform device within
> the Linux device hierarchy. The test in lv5207lp_backlight_check_fb()
> compares it against the fbdev device in struct fb_info.dev, which
> is different. Fix the test by comparing to struct fb_info.device.
>
> Fixes a bug in the backlight driver and prepares fbdev for making
> struct fb_info.dev optional.
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

