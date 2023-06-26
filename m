Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0CAEB64D7
	for <linux-sh@archiver.kernel.org>; Mon, 26 Jun 2023 12:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjFZM3K (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 26 Jun 2023 08:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjFZM2w (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 26 Jun 2023 08:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA4294D
        for <linux-sh@vger.kernel.org>; Mon, 26 Jun 2023 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687782433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7A4QtIPQ46OJKI9lflLzm3DTzPmnZrWIQG2/OeQ3hc=;
        b=ZOlgo35hKGBCoOJze6GQ03Sgcxnp+jGHJbd5I9qDAsLaqxfpy6bdNRK3pxW0NNQxywDccT
        l7flhFZsLdQunVs1C23F7OtKG05J/6S71Kbbw6TWw/pBDndhwWOCh/9m8G2Lca3ZY9G+0P
        EzuNUqUQyxQUU41/uc+0k0RvBmu8FCU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-UiRQ924QM3usGwuJdYfEyw-1; Mon, 26 Jun 2023 08:27:12 -0400
X-MC-Unique: UiRQ924QM3usGwuJdYfEyw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30932d15a30so2456539f8f.1
        for <linux-sh@vger.kernel.org>; Mon, 26 Jun 2023 05:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687782431; x=1690374431;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7A4QtIPQ46OJKI9lflLzm3DTzPmnZrWIQG2/OeQ3hc=;
        b=ZuyKbiIcckxUMfFW+FjbnIZwe1H+O6Cn+o3j51MGSYSo6dcuvo22Nn7M39Mo8cqfgr
         gBw7dKRnX3F8e8k24OqvC3caDtqzeqhKPAoBOXBF1VSaEKkEklH2yvs2LpebfD5EEoG0
         Yo/m/mlJocSyWtJb6091vCNSjPZy5yuT+Dhe8T/zmxbdq7LNZ4M2bs0HEw9yaBCRMucQ
         S5npuJJNJ/M7V7XdNCtx5QUj412PYqJk6KwgNJxAt1UJn5NufLdlSQ1KnfowSjXNfcJ4
         FetyicLrR2fh0jESxVOVX4xzbcmcEaY262wDbbzz2StsYJUbXa9uoP8zpASQM2DoV/RT
         U5QA==
X-Gm-Message-State: AC+VfDyKSGxXXdSFqy24f0Y9HPBNVVzeCxUhe9AZ4z8cMdUpr6QPL3YW
        yfi1vPwWgFLc/br2bmFdI0spcdiLsqitiZDhLwk6+M5XYSbd3/Am+r2vJPgOfMmYdrq8Hi2HlS0
        UWaopHZSWEWH6pCoi1zM=
X-Received: by 2002:adf:e98b:0:b0:30f:befc:d864 with SMTP id h11-20020adfe98b000000b0030fbefcd864mr25143869wrm.62.1687782431247;
        Mon, 26 Jun 2023 05:27:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5s+xo+3GocfRAN2ddT936OL6TbSjlftKvOe/WQg4sXaYYvHxhA/vC/T+Q/4yNgIvb7WBFVgw==
X-Received: by 2002:adf:e98b:0:b0:30f:befc:d864 with SMTP id h11-20020adfe98b000000b0030fbefcd864mr25143851wrm.62.1687782430944;
        Mon, 26 Jun 2023 05:27:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b00313f07ccca4sm3108010wrw.117.2023.06.26.05.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:27:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 27/38] fbdev/sh7760fb: Alloc DMA memory from hardware
 device
In-Reply-To: <20230613110953.24176-28-tzimmermann@suse.de>
References: <20230613110953.24176-1-tzimmermann@suse.de>
 <20230613110953.24176-28-tzimmermann@suse.de>
Date:   Mon, 26 Jun 2023 14:27:09 +0200
Message-ID: <87sfaeh0iq.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Pass the hardware device to the DMA helpers dma_alloc_coherent() and
> dma_free_coherent(). The fbdev device that is currently being used is
> a software device and does not provide DMA memory. Also update the
> related dev_*() output statements similarly.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

