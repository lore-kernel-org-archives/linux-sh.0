Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016A8C7EE29
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbjFGJMq (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239676AbjFGJMP (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:12:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40EE172E
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EIz8b97+2mar2ffqQ22U9WQizWobZ+ziDNV+MHu5qjc=;
        b=JY+mwF/pf9OnprNtZLhk/UnUqGl6KHprB0Nx5I4sEopGBFyaXz5wxoZL3uCL6WWTFKKiQZ
        vUn2hEg01hgtLBifOfdkZ/ckRrxv7H6sb6hPIbeF3EDZWfyUg7gWW8L+dg9ddgCRsJVMW4
        LrHf1IQ1niWZlRvzTfjP/BicdzGTVMI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-QA5BKjB-MouABRK7rUaEXA-1; Wed, 07 Jun 2023 05:10:25 -0400
X-MC-Unique: QA5BKjB-MouABRK7rUaEXA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7e6582938so46154525e9.0
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129025; x=1688721025;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EIz8b97+2mar2ffqQ22U9WQizWobZ+ziDNV+MHu5qjc=;
        b=V8Z07uYFy+ZogVQjLYBKQB7mhF0BFWODVQW6pN7w9EzHW4S4ZDKujiWRZcnwXYRx3T
         BegF2FR/jLrDyh0LkPj2y3i6mC9YM0ULBHVLQxeGghl3Hik8ymaE5kW2nMfbI5T6Dm6q
         +rqlMPKheWABuhVE12sVxCT2XhFrWL9gb8VU1xFA+nn4JKwcjn9CxU737HPJMD6oIp0/
         bR04EQxtW56PzTLQBKltV+7zTF77Ax3ERCjamqb204c4OACiksUNkgF1yH7fTuds2Q83
         zzkpDu9zMh1Ez5XlGLEKw3Zz5AFklkyliJcXhmuZKixqnab+EJpkO/90V1giCdAv0Y8j
         V0KA==
X-Gm-Message-State: AC+VfDxatHJzlTT+DIAUXN8trWKb/IsR2QLLThNukurkh9eq9Ga23hRl
        xlv77rbYF0XBzUAd890j2PnvEX2tn7BweCuN+E0gliCGCZSgH65XjL2sXcjDG8kPmY99SUZSmDc
        Pzp9vwMcLxM4GYcFlQ/o=
X-Received: by 2002:a05:600c:a395:b0:3f7:3401:17ac with SMTP id hn21-20020a05600ca39500b003f7340117acmr4587428wmb.5.1686129024878;
        Wed, 07 Jun 2023 02:10:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ePD432YmabNuUR+sxJiR/Lq4y75rOFMJQocJYAFtsL3UId8CM+YY12IKNvHU0PgR+SDGlYA==
X-Received: by 2002:a05:600c:a395:b0:3f7:3401:17ac with SMTP id hn21-20020a05600ca39500b003f7340117acmr4587416wmb.5.1686129024708;
        Wed, 07 Jun 2023 02:10:24 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f10-20020a7bc8ca000000b003f7f249e7dfsm983105wml.4.2023.06.07.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:10:24 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 18/30] fbdev/radeonfb: Use hardware device as backlight
 parent
In-Reply-To: <20230605144812.15241-19-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-19-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:10:23 +0200
Message-ID: <87wn0feiyo.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the hardware device in struct fb_info.device as parent of the
> backlight device. Aligns the driver with the rest of the codebase
> and prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

