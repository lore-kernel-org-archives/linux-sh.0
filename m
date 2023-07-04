Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA10C001DB
	for <linux-sh@archiver.kernel.org>; Tue,  4 Jul 2023 16:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjGDQ12 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 4 Jul 2023 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjGDQ1W (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 4 Jul 2023 12:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4E110EF
        for <linux-sh@vger.kernel.org>; Tue,  4 Jul 2023 09:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688487995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3N/Gyf3beclIUSfPsZhAnE2wLloPptbf+HqX/lLqDWc=;
        b=L4PRFPEXE9FaoZxdmr78ejtRcYtHg1xWmMcHZE/5eeSj9u7kI/PJoCp0M67KuYrhcXb68b
        uU61kejfFF8VLVkJsZtBn4lNp9ObCkPazHBC90lc9o559bw5EiRaOxIsgkvyok9lYWnAl5
        dcZqDAH1NNaAZu+q54mamEU8H5QaUfQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-byZbzGlVMX6K4qhYjuNqxg-1; Tue, 04 Jul 2023 12:26:32 -0400
X-MC-Unique: byZbzGlVMX6K4qhYjuNqxg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fb40d0623bso27146595e9.1
        for <linux-sh@vger.kernel.org>; Tue, 04 Jul 2023 09:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487991; x=1691079991;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3N/Gyf3beclIUSfPsZhAnE2wLloPptbf+HqX/lLqDWc=;
        b=XDnKaRZWqxqLjMCz5rfieIwhBD5OFLEasW66a0cVUBO5F6Q2leNQv2luezrcN/h3i0
         lX+/sKbYtv3BFuekw7KoNqsCTH/E4/Nw0I4hWqhd0SAZCYZcGAnHralB9S7qwu0heEF5
         OtU2bY5OeyxvYBnWJfd5x/nRBpXkIiY5LTPPJwXvgF4Fy976sEIzRyIdgFd/6AnAJzP6
         fQp79zkt72aSCQzgMEltWBHmwe+cGyhX6POAmTEpUNI6OY71Wj/3vONTeizZREQouhvo
         CboB8LJ10ikrujCXgcSdBC8hW9c9Vy97Bl9GmVlVos/DKUBO3ryk4/DX4D/E2dJlqJ5w
         lmuA==
X-Gm-Message-State: AC+VfDxP4mz8cFwIYEzBcor0vqAHmqi+UYGykJhk8f4l9Knmy/QFJYOg
        y0TDr9m53uytpTXOeVYvbTWhmo2jbkd5GU4SIhtklgLJJxLLiQlD25+3ZWTTn2mckEguE36llmO
        ZgKrPmyEPLzX3dJFC2V8=
X-Received: by 2002:a7b:ca57:0:b0:3fb:af9a:bf30 with SMTP id m23-20020a7bca57000000b003fbaf9abf30mr12688271wml.2.1688487991011;
        Tue, 04 Jul 2023 09:26:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71ufTEe/wWv7h1ExOsJanD4siZOoua0ql6zTBm+MH4Z3jUb1+lMMqlPgaWI376xU4gg3rSqQ==
X-Received: by 2002:a7b:ca57:0:b0:3fb:af9a:bf30 with SMTP id m23-20020a7bca57000000b003fbaf9abf30mr12688259wml.2.1688487990852;
        Tue, 04 Jul 2023 09:26:30 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s25-20020a7bc399000000b003fa96fe2bebsm25398819wmj.41.2023.07.04.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:26:30 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 03/12] sysfb: Do not include <linux/screen_info.h> from
 sysfb header
In-Reply-To: <20230629121952.10559-4-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
 <20230629121952.10559-4-tzimmermann@suse.de>
Date:   Tue, 04 Jul 2023 18:26:29 +0200
Message-ID: <87cz17lk22.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The header file <linux/sysfb.h> does not need anything from
> <linux/screen_info.h>. Declare struct screen_info and remove
> the include statements.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

