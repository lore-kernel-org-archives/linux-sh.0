Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8FBC77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 22:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFGWZY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjFGWZX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 18:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04EA2684
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 15:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686176567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67Wr4HmC8kXtCL1x0dOeckxppNMmBntLK5uulGf1sqg=;
        b=K9VAbmiHShuwfsyDQrJvd+WZHm1rDaFrCct+LFfVotFYKW8e5kujZTVjxIuq7hkvPNgEOx
        ZEsfpCix2dyS3LvdpesA1MARhlEB8q5erMjOYYKjLjpam2FOOzXbQ7puVqSkOcu43yigVP
        aIHoP91l4IdrkC1Mjo4A3ShqyziWkQ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-e6KWIvm3NeGAKEbw8CUutg-1; Wed, 07 Jun 2023 18:22:46 -0400
X-MC-Unique: e6KWIvm3NeGAKEbw8CUutg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f603fed174so45030865e9.2
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 15:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176565; x=1688768565;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67Wr4HmC8kXtCL1x0dOeckxppNMmBntLK5uulGf1sqg=;
        b=eVY37EhE1APeqoPCLuQEGMPQBueAEcyCLat4TLkgmVrPkrCXeH8lKcIIJRwSYb3h8C
         Fv1sJfQv4UqDWJiFZbE3t9bDnOjqOjtmHfD27V0X52fMynalLGUXfO2xDsbnAcXg9AGB
         YON81YolbIHiLcHBKlcUDpH86wciPb7gvrnZNDvlhEEAcYGdxAZXOJAiBnaaUvRvE9RO
         hsWjVLrJMPhr65M6mF510xC4soKWvqPsCgk6mTDwzQsWQG0x5GQKFVCeBGdirR8GxwRB
         oYlqRnDH3St1MQD2dx9lFu/BLLbzVSyq2WLHtUE+/81uApYGbtHzmGXl0QguM5mwhwFs
         /bKA==
X-Gm-Message-State: AC+VfDzlfyQxcTYyjuSReFFUM0TYcIGMcaK9kiCShW3oAG/rbp+ykQjj
        DWg5dxkQVacO8SoD3zF2yI+8wxuL9KjKWvQblz2c/AA/DxNKcVKDpdvhIgxpfMipxgGjmewINZZ
        FDiW3S1pATEsECWIvC4w=
X-Received: by 2002:a1c:4c11:0:b0:3f7:26f8:4cd0 with SMTP id z17-20020a1c4c11000000b003f726f84cd0mr5570495wmf.16.1686176564941;
        Wed, 07 Jun 2023 15:22:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74+KkyeYoTNHdtFgdPjs/ko5gB/9QwThWFkjR0/oU0p3+M7MfNC36MRsPeTiM50kMg9GLwXA==
X-Received: by 2002:a1c:4c11:0:b0:3f7:26f8:4cd0 with SMTP id z17-20020a1c4c11000000b003f726f84cd0mr5570479wmf.16.1686176564616;
        Wed, 07 Jun 2023 15:22:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v6-20020a7bcb46000000b003f6028a4c85sm3342086wmj.16.2023.06.07.15.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 15:22:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Steve Glendinning <steve.glendinning@shawell.net>
Subject: Re: [PATCH 22/30] fbdev/smscufx: Detect registered fb_info from
 refcount
In-Reply-To: <20230605144812.15241-23-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-23-tzimmermann@suse.de>
Date:   Thu, 08 Jun 2023 00:22:43 +0200
Message-ID: <87edmmewuk.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Detect registered instances of fb_info by reading the reference
> counter from struct fb_info.read. Avoids looking at the dev field
> and prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Steve Glendinning <steve.glendinning@shawell.net>
> ---
>  drivers/video/fbdev/smscufx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
> index 17cec62cc65d..adb2b1fe8383 100644
> --- a/drivers/video/fbdev/smscufx.c
> +++ b/drivers/video/fbdev/smscufx.c
> @@ -1496,7 +1496,7 @@ static int ufx_setup_modes(struct ufx_data *dev, struct fb_info *info,
>  	u8 *edid;
>  	int i, result = 0, tries = 3;
>  
> -	if (info->dev) /* only use mutex if info has been registered */
> +	if (refcount_read(&info->count)) /* only use mutex if info has been registered */

The struct fb_info .count refcount is protected by the registration_lock
mutex in register_framebuffer(). I think this operation isn't thread safe ?

But that was also the case for info->dev check, so I guess is OK and this
change is for an old fbdev driver anyways.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

