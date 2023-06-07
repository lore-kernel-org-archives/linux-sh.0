Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC75C83005
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjFGJFS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbjFGJEr (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8EE2130
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1ensWxwtR1H9WH8H1jKCiwbKVNzMfKW0b7Yi6bDGCs=;
        b=A8YO4pF8JjIsj0laoj/M3mPzvGDeKawVgnrum8Kg0OPtX/ceT7FAerBt8HvfBDV5mk9D4g
        yu3ye4aWwECY2qYYluj/6L324lS5R5AFwuP6Gdvp6aD4srTfxmS1TlyaRcn/xDh1eVcGed
        hwC/qY0oHwz13+u5D5kHMPw/SBRmruU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-Rci2U6-jMw6fHwk9yQLVag-1; Wed, 07 Jun 2023 05:02:30 -0400
X-MC-Unique: Rci2U6-jMw6fHwk9yQLVag-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e4943ca7fso1212500f8f.3
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128549; x=1688720549;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1ensWxwtR1H9WH8H1jKCiwbKVNzMfKW0b7Yi6bDGCs=;
        b=bl2SjYYneV1WgPH2PYoYfDIgIxsheXkR8dAaZgs6AiobQbdYG5mWF2gU8b01TvsP3W
         FPNq4S+29i1s/wKUpFLT+zAraJzLA/f8qoh6pt04yW3DvVPC97LcrCgDsfaPDdfAktXK
         Cx97regeIPSCgxAkKQJQlnL6vHBJSiTU0xlg9weKiY/JzSF8JSFVgxbUYtsULjN5Tw+j
         h/Uba3uTYHRSFZ5qKQn92hhVC6JPLQPxkmnJsUkGQgZcJY+6zWkQi6KIh9aP0GoAIbBg
         C5yGD3yl+v/23ajigurL+HEtodKKy+ezhF1IeLCtJlhJP7wpHDvpcwX0U6U9NdadGycM
         KUtg==
X-Gm-Message-State: AC+VfDxvmXYVzupZxKvrm4cLuporjn76CRxRyPzYAyCWeGQdEU5SIIZf
        Ya9SJYedZ7h4/fEJ/agtk4tyd6kVmWFSRnYPKu0TgqC6UJ9NFSSZOCF3GyNqDD4XaHoHWY5CAd2
        7UAPHtpuHcDhM+CCZnuo=
X-Received: by 2002:a5d:5611:0:b0:30a:f030:8637 with SMTP id l17-20020a5d5611000000b0030af0308637mr3810374wrv.22.1686128549045;
        Wed, 07 Jun 2023 02:02:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tdzlumiDh+lcZSgp5sjiYX3gXCJJUKDHiUf2E4K2nudny411fzwbP2HTNQbZ/H/p4MQRLhw==
X-Received: by 2002:a5d:5611:0:b0:30a:f030:8637 with SMTP id l17-20020a5d5611000000b0030af0308637mr3810350wrv.22.1686128548788;
        Wed, 07 Jun 2023 02:02:28 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000108400b0030e5da3e295sm449804wrw.65.2023.06.07.02.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:02:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Antonino Daplas <adaplas@gmail.com>
Subject: Re: [PATCH 15/30] fbdev/nvidiafb: Use hardware device as backlight
 parent
In-Reply-To: <20230605144812.15241-16-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-16-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:02:27 +0200
Message-ID: <877csffxwc.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the hardware device in struct fb_info.device as parent of the
> backlight device. Aligns the driver with the rest of the codebase
> and prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Antonino Daplas <adaplas@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

