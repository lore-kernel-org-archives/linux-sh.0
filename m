Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD78BC77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 22:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjFGW0c (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjFGW0Y (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 18:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297BB26A0
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 15:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686176611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3wnM605gKMmCudt2hcJJr2EFLF4uSnPgF/R0Xs7/Z4=;
        b=f2In9eu0fcJlyEfFJZrs+XUR8lUfcGNlW8tcJ0idu7lCXQHZpvDOUJf2ylTRDD+f/5m5Od
        rtzLAeD+OqiYXe7KU1YvIEmGMy+qkS8Etwd3sMp8riXhLYEzW7Cs1f3/9WDtWR+cAbI6K/
        x1sQ65IK7z46Lkql8W2+M+afvSYNk0I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-gwaolc4GPDudkunfgAeZmA-1; Wed, 07 Jun 2023 18:23:30 -0400
X-MC-Unique: gwaolc4GPDudkunfgAeZmA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7f2d9a660so4378975e9.2
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 15:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176609; x=1688768609;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3wnM605gKMmCudt2hcJJr2EFLF4uSnPgF/R0Xs7/Z4=;
        b=Xi6ccsbyD9K2SA1WYHHOnOLDzoUEHI2yP8XII8mOaujRvXIxmRTnPZUvnvuSQbvDVP
         Q+34pKkiMZx5Oh9iMDQ0c9PDXBx0aDvHoqTMO/62wRQQgeMndO5AMMeWp6V3iD6k8WA2
         H8nSlajBRCYGdfJW7wUOPLdL8goMGqi3k9bosBfAn/7J2Ae2A7FpNRWIRCRJsO+EcUwu
         XsQZByJbEAmUhvK6ISh2ErgJwjVencvou6pjiYxrn0VWH0rFHXbOiBhfqgUmsKA5U+SK
         Jl2y5W4KrQ+IbeOyNz84ZJOUy5C94G5se+8eD2nMVnn9SsmJKk9W6idDN56xqonJRDJg
         WcqA==
X-Gm-Message-State: AC+VfDwGIgXHoD70GhywacOXlszB7dDUgbioRcvhMLKUMlt2Jvxp65Cn
        SVkRgVUiSMrIKaeT3yRTy6jXGDt3TsHQh3GiEx71cin/iluZ8ziQS/GgSg7VxeRzACSa8Mi2G2i
        cPwBN9AB1kH823Q9ATjs=
X-Received: by 2002:a05:600c:230c:b0:3f7:f4bc:ebf3 with SMTP id 12-20020a05600c230c00b003f7f4bcebf3mr1544745wmo.36.1686176609315;
        Wed, 07 Jun 2023 15:23:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46AO52oYq6hkZwI7LskizRRuqd6gfq8mv/AQFd6xOXiRAiGoamovfGXQJy96q8ipeUPGiuUw==
X-Received: by 2002:a05:600c:230c:b0:3f7:f4bc:ebf3 with SMTP id 12-20020a05600c230c00b003f7f4bcebf3mr1544739wmo.36.1686176608968;
        Wed, 07 Jun 2023 15:23:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d10-20020a1c730a000000b003f42158288dsm3313271wmb.20.2023.06.07.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:23:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 23/30] fbdev/tdfxfb: Set i2c adapter parent to hardware
 device
In-Reply-To: <20230605144812.15241-24-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-24-tzimmermann@suse.de>
Date:   Thu, 08 Jun 2023 00:23:27 +0200
Message-ID: <87bkhqewtc.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the 3dfx hardware device from the Linux device hierarchy as
> parent device of the i2c adapter. Aligns the driver with the rest
> of the codebase and prepares fbdev for making struct fb_info.dev
> optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

