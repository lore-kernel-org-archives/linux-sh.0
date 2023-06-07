Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D03C7EE29
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbjFGJNd (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbjFGJNA (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745B212A
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mH0V+GQH9u3hTOintFl8kIUIu94Srk8ZL012Xjzg5pc=;
        b=hy1ts/e4vaL+GxeT4gl0KEkJq7sahjb/dEt7ryFgn/ffoGA4kvnzuwuU4JgUUC/JSNX/EP
        dkCw/sb4bNsf6vLm2W2On/zCHHILQFmyecybdbNKOiqcRV4mqRP70YFpRyEsP3NhLDRQcX
        VHOAzHFmifNs9chifU16fPEWcSG0gIA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-QYhX8hlCNYiQ_uX0ZFYoWg-1; Wed, 07 Jun 2023 05:11:15 -0400
X-MC-Unique: QYhX8hlCNYiQ_uX0ZFYoWg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e3fb5d1a4so1543208f8f.3
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129074; x=1688721074;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mH0V+GQH9u3hTOintFl8kIUIu94Srk8ZL012Xjzg5pc=;
        b=flUrPCrOSQJLuyqY/zl4Z+YzOqnvvWCNEFJQ6WRcpwnO+VKo7g2L9KxuPanMXLE30J
         zzLyCSXxgCqmMpGZ35b6SbVU4wb3jl1SPuE5AsYobQt5YgDF34NKvKxinipq18fLmHyn
         JsgPzSXsQJOgu1m9oYjUa/KGBAoBC0yeoIVpfJu2eSOobXv2n9SvN8ceQoAOehGjMGQh
         diUZJUlJdwNsYY6FuenieDoqPdG5+jyS6iHIDYzNLDqJSRMdxTG4QQTtZICMpGdB5UI8
         94oiEVAV7f+0p1nRjh3v4kYVgdxD2NKtLb880I7C1qzsqJk0azQPcpRFiehhKMe0/p3m
         0uJQ==
X-Gm-Message-State: AC+VfDyevJTSQOLoM7UHJOGUvG6wiJIk11XX6OuiEpuIa7+QeR6R+fqo
        /kCta2qESGR8eDSNL6H+fHObM8uQElIzNLuHaNml4MAmrTLvuCcVjlc7TLgg5UVBh1b4So4du4t
        o9pRD6UDuFSaRvNHGb/8=
X-Received: by 2002:adf:e688:0:b0:30e:32b4:88b1 with SMTP id r8-20020adfe688000000b0030e32b488b1mr3941818wrm.9.1686129074280;
        Wed, 07 Jun 2023 02:11:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4KJfeyDxYfcACaVW0UaN5JNsg10BzGoz+FuMEljUH8CXhTXkm2kLiaHaEUmQ35VeCWg/34qw==
X-Received: by 2002:adf:e688:0:b0:30e:32b4:88b1 with SMTP id r8-20020adfe688000000b0030e32b488b1mr3941796wrm.9.1686129073975;
        Wed, 07 Jun 2023 02:11:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k1-20020a05600c0b4100b003f735ba7736sm1412543wmr.46.2023.06.07.02.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:11:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        linux-sh@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 19/30] fbdev/rivafb: Reorder backlight and framebuffer
 init/cleanup
In-Reply-To: <20230605144812.15241-20-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-20-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:11:12 +0200
Message-ID: <87ttvjeixb.fsf@minerva.mail-host-address-is-not-set>
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

