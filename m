Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318AAC83005
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 07:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjFGHp6 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239625AbjFGHp1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 03:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708331FF3
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 00:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCpM3n9uxiNBqWYphesbEdJfBdCBdNVjlNpr9KooViE=;
        b=gZ231ichOXO2PsDCf8N78v1GZF4IuEVoChlFzGhTho8vPdadPGv6BCU3+HNWnxwld7AnSZ
        b37cO1SM9r8OtfjqLmTYk4i8qErdpRr888h3ytpxr8QKrQPgKDU41i/QcWZsNvW3/IteJH
        awYL3CHNBeBASGhvcg0DRLFpJKnOZSA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-O0KWhsL6OB6T4hU8F_mirw-1; Wed, 07 Jun 2023 03:42:19 -0400
X-MC-Unique: O0KWhsL6OB6T4hU8F_mirw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30c5d31b567so2492984f8f.2
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 00:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123738; x=1688715738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCpM3n9uxiNBqWYphesbEdJfBdCBdNVjlNpr9KooViE=;
        b=ZarNLtp6k50+6L93uEayC4BwnssLcvyzNmP0OCqaiDdhwmQgyPXJO+x6TFHjVnR4c9
         AV8xyDpj3BldjXxqGHSyd4kpO3GGOsYkwy43qNFD0gfsUs6rbMT9TTtocfRDK2ALzqZA
         q2cp3PbqlKr7BZ5G0dDI4HZEnq5NU5cq81bI9ceyyzA/WzV6RnYoQXruMWbY+ZzGZxC4
         y48vkhFyvdpud5D97bFShURhHR0q1fgHWBea5i7IVDCbzaMc/o41OTw3CcVqK3GgOPHK
         dx3xW1euY9BjSCGMc+ouVN8tIKBMe64oZ9MH4didyXRb2B1Zh22r+bEcF5einBk7vHHu
         8ItA==
X-Gm-Message-State: AC+VfDxMCoDVbyuUh/d+1pBx8Cvx1FBoISq3cipMUX4RMPFQx8VKo0ar
        H3W7fDFqlgEO+YgjLrgAjW471+K9Qg0vSY6cGndat/NiEhsHmr/iFK7PJDYM1mjx+INqBY7QE4p
        lrMT2BjuIXBiOdQnnJ84=
X-Received: by 2002:adf:eb88:0:b0:30e:45ac:810e with SMTP id t8-20020adfeb88000000b0030e45ac810emr3734966wrn.36.1686123738653;
        Wed, 07 Jun 2023 00:42:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KZwfGmENtFpHBv/PbHt1rJPnSSY7XTJGSBoIFHGMz6zbW+M0/3e5qcpQ+OgRWGlPIuGCuTA==
X-Received: by 2002:adf:eb88:0:b0:30e:45ac:810e with SMTP id t8-20020adfeb88000000b0030e45ac810emr3734950wrn.36.1686123738508;
        Wed, 07 Jun 2023 00:42:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b003047dc162f7sm14752394wrw.67.2023.06.07.00.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:42:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 06/30] fbdev/aty128fb: Reorder backlight and framebuffer
 init/cleanup
In-Reply-To: <20230605144812.15241-7-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-7-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:42:17 +0200
Message-ID: <87wn0fg1ly.fsf@minerva.mail-host-address-is-not-set>
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
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

