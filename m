Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D052DC77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbjFGJC1 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235583AbjFGJB4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A831426B7
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jAHIJ4eh7v+dqxg6uWyXvuAZ3noGOIESAVR0yVwLrLw=;
        b=DwyK9WQVqvQ9cSFYgvMBeHV6TdXe9DQ7zYXT4xUsk8YvraC4PrcsiEoWlr9nU0XE0K0M1g
        ocZj1aAlxBl3P2vd9zVMOIfoaCPcG4wh2SEN+eY62g0rhauFI+QBwU2EtH/X3tzZiGyzKo
        xoB/hMjD8HWKQ2S9E62ybkyKLX5dDEI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-hAgwPgCQNOmZhMOvxCZtsw-1; Wed, 07 Jun 2023 04:59:31 -0400
X-MC-Unique: hAgwPgCQNOmZhMOvxCZtsw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f6f58e269eso40363385e9.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 01:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128370; x=1688720370;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAHIJ4eh7v+dqxg6uWyXvuAZ3noGOIESAVR0yVwLrLw=;
        b=B7ugH6iNPRToOH1eHYBHQu5lxm3RWlkwCe9kq0E6SifFfMAmkC5CSPVzzfyKYA7boq
         EWq+7zEVofVxgs9Bh7IxzeNCIQi/abYkGeQKf5zZUySTbpWcBDTHpiikMX1uv5kdVBAe
         Tb8lroEyhfZqnv5wZL0DXdVYWVBeL5WCDgzgpCZU1lnK2rjIiX8rv2YJuCeO52Tpf4AW
         PEHHDjIDzxF4xIqxByU859BI0j+q7vMNA+FeS+A8vv8skawBjp/MFTQZ/jmJhezTUV4G
         iwwznM+YP/CO/qb4+VvRfCuyxGD6RUnsfN9+bfDlRi1iJEVch/LO4nBwlGN7Z/8Jmmx/
         9KmA==
X-Gm-Message-State: AC+VfDwdnk4bA+KO3yxC38ruiJxJmTtS/+GITgG37lW/bfPWxO4LKLF8
        sXGx/NbxtW1VgoxhulvMs/ONbto4zPd6gAzUw+0y6MMFgCiMxPJxkscOQz1u3ttR1zNurN5aHwm
        k72l1UX1RtdNDWD4pfPQ=
X-Received: by 2002:a1c:4b0d:0:b0:3f7:5e07:ea54 with SMTP id y13-20020a1c4b0d000000b003f75e07ea54mr4233935wma.13.1686128370565;
        Wed, 07 Jun 2023 01:59:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Qn3iTdYPwZ2PEqyICfVMTtkj5C/L8grzoRqC+iaiUjGk+XghGobRkAfICwnQ/2eAeuKuydg==
X-Received: by 2002:a1c:4b0d:0:b0:3f7:5e07:ea54 with SMTP id y13-20020a1c4b0d000000b003f75e07ea54mr4233912wma.13.1686128370260;
        Wed, 07 Jun 2023 01:59:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b003f1978bbcd6sm6448319wmo.3.2023.06.07.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 01:59:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 10/30] fbdev/ep93xx-fb: Output messages with fb_info()
 and fb_err()
In-Reply-To: <20230605144812.15241-11-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-11-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 10:59:29 +0200
Message-ID: <87legvfy1a.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix cases were output helpers are called with struct fb_info.dev.
> Use fb_info() and fb_err() instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

