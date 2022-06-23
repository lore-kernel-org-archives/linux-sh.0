Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AE5C433EF
	for <linux-sh@archiver.kernel.org>; Thu, 23 Jun 2022 15:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiFWPfc (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiFWPfb (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 23 Jun 2022 11:35:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498432F035
        for <linux-sh@vger.kernel.org>; Thu, 23 Jun 2022 08:35:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso1701854wml.1
        for <linux-sh@vger.kernel.org>; Thu, 23 Jun 2022 08:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=CwUiQjxiKnD5n9/TwKt0ZRYsg9QRmrX5ICreA5WOZAc=;
        b=LB0H1owfhgrk9BYhuv24OlnT3SQ5d6kx4Jl25njZiYFhlrbet+dmWa12A1A6rCYd2p
         gledzXy8bNxIAVGsMp7P18+BrQugG20nNuWYbi0fxhV3bvDH+rHvMH5wE2y7I5sGLUH7
         yLTS9nn81t96jHg4gqVhEdxUPndz5xHj3wXtCJNuVUGa8HS/qNjL1F4O1jJLBeP3idcj
         +v3of0p3jo3CBp4nRApwE+7JafTHExUhIP9Pf87hMClgvVackfiXRFakCVmuz4XpM+yI
         ACojdFPRmVT/WdtS690SSXQZhEddothHejZLWJmoYxyjMW2DwfI18UDbfPHdbj2O9UcC
         NSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=CwUiQjxiKnD5n9/TwKt0ZRYsg9QRmrX5ICreA5WOZAc=;
        b=z2yGh3QQSRVCTv/E5j5Dr9gPXq7afDal5zQSgUpq2dBJoXmRR610Bv2/vfmVyMri5T
         Sh8/D8VMZzsOFDzJs6Kn6jSHKoqMYR/nH0g1ZbujWyutxq/+G7cGXekw/tCmtaKlzLOF
         KnJbBUHpCzCml8E1ZrzHF4XDzit6X91tEWQhHOemA9kJybMevOWnNw3KxkuixXqSOroV
         PwJAvl5iWA3Rz4P2O32u/h+j5VkoPrIkUhSVBy0m5Y4apc32mEE0LRUlqlS0DBvAD29b
         hKZffgRkyt8PoTNbkXkzf40YQnVkR1bc4tkTr/qh0ZOUuFfqD9dW8zFeNXmAfjdIubLa
         mTlw==
X-Gm-Message-State: AJIora/8BBtmWtND72VEG5wp0nO7ZB/ATeLKfY5tzebs0rswSZzWikFU
        Fm31h3cvwGh/GpTGSJ74/P9Pstxxz+w=
X-Google-Smtp-Source: AGRyM1u4vXYywNwlNuXAbNMeQ2Lam9E7QJIri8Cv93LZdu5vK0jXKeK94tX8fT04uAh1BZyam0WtrQ==
X-Received: by 2002:a05:600c:4ed2:b0:397:7493:53e6 with SMTP id g18-20020a05600c4ed200b00397749353e6mr4906937wmq.61.1655998528612;
        Thu, 23 Jun 2022 08:35:28 -0700 (PDT)
Received: from DESKTOP-DLIJ48C ([39.42.130.216])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d6206000000b0021350f7b22esm25546213wru.109.2022.06.23.08.35.27
        for <linux-sh@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2022 08:35:28 -0700 (PDT)
Message-ID: <62b48840.1c69fb81.f0534.1b18@mx.google.com>
Date:   Thu, 23 Jun 2022 08:35:28 -0700 (PDT)
X-Google-Original-Date: 23 Jun 2022 11:35:29 -0400
MIME-Version: 1.0
From:   scott.crosslandestimation@gmail.com
To:     linux-sh@vger.kernel.org
Subject: Quote To Bid
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0AScott March=0D=0ACrossland Estimating, INC=20

