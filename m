Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE347C001B1
	for <linux-sh@archiver.kernel.org>; Tue,  4 Jul 2023 16:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGDQYg (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjGDQYg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 4 Jul 2023 12:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980E910F6
        for <linux-sh@vger.kernel.org>; Tue,  4 Jul 2023 09:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688487824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2FITFWtbRXE3gky2EO4aMziTa3J/r1+wMO4yc2vs7Pc=;
        b=Yaj0XoGTnPY3jldtaJrBd3h0EFLc5QY5r2f1GcQiDU5Bwt+QkhnRA5Y3ClkBsx59aWT2Mc
        O1BXRKMpVO9+Wb82xQFvJuf17h84NyATS9f4N1wgCJHvmtmtX5bmQkya0n1s8pMiouL+Iu
        fyHZ1/QKZQcqnRr3IdPIPspTAWH3/GI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-haRNjml5MJqq3L90IW-kQA-1; Tue, 04 Jul 2023 12:23:43 -0400
X-MC-Unique: haRNjml5MJqq3L90IW-kQA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa8f8fb7b3so63631255e9.2
        for <linux-sh@vger.kernel.org>; Tue, 04 Jul 2023 09:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487822; x=1691079822;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FITFWtbRXE3gky2EO4aMziTa3J/r1+wMO4yc2vs7Pc=;
        b=ltfuuT5ei01GqIWmnokhzCPfEjVkUHUM5DFFokInohftB2Fca3zqUnlxVnR8pby0EV
         TTK9D97CNAmRMRuPIvdLY/zH5F6zGbEtSmQdT/6s3mH8G5Bs+WcwrBg1Ncxdph27aEWf
         /iYoaihK/2hOSPTDr//NqWPn04QuIo3GzUUvqgBK8gI7DjP6pw3/dQpg3KoKALIb2dlm
         +U0A+X4KqRpAwCdKuMJrDXWoizvqqsTmDBbUx9Cgm8yY3kWZUjFemWANrYvBXA0xxQSZ
         +J0IyBKdlADi1vCHfaxusNrrHBN5/ng+ZNosbXQTd6Hh3qdR0vR0++rul8/5PcOeMaK+
         eG1Q==
X-Gm-Message-State: AC+VfDy5V5BSYftNXP/j3LpQMIpJM7YnRw1HcVKkH4s1QDiA6stn3yHy
        UJn0beuWpA5LrqORif9JFpsBIkLA0LBkei6NgGJLSlvPvpaJV5e6a3dzzJDDI4Y49myAjuxtMti
        i0RxasctEVM9+RmFUO3U=
X-Received: by 2002:a05:600c:2145:b0:3fb:415f:a85b with SMTP id v5-20020a05600c214500b003fb415fa85bmr18158804wml.3.1688487822320;
        Tue, 04 Jul 2023 09:23:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7T04nL74CM9kmUBFWNxbGLn7ruUc6nb3zVFQfaw7cBAYtqvH64gACvFSpImO/HrduwXThnBg==
X-Received: by 2002:a05:600c:2145:b0:3fb:415f:a85b with SMTP id v5-20020a05600c214500b003fb415fa85bmr18158793wml.3.1688487821958;
        Tue, 04 Jul 2023 09:23:41 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003faabd8fcb8sm24447459wmi.46.2023.07.04.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:23:41 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-staging@lists.linux.dev,
        Russell King <linux@armlinux.org.uk>,
        linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 01/12] efi: Do not include <linux/screen_info.h> from
 EFI header
In-Reply-To: <20230629121952.10559-2-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-2-tzimmermann@suse.de>
Date:   Tue, 04 Jul 2023 18:23:40 +0200
Message-ID: <87ilazlk6r.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The header file <linux/efi.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements. Update a number of source files that
> require struct screen_info's definition.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

