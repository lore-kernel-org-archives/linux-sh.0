Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93BDC001B1
	for <linux-sh@archiver.kernel.org>; Tue,  4 Jul 2023 16:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGDQ2K (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjGDQ2A (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 4 Jul 2023 12:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2751703
        for <linux-sh@vger.kernel.org>; Tue,  4 Jul 2023 09:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688488029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4kQnHD6yHzrEv/r8EzHQhBzLicpYH1qRl0henJBZG6I=;
        b=GANYv8GovwJo5CcFTxYWcAD9OjMRS5iE6G0cg/myxE4OzepcuZ3FMBXwPwMNjtgl3qw2//
        kGnPwxVrGW4zhjQ5iIlQR80ylf/lcXawGNaATF+mcm1VSZjrqlCfqwMr0Barq5aE96N/5/
        nfR44PmjUEALH/fQoZd7mw47pTmtIXA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-iUvrDdgLP6Wh14H6XN-M0w-1; Tue, 04 Jul 2023 12:27:03 -0400
X-MC-Unique: iUvrDdgLP6Wh14H6XN-M0w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso40149315e9.0
        for <linux-sh@vger.kernel.org>; Tue, 04 Jul 2023 09:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688488022; x=1691080022;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kQnHD6yHzrEv/r8EzHQhBzLicpYH1qRl0henJBZG6I=;
        b=D7ova5C3scVqWUwPetaLkwwpsztojkVFNOWk/THM+ipQe95a2NYhtCeH6zxE52uJwP
         Qvl20VvvzZ/hWZMNeSN57aNzdb7RevSynEBtherdTWGUz6iR2+7+FUmUaY7WEN9QY1Rw
         WE+ddtbUbDGWGwSYNx7fsrnT8rTwQ52bmpHHKSBJdaA/Gdbk68XmIQqB5+olyYMEW1Lt
         lP6XJi73NXYfBkf16F7dgBM77V5oICvwJtjL6xPwOMfAMZ59K4QEkjKAeN4BnuE5vhuV
         c9ObmIfyishmvfK4Uw4w+U2UfxLIKZFjQVIX5VgJWwJ59x7hN5ZMGGZkLlS6FnTulzCA
         MQmA==
X-Gm-Message-State: AC+VfDxEJwli72xlLKidTOjTbQ2PjQUF0z2k9bOBvrrUc0A0tH9YKkse
        4pfhH6aOoyGdyZ1i/N7LgcMy10hxESvj9EuJej2W5VNN15qKPom2S+YSn5+lvHfc/vePmRWDT/9
        6cD9mw7sBN8LatjTcVkA=
X-Received: by 2002:a05:600c:22cc:b0:3fb:40ee:5465 with SMTP id 12-20020a05600c22cc00b003fb40ee5465mr13432852wmg.22.1688488022231;
        Tue, 04 Jul 2023 09:27:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5NuEVxTetvep8Gr1fgiFutV/xXoEkUhrAhQSPThqJdTuxw2Km/uBAzmwN3pOgdQUZIHRImng==
X-Received: by 2002:a05:600c:22cc:b0:3fb:40ee:5465 with SMTP id 12-20020a05600c22cc00b003fb40ee5465mr13432831wmg.22.1688488021988;
        Tue, 04 Jul 2023 09:27:01 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d58e3000000b00314329f7d8asm7499354wrd.29.2023.07.04.09.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:27:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        loongarch@lists.linux.dev, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: Re: [PATCH 04/12] staging/sm750fb: Do not include
 <linux/screen_info.h>
In-Reply-To: <20230629121952.10559-5-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-5-tzimmermann@suse.de>
Date:   Tue, 04 Jul 2023 18:27:01 +0200
Message-ID: <87a5wblk16.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The sm750fb driver does not need anything from <linux/screen_info.h>.
> Remove the include statements.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Teddy Wang <teddy.wang@siliconmotion.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

