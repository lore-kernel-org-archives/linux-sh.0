Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851EAC83003
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 07:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjFGH4b (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFGH4a (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 03:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC611D
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 00:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686124541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzwKDEeExwlnpVxIio+gh6QukNcWAFoM0lG5LiuVXys=;
        b=NYTp4JT0JmKpWLMmj6eqiDZJdcuVXe76V5Q3c8naTIibqabGqxh6qFH8juaafcA1S2YdSv
        u+Prb4ECQZKmlQOUkY8SzqV/nPWAk/K84Xf3ywznbEflTTaiJYDd8Lbz/noOYjalnq784/
        IcOUe/2/LClzFg4N5Jw+Ps4nx0TiM8k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-1bR-zDpiMqiDuXbTL89YCQ-1; Wed, 07 Jun 2023 03:55:40 -0400
X-MC-Unique: 1bR-zDpiMqiDuXbTL89YCQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f73283f6c7so1450825e9.1
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 00:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686124539; x=1688716539;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzwKDEeExwlnpVxIio+gh6QukNcWAFoM0lG5LiuVXys=;
        b=YxDmjH9LqKUideZiRLs9stcMBeBh4ig1NmvsIAquNY8WB4T4G0Vy+ffvm3ZWUb7i5d
         JHGp3h8EjZ0JXz9ivStprRM4tgYocCMCp3d/dOS9QSiKwkkPrVBlD2bE+Swx7dEBgL4r
         QpnCwyuMHQ3zRfzUqF3+PnntOE+7+I0FIQwBzAySQRmbBmIcDq22jUkiziJ8mJJfz01x
         odA8ghBJM7+tM1apCo1V1bn4SQWfo//T31I4KmdXPW+Dih8wbviD5ZS5yr8WOTJyVZEt
         Bf4AFUi7kAO+ZOiBMD8O6QS2Qcj5dhYV7bTBM5Py3UeHcgErtz1UfA5DqLf4LcgHKMK5
         vfBA==
X-Gm-Message-State: AC+VfDy0Uvwwx1x92benNBJ/UQfxof7oOO1Try040k+YseZZwFRWHewD
        6+hEzY2OnedE3mptx2o1Dr2DiR8TmRP/aLx5Ak+nWT15YB5/1ELqMzDWm4ffdWTvfBW14BpsK7p
        U5/2Iyhb1QGigdI9cL60=
X-Received: by 2002:a05:600c:b89:b0:3f7:3284:4e51 with SMTP id fl9-20020a05600c0b8900b003f732844e51mr8903482wmb.4.1686124539607;
        Wed, 07 Jun 2023 00:55:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XsE1MIBLkrKPsF0to0MXFrankIK5l3IfIsZWE8tI4gRDcEz1ZX1KmYbQPpdwp7XOKQIbPMQ==
X-Received: by 2002:a05:600c:b89:b0:3f7:3284:4e51 with SMTP id fl9-20020a05600c0b8900b003f732844e51mr8903472wmb.4.1686124539336;
        Wed, 07 Jun 2023 00:55:39 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id j27-20020a05600c1c1b00b003f4283f5c1bsm6978981wms.2.2023.06.07.00.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:55:39 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 08/30] fbdev/broadsheetfb: Call device_remove_file()
 with hardware device
In-Reply-To: <20230605144812.15241-9-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-9-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:55:37 +0200
Message-ID: <87r0qng0zq.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Call device_remove_file() with the same device that has been used
> for device_create_file(), which is the hardware device stored in
> struct fb_info.device. Prepares fbdev for making struct fb_info.dev
> optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

