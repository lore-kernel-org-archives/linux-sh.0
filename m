Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8B0C77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbjFGJEa (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjFGJEE (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BE626A0
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dioh0Uh8M64nhVsxEDgz6W+eW/pWMCOha9EWfOMUYLQ=;
        b=dmjAxi01MLrAUQLL4kyGxQW8CDG+KbrWHF2au5EqWUEt/I2BeangW75fFgMybcN+CmIHs1
        ZX8IaOSZk4ossZGlNctf3fbh25fxM8IixI7vz3/xJ8wWyyy3rgvaFxgkV3/LR1/0OIwMMh
        qmlaTc8ivhkDA8JXK2/9WVGvVofJ0u0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-XiqJqzxHMqK2dFgyRSm_Nw-1; Wed, 07 Jun 2023 05:01:59 -0400
X-MC-Unique: XiqJqzxHMqK2dFgyRSm_Nw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7e6582938so46027835e9.0
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128503; x=1688720503;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dioh0Uh8M64nhVsxEDgz6W+eW/pWMCOha9EWfOMUYLQ=;
        b=iXoaduAjHGSDmblIKLJpRNsIsPXP39F2jj4OTuQ+ZFHTlKxyp/3K/cYX+pXZp1gZ30
         xXLzZ1wrWeUe0jrBx8EcqnpNctpPAfGuKrZ+SJObWLVsvf+a0gY7fb1quGO0SCbOEIQg
         gX/zDV9XrWL18aMvIWYy1fx7hr1eUzm/RAv2H5P2fCiiQsVWvxLIAECRbjDy1Su3tCwF
         QJqTFa7SGDAX4B+9L2Rdo9zWCvKd973k6CGKK6JwxPB6DZ0UZFlkoqIpaJ8AH+cApkrT
         4TIIYgRy+3ebMzDeHtHIoCZq8BYuYEkACknxJQbLG8wcc5hj4Bb7CZxzX6I6WnRoOzx+
         9wMw==
X-Gm-Message-State: AC+VfDzqGTgjbAyIHKVlFg0uekF1gsPiqOd4CwGv5BDuKy7GNERtvPtg
        RbaSdyvE0OlmwBVh6L6tdoiiEXk8wgsoyOsPD1YFbwGit4ZN8+/N/ZYfJomr5DzApNwC+7FBN0+
        d3vBt1D38eRPknj7Wf+k=
X-Received: by 2002:a05:600c:22c4:b0:3f7:f398:e1cc with SMTP id 4-20020a05600c22c400b003f7f398e1ccmr353838wmg.36.1686128502807;
        Wed, 07 Jun 2023 02:01:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72JJUmKTY0S/fTapCQpRDv/nnMwi2EWc1cCGgNDHz8vB5pxi81zoyZxiDc07QRDM6iPj/yxA==
X-Received: by 2002:a05:600c:22c4:b0:3f7:f398:e1cc with SMTP id 4-20020a05600c22c400b003f7f398e1ccmr353823wmg.36.1686128502608;
        Wed, 07 Jun 2023 02:01:42 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b003093a412310sm14814796wrx.92.2023.06.07.02.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:01:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 13/30] fbdev/metronomefb: Use hardware device for dev_err()
In-Reply-To: <20230605144812.15241-14-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-14-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:01:41 +0200
Message-ID: <87cz27fxxm.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Replace the use of the fbdev software device, stored in struct
> fb_info.dev, with the hardware device from struct fb_info.device
> in load_waveform(). The device is only used for printing errors
> with dev_err().
>
> This change aligns load_waveform() with the rest of the driver and
> prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

