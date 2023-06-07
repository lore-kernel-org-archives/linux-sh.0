Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59475C77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238476AbjFGJMb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbjFGJLv (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F756210E
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RSdIsVX6ecFqz04GkrugK7lp/x5jJUtqPYllPP5sQjg=;
        b=I74y0tfgItcFuhXmElIzTmpRoKAfGOtbtKlRoK+fA8rLp9aHFmjoYV/hHQ0X9nZaU/PRGO
        oydORCprTlo4/LkxdIA58QRR0Cdx88woHp16iEJwabYj0b9CaXzF30V8obbuBzZ+jnMlhP
        zGoxXly3c/Kz4ncf8jZOuOjYue3zHps=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-NEQrn9SeONiEBLVZ92mtug-1; Wed, 07 Jun 2023 05:09:58 -0400
X-MC-Unique: NEQrn9SeONiEBLVZ92mtug-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f7eb415010so2069845e9.0
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128996; x=1688720996;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSdIsVX6ecFqz04GkrugK7lp/x5jJUtqPYllPP5sQjg=;
        b=A87xnNgGG8RgHXDajbkvTSseyN5ce2OSVQrleInFKCyI+t24q7gOY4QakKzsOQH5Pj
         1sOWe4q6xo/LpcfcJGkBxeTVF4ICxyHQJdsxvLtxitXt+vZp0FrGkJK+X/1mKmyqVI4H
         McB9u+Hw1JM13iAXyWWK5o46+wxbBXstR1YfMUMdRAx67S6jiS+LGtbw69T6qToOxvKd
         94i6Q7RDVaKAf7y3NCwS2E97hssQaqSv19l5oVZBjjvdkcz0VPXdfWmqx+HtTl8DI+hj
         eeNrAmGlyVWhoKwZfraLe5KOfNjPPlz18RH28WI8XSVS78V0dhSN2ENbp34VwlTJsf1W
         tU2g==
X-Gm-Message-State: AC+VfDy/c2sb/Wumg6EJeGhHNTG/vxXGLcJ82EWsZgu5ag9gKokxpYA+
        uu8OYholPzlxO3ZFHqPU89Nvk2RL56ZDpxccCgFaBn+zraXKG2jgAWEl3iQ03rd1PnjbGKDt+e6
        ebgCokVUhBZJeKD+tR02C6w4kCyQ=
X-Received: by 2002:a05:600c:220f:b0:3f7:395d:6585 with SMTP id z15-20020a05600c220f00b003f7395d6585mr7850361wml.15.1686128996490;
        Wed, 07 Jun 2023 02:09:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4S4Ug1fiHJ0oCExHc5SSiTGb/dJv10TIcn7zVRyFtmlI7TI/i0oDDpnO/bY0dqK+vi3g6l4w==
X-Received: by 2002:a05:600c:220f:b0:3f7:395d:6585 with SMTP id z15-20020a05600c220f00b003f7395d6585mr7850336wml.15.1686128996200;
        Wed, 07 Jun 2023 02:09:56 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v25-20020a1cf719000000b003f736735424sm1425404wmh.43.2023.06.07.02.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:09:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 17/30] fbdev/radeonfb: Reorder backlight and framebuffer
 cleanup
In-Reply-To: <20230605144812.15241-18-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-18-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:09:55 +0200
Message-ID: <87zg5beizg.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver's backlight code requires the framebuffer to be
> registered. Therefore reorder the cleanup calls for both data
> structures. The init calls are already in the correct order.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

