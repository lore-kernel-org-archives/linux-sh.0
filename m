Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A9C7EE43
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 07:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbjFGHhT (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbjFGHg2 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 03:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F65D1BDC
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 00:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4kkmKCd2wl5ncm7VdRIyhpSQ8IQY2Nc27kZwe+CQ6o=;
        b=Lj5RLNiP0T6JzaPAo6qgrlLTrzKbWlJoDCDzeelUo0aC9pzhCMuRP0uxd7UpKUAbVvvVuf
        FjCJmsjtHwNmn1c6ItKJv6ORsECn764ku6CbEFGn1grYCd533yhGC/jOVA0JBXSaprRYhq
        guKLnabYAoI4Jz3Or4x2CSHnHVzdZ9w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-zbusdNwNPxGSl3r_doHFqA-1; Wed, 07 Jun 2023 03:34:16 -0400
X-MC-Unique: zbusdNwNPxGSl3r_doHFqA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30e3fb5d1a4so1497874f8f.3
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 00:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123255; x=1688715255;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/4kkmKCd2wl5ncm7VdRIyhpSQ8IQY2Nc27kZwe+CQ6o=;
        b=cAZFuobMlcBSF+JuVhRT4nl/NZJJQx4ouQSRlwh4i6YFljFL/gfJ5WPF+M44iRBuZM
         YJ7eEXdaDQclUbHhXvRlgRxHojalfDMN88/DndyMSOp8jOCfImdZjHZFKKsKQo3eyGH6
         J0d5zYve3/gTDW0pkBrKtUJDe4+Bm0w35KCN27H4mVb01rUP6+GVrI7x+tsUOAekyQkK
         4S70wzsndShGeW0ROiJEy1IJCxFfptNlUKV4KxasHLxpSqJ7asKPyKPjvEWL3yYUGInW
         i1AeiWq4dsL3eLmepZYkDkwrCFYlHxz9yB9826+IPqQrmtLVFZtoviST/ksEB8Kvh1kL
         4MoQ==
X-Gm-Message-State: AC+VfDzrdHaE9wBRKrRoUpQSpYuOckQKnaPYS8ruFbKRH0kTnhcyxXbI
        Csg7HFjWgq1WfVk9uPhARPYJxv5gemZlig1RQ8woogCw1CIvTmOMmeSxpcZjoHOGxcVnvpzcN+L
        XlgUaC2II7YQYa1zyKow=
X-Received: by 2002:adf:de92:0:b0:2ef:bada:2f25 with SMTP id w18-20020adfde92000000b002efbada2f25mr3634436wrl.67.1686123255196;
        Wed, 07 Jun 2023 00:34:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5kwgjMr0fDuyCE+y4fhZTqJkSHNU6+Lw9lBuHow6MJ+hyLq4N+EQ2nCyTNeqeilySEFyk4bw==
X-Received: by 2002:adf:de92:0:b0:2ef:bada:2f25 with SMTP id w18-20020adfde92000000b002efbada2f25mr3634421wrl.67.1686123254876;
        Wed, 07 Jun 2023 00:34:14 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c028300b003f7eeec829asm1180357wmk.10.2023.06.07.00.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:34:14 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 01/30] backlight/bd6107: Compare against struct
 fb_info.device
In-Reply-To: <20230605144812.15241-2-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-2-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:34:14 +0200
Message-ID: <878rcvhgjt.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Struct bd6107_platform_data refers to a platform device within
> the Linux device hierarchy. The test in bd6107_backlight_check_fb()
> compares it against the fbdev device in struct fb_info.dev, which
> is different. Fix the test by comparing to struct fb_info.device.
>
> Fixes a bug in the backlight driver and prepares fbdev for making
> struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> ---

I agree with what was discussed in this thread, the check fix and rename
could be split in separate patches to make it easier to understand what
is changed. Regardless, feel free to add:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

