Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF0EC7EE25
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 22:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjFGWaH (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjFGW36 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 18:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC5E2700
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686176918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=irRG2hn1Ih/d+vMuj88e+Lh/5vC/wBK+G/U1UA7S7zo=;
        b=UPwoq8Jw6iEHtz6qkm97dSgQfa62gP7WEXEAtlqbqG6iyTKDeoDK2+ajhttO4rr6TLSH12
        JuC5BldX/k4l6Ymc0YIk0BA1ODLMqQFybFtttyGF1ODk0084ODjhCJ2vObNxUHlNT4xxmI
        HWFsHy8FQHBX2mXUMfXCvbVfUVil+JU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Jl1nHq_UMKWjz7xJCjzazw-1; Wed, 07 Jun 2023 18:28:37 -0400
X-MC-Unique: Jl1nHq_UMKWjz7xJCjzazw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30af222c5feso4319138f8f.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 15:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176916; x=1688768916;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irRG2hn1Ih/d+vMuj88e+Lh/5vC/wBK+G/U1UA7S7zo=;
        b=LYF7VYL0hwg6T0JqJr1l/Y0Q/8NAL0nFhXIjQXsv5uf4/TE5exTQLq8RrHmUZVi/FI
         WQuG63jUPbSJefxM3R95dSN7lbHueShu0nUCJ8ulnCRWRwhAzw8iDAHuMXrqZgwQXQrK
         DF0HvhrxQx/QaopaxFFbq0ToKVWpQZJgV8NaLmGm6922UB9Q0QUiPsaYYcCy4qnSltpD
         +GBsETakGM3tYyiQ5du8BWoxDcr/a8opDoEiQW4bleX7o0DPwM4Ak9VykD14cTS5iupD
         a5jpU920DW8hOyWSlCzlHmXyYmNhkVwjkedsPwFe1XuU2SuzSAclET+3Z5HLH9di7RyO
         QpBQ==
X-Gm-Message-State: AC+VfDxrbkA7z1CUSK8+ho2fiKz30URw8rc4io3lzEmNAPpHC2aBIrFi
        I7KBW6as/aMTz03N2BViD91+S5CprL0hNG3LR1FNnftZzyf3912ilCiQa8KRskm388qgTRnymZP
        dLWXfIpsVJ6HV45nqHPU=
X-Received: by 2002:a5d:650e:0:b0:307:9da1:c9d8 with SMTP id x14-20020a5d650e000000b003079da1c9d8mr4923754wru.4.1686176916352;
        Wed, 07 Jun 2023 15:28:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61tYV/VqxAjAws580IyjPbyEEBH7wxqnNFkzkRRkVd9vumKgbQUzpT98wO/2M3vhdVG8VhKw==
X-Received: by 2002:a5d:650e:0:b0:307:9da1:c9d8 with SMTP id x14-20020a5d650e000000b003079da1c9d8mr4923745wru.4.1686176916109;
        Wed, 07 Jun 2023 15:28:36 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v25-20020a1cf719000000b003f736735424sm3323437wmh.43.2023.06.07.15.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:28:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 28/30] fbdev/core: Move file-I/O code into separate file
In-Reply-To: <20230605144812.15241-29-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-29-tzimmermann@suse.de>
Date:   Thu, 08 Jun 2023 00:28:35 +0200
Message-ID: <877cseewks.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Move fbdev's file-I/O code into a separate file and contain it in
> init and cleanup helpers. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> +
> +#include <linux/console.h>

#include <linux/compat.h> here, the robot complained about:

   drivers/video/fbdev/core/fb_devfs.c:183:9: error: unknown type name 'compat_caddr_t'

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

