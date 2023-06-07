Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2729C77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbjFGJOe (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbjFGJON (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ED72D51
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1ensWxwtR1H9WH8H1jKCiwbKVNzMfKW0b7Yi6bDGCs=;
        b=fy1hBXuUm73fJRhjHSuCcB/TPbdtXp4xRQQ89Pi9GWWGyKzQkly/bMT83PgeTf6DInpTON
        DmvI6Qk78XicPJBbvYlxyoAelX58lA0VC/nTD0zH/LRfex3rSlyGdXflrbZfm4lJEOIpyj
        sM6qZWxfgjSvAQSAE/UPdDQB1rTjijE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-A8vtz1EiOniPg5hi_PMFPQ-1; Wed, 07 Jun 2023 05:12:01 -0400
X-MC-Unique: A8vtz1EiOniPg5hi_PMFPQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30ae56a42cfso3869562f8f.3
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129120; x=1688721120;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1ensWxwtR1H9WH8H1jKCiwbKVNzMfKW0b7Yi6bDGCs=;
        b=UmYuqmN52tVj567NUfAeaHkOv2cVVnDrBvY0nndkGEcCshfWTxHl21bQWtOlZjq84Q
         9DWOLZ/VyArbJNc3awBwIkguWkbom0PwsQTeKE+WVYFCv4Kdy/pfU0igC+RtXOJ0EaMh
         STYBRxfBfd0YxbBqHqU0G8dKzSX/JVYAB5dwE24YncqU8VWCHtQOL5v/dmjB55Py4M0n
         fGHtFhbop0h+uB+X1kCU0ikjWsK/kUCuKCq9mqM7SfG2GO6K714jyg7kYby4MBiia3Vb
         Z4IV3NG7xt75VKPg/DVZ3Sgsn4w3gf9MZUuULRfuuw7KkYqSFQUcZKW6nSG3GG5Cx7Wv
         PZ2w==
X-Gm-Message-State: AC+VfDxearUyDLYWEsk9Vh6RX9LL2+SHmvRvg/wBv0+WE7haXptCSNIy
        WiMWNYjZ2zT8tqM/HKOc+w8MyYfz8p7ip7qpwr6qjzq2EOhd/A8okhJPs9L6zjzNwL7399DMfFD
        kHN8F9GVNNGdwMrE6jts85nxCZWE=
X-Received: by 2002:adf:efc7:0:b0:30a:eada:8b9b with SMTP id i7-20020adfefc7000000b0030aeada8b9bmr4008352wrp.41.1686129120263;
        Wed, 07 Jun 2023 02:12:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pKDNydRWrc71fW3bUFKqJDv/PfRpGWQYSkEIZ2IoZqLYQ3oH2ibQ9gh3nWmNRpad6J8Zxng==
X-Received: by 2002:adf:efc7:0:b0:30a:eada:8b9b with SMTP id i7-20020adfefc7000000b0030aeada8b9bmr4008341wrp.41.1686129120078;
        Wed, 07 Jun 2023 02:12:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d6083000000b0030abe7c36b1sm14722806wrt.93.2023.06.07.02.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:11:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Antonino Daplas <adaplas@gmail.com>
Subject: Re: [PATCH 20/30] fbdev/rivafb: Use hardware device as backlight
 parent
In-Reply-To: <20230605144812.15241-21-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-21-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:11:59 +0200
Message-ID: <87r0qneiw0.fsf@minerva.mail-host-address-is-not-set>
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
> Cc: Antonino Daplas <adaplas@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

