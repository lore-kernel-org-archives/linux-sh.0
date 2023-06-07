Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE9C7EE23
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbjFGJDJ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239480AbjFGJCs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB826A3
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ha3iiTWVECujH5I3jqgNS4AW7y6robxFbsBFSl574Yk=;
        b=b2LaasDOJxzNbDHtge8wwTaNs4Jyf4wnrlr3p+Bapq08xrheQyFspuw6sNIQRGKACNRBk2
        9QTSrf3ahnxFuANMnEmvEtot1QI/CmuO6+Pww7PWh7HQhwn4WEDU40Q4rI6WpmAWkfv8Ni
        C9nbkgxrpzy6X80S8QaSfxE4Y92r37w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-BmFOPoTSMIey_M-Ge5z19Q-1; Wed, 07 Jun 2023 05:00:21 -0400
X-MC-Unique: BmFOPoTSMIey_M-Ge5z19Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30af779d6e6so3223404f8f.3
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128420; x=1688720420;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha3iiTWVECujH5I3jqgNS4AW7y6robxFbsBFSl574Yk=;
        b=EbfNiHLHM7pJrxc53PKUiI9DNaZsQCSWPpzYtpEjZE8Zwlywo92Xnhfts9/N+rM6FN
         oDD2oKJ+22A/fHwsZlYsiOXhjq/NBzrPCGzFMhU3gPrBZHXgKqCqEG1yTVKydkFq0UQk
         kv+u8M+ezAkeIlMYHxTL1THyKH//8mkw9sun19MFcLYo93g7A1c/q/6ojZIhdNP8q7zg
         iKQMBZqmFMisgH3pYPDdtJNLCFY+hxPhy4EW8jfoQRXINNZ1RCEfirslPKKZa1WtLPGv
         YeD7XPAtOOGpvdmWonV22ojj94jm4ioBrL9Bz0S3iRJgfu3ORxn67HKzNcwY/iMjINmm
         G1Ug==
X-Gm-Message-State: AC+VfDzpmsl7Ing9y1JyGfquPKbx5TxERlUAUx+PIvilm4Km/Hvv9AQ+
        zGgb2neprfALUzSdOeeF7qHTLzq3iFADLs8Sufj7cRtXGzuniR20ShpzPYm/peupvtlyN2RuqSv
        CmbUuyj+j5c+Gq4r9fdw=
X-Received: by 2002:a05:6000:503:b0:2ef:ba4f:c821 with SMTP id a3-20020a056000050300b002efba4fc821mr3492625wrf.36.1686128420032;
        Wed, 07 Jun 2023 02:00:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6K7G3bt0VUByq7FRT2lQ5ZRsRDVTyfbQ/GNM/0/foGN7SQ7frEuHnXH19X2JYBcLKX3c3pJQ==
X-Received: by 2002:a05:6000:503:b0:2ef:ba4f:c821 with SMTP id a3-20020a056000050300b002efba4fc821mr3492608wrf.36.1686128419772;
        Wed, 07 Jun 2023 02:00:19 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d594c000000b0030ae16132besm14801751wri.12.2023.06.07.02.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:00:19 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 11/30] fbdev/ep93xx-fb: Do not assign to struct fb_info.dev
In-Reply-To: <20230605144812.15241-12-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-12-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:00:18 +0200
Message-ID: <87ilbzfxzx.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Do not assing the Linux device to struct fb_info.dev. The call to
> register_framebuffer() initializes the field to the fbdev device.
> Drivers should not override its value.
>
> Fixes a bug where the driver incorrectly decreases the hardware
> device's reference counter and leaks the fbdev device.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

