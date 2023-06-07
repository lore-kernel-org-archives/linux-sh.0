Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6812C77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjFGJFQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbjFGJEU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B694D1BC0
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mH0V+GQH9u3hTOintFl8kIUIu94Srk8ZL012Xjzg5pc=;
        b=M1sD8BqDNNXyoyna4sw5l0Ry+8hFfSj1fdSSHNZzeMQzl9aH4oUuzF1HTAgeAqGRty9Bnx
        9xhTUrbgfoxc7cclGkInR63Ojw2FKpbSnKLhnmJnuKyF867vGtuKPsx8It8jvigIXbw2qO
        0/pJyTm9nPJbeEromm1XB9jh4Du1FMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-HXxLdvAwPIyOdUE5kYRGPQ-1; Wed, 07 Jun 2023 05:02:08 -0400
X-MC-Unique: HXxLdvAwPIyOdUE5kYRGPQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30af3835de5so3041451f8f.0
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128527; x=1688720527;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mH0V+GQH9u3hTOintFl8kIUIu94Srk8ZL012Xjzg5pc=;
        b=kfWb4LKId3/IVeaV2HUsYEPxgviTASN9LgSFpbZrPWDSs0ey7MJiMrlwjsgb5Og7t1
         AprAXTjmdcUcINt2Blc5z+bGkKtUuig79Gk9YTS8NBUV00GjporMkIBRIxOnk0QW+Oqh
         abhUCUIOmUcWgc07mYC+96+3pDCDk6+1ottt19KK/gUdpQnSViLKJ0M3F3lABbYGc0Wt
         njB5vFClr3OwzqeQc88ChDVg74cmwjYuJnCJNQiDTloLWNYhLDO2XAE8kHyoET+pfACM
         L0+eqBHq6yjFhZ4uvt+T9PuK6v5IGtawtb83d9LOl3SRHXqsnZFFgnhDdtFVeSA7I7vl
         lR8g==
X-Gm-Message-State: AC+VfDyd9Fq5kCBSiocuiolG3I1+ATtrGjdHF2v0euG5g+eWyl+XdAN3
        2GNM/Gav2B1DH4eA8m1KDC9viW8IlT2UOwJ7tFYtBCg8xW//uT+FFs6wkCKg6TRJOW+m0DqJcw/
        thzNbdJSOKZUXcMImKt8=
X-Received: by 2002:a5d:5642:0:b0:307:bd64:f5a4 with SMTP id j2-20020a5d5642000000b00307bd64f5a4mr4077062wrw.52.1686128527753;
        Wed, 07 Jun 2023 02:02:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+RtLt6z9BsPsahZF3tzNThAhq9O2T1soohVRASzXnOQHusHmP/yNJTyZBUwoEWLT/tzAX+w==
X-Received: by 2002:a5d:5642:0:b0:307:bd64:f5a4 with SMTP id j2-20020a5d5642000000b00307bd64f5a4mr4077038wrw.52.1686128527482;
        Wed, 07 Jun 2023 02:02:07 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d4b0a000000b0030789698eebsm14921477wrq.89.2023.06.07.02.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:02:07 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Antonino Daplas <adaplas@gmail.com>
Subject: Re: [PATCH 14/30] fbdev/nvidiafb: Reorder backlight and framebuffer
 init/cleanup
In-Reply-To: <20230605144812.15241-15-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-15-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:02:06 +0200
Message-ID: <87a5xbfxwx.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver's backlight code requires the framebuffer to be
> registered. Therefore reorder the init and cleanup calls for
> both data structures.
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

