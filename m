Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7177CC87FDC
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 07:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbjFGHp7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbjFGHpU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 03:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F2F106
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrMzVIVwuoeUQwH5hpliW2Jq51XgxuMBmmo9TGjEBeo=;
        b=FQCe+/OH1ZqNiNJQ4vcXRyDmze3i3CGLJ2b36KKt0SFbPSWRDbAtKxgU33Mm/3TGZhva5e
        sx7p+amBr3v1vqT+ncV0CS3NPYNbDWNXyN2hHqoHRrI4dw5uo5rUpfhE3CbxdScs+KvHfP
        WYiCWEyx2qYiU9MgQ23GlhhcVemGpYg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-nIgqvMPlPSeMqKR1ecXaTg-1; Wed, 07 Jun 2023 03:41:48 -0400
X-MC-Unique: nIgqvMPlPSeMqKR1ecXaTg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30e4d11a413so145771f8f.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 00:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123707; x=1688715707;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrMzVIVwuoeUQwH5hpliW2Jq51XgxuMBmmo9TGjEBeo=;
        b=GCl41ZMkcunhO4K+1Mv9TOok2UXQFKlaziNdQQXxJklEW8ekKz1K0FP+8My9TxDiJS
         gc/eTDhhhfNU0efGMct0GWA7Ck9Ll5xSgdH4wB6Z+FjP2A/sRD4/7gKC+MLmda0+KHmc
         fyvbQPp0ZHOh7cwW++cDw7O9WbO+gOsmTfFQWegRgEgKg2d6u6umjfi2iiwjACHaX/J3
         vSDK3MTtDdyWge/AOLUCs0oaVIGVdFQ26eRd/zigCaq5ZKNoNgk4X+msAmUbTdYkaaxb
         TAtwO1YBIIvhh/iE6GdVbqKygX6+BRoKH6sDo0YwOhWtto4E5t/7GncZzg2W7bB4mxff
         HSbw==
X-Gm-Message-State: AC+VfDyQdmfjgg4K7XlGUtfpkICfMC7lQ8mDb8T/d3BUNBiwomJJiLsR
        l2bP0YBXFnUUzNJriIepY+yKbdyR5janyBi2KaBTNCxKgORHItUrRENfIhnZuMiHYfJFKjzitz5
        2+VRwD243HC3Dx9YdsKM=
X-Received: by 2002:a5d:4ece:0:b0:306:2713:f7f with SMTP id s14-20020a5d4ece000000b0030627130f7fmr10418240wrv.11.1686123706977;
        Wed, 07 Jun 2023 00:41:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Zd2a468z/A2yXcthK/MVOYuYJ+/wr3Irr4l7Jvn6olRO9xiMCz+lyONSCQCChNdNZRPbF/A==
X-Received: by 2002:a5d:4ece:0:b0:306:2713:f7f with SMTP id s14-20020a5d4ece000000b0030627130f7fmr10418221wrv.11.1686123706744;
        Wed, 07 Jun 2023 00:41:46 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bc8d1000000b003f7e6d7f71esm1156174wml.36.2023.06.07.00.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:41:46 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 05/30] fbdev/atyfb: Use hardware device as backlight parent
In-Reply-To: <20230605144812.15241-6-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-6-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:41:45 +0200
Message-ID: <87zg5bg1mu.fsf@minerva.mail-host-address-is-not-set>
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
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

