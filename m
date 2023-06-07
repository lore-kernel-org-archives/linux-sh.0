Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2517FC7EE29
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbjFGJLi (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239866AbjFGJLK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62031FFE
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+PL21gB/daxR4zsJJ2MptIbuOMEv26lDV4Pg4ezd44=;
        b=arIXfBEYN6IM8CQbHpUfWR8D6iaDFiQbOWVyTTSvfj8nnZOr7p2sIRIYIH4Jy8Ufwyokgu
        /g2v84TNtexuhPSIDFT7mXHg16BNzNE/vRZUNtx+5tYcspqA9jk+mloVnj3Nc2We9deP81
        2j+vPm5/natzbSqgMPcKR/OpzUbnPNk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-QyQl2zDoOvKS2wOhtmNrUQ-1; Wed, 07 Jun 2023 05:09:24 -0400
X-MC-Unique: QyQl2zDoOvKS2wOhtmNrUQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5ec8aac77so43018505e9.3
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128963; x=1688720963;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+PL21gB/daxR4zsJJ2MptIbuOMEv26lDV4Pg4ezd44=;
        b=ZQ+4H+Zxh1yan4kcdamApmWeMlcs9ayw4OirRV+cki2E4NwBiq9ze5nMbq5WxwxdM0
         ZMLC9wOjZEd2nzTxvbVUP/ogoIA/nPi8jwmnqzB5EiXxJoUrhZdmtGXTiLVszvZA9zv3
         sOcrdFJ1ZehQPPbWh9iIaERjAIK2py7maThqe7/7AgKLTdakq9Qprc01wfMSJIYkivem
         bvw3mNRovr5fMtm2QkKN4sJ2P42AJGqlWjxe7QteCdRNA/WlbqwlAwAXRXHRgXOfxsuG
         BBw59IYkankC0kz77zxs68m5f+G0S/8t/eCFuN7MfLNS72ozUWVOfKJUB3ke5QQDiFl+
         eAEw==
X-Gm-Message-State: AC+VfDxqeKj+30hbdcSZ9mqLc/k6rKEthNmNcSouG5ley2yfTkLaeQa/
        TPIY4YmwUQ8zvpBsDIIslldMNigR2UmgCzM3D6C+fL8zEcepVL453p6SiawHwDHLTKw8sUCsXLU
        c4Vvy53JfvOZ51dTm4D0=
X-Received: by 2002:a05:600c:b45:b0:3f4:d18f:b2fb with SMTP id k5-20020a05600c0b4500b003f4d18fb2fbmr4423507wmr.8.1686128962968;
        Wed, 07 Jun 2023 02:09:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KIDwr6/boDKEelyImr80QUEOg3IdkbWZ6AUo87k2W9nGNMdMne7IQ3JZzUQzQ4CBO1bqmKA==
X-Received: by 2002:a05:600c:b45:b0:3f4:d18f:b2fb with SMTP id k5-20020a05600c0b4500b003f4d18fb2fbmr4423483wmr.8.1686128962700;
        Wed, 07 Jun 2023 02:09:22 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id k26-20020a7bc41a000000b003f60e143d38sm1426996wmi.11.2023.06.07.02.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:09:22 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 16/30] fbdev/pxa168fb: Do not assign to struct fb_info.dev
In-Reply-To: <20230605144812.15241-17-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-17-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:09:21 +0200
Message-ID: <873533fxku.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Do not assign the hardware device to struct fb_info.dev. The
> field references the fbdev software device, which is unrelated.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

