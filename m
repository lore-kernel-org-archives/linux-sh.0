Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B0CC63797
	for <linux-sh@archiver.kernel.org>; Tue, 17 Jan 2023 13:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAQNtW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 17 Jan 2023 08:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjAQNs4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 17 Jan 2023 08:48:56 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5B3B645
        for <linux-sh@vger.kernel.org>; Tue, 17 Jan 2023 05:48:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g10so22288108wmo.1
        for <linux-sh@vger.kernel.org>; Tue, 17 Jan 2023 05:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N5tYXkNIS3jTV4edAWNOmiWisVq7nS7J1ZgQE1Xv1vQ=;
        b=bwhFdkEQwet/d/XQjxuoYHp/F7r5R2kyBT9OC5rCXZkpPl3193oACMzehe+fEctyTv
         8hX+CIqKdLb5XogxhwswcDn2cVQm8GN4oXGGhDEC5juDzdOMYVcgILOtysK4APGKdIT3
         HEdXiiN74jgKCahl7xlhzXWsjGnlMmOIS8GHV0N8mH2hMqIuLc3zlZP9545GHRy/bCbe
         asR+vzUsx2/8Ks0Re2n7TFMjs/HNvmHiiAu1eC7qdzdxWu+MIL/54qwJhpaWfYvOXP5W
         nY3Z/cpZxnF3mrxVBsP3Or66XPWHCKK5yY96qXVHAykrxBdw4eO8G1YCsfoiH3rwxNpk
         skbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5tYXkNIS3jTV4edAWNOmiWisVq7nS7J1ZgQE1Xv1vQ=;
        b=fOzAPKG98e2i+UzzdtF7GIZoMwnGMc7AyjCb5xAaBejSwHjC5VmMvPxy4LPn0EAUZ4
         9dbd348hvz7MJaH3/JSeR1D0FIJrmPKYG4+bEvKLaQ3Fu2eBjALStqTmQEZMB1nctv4C
         PX2jbscJ4YlmnTovDS/ffXJoeZGrUN25jfv0edpypUEZSZJxYpMwSZPv9eM6UvBmT//G
         YmqIFSMcQQzzWxwaGOZjedACNcG/rwMm55LbmfCECUbwLqJvFKbKmOCb40VqO26u8JS1
         cmaLm+O110OrVT38Hh+UKjKDn9XMMsUq9jmHB0bJvN0teAi0f1AsWF2zaX4lESV0CsFb
         tApw==
X-Gm-Message-State: AFqh2kr7N13HIZy/+3l/765/bcMUlAVf8E+jhK8eej2AKUHAYWf3ckF+
        0Gfx/Kms7H4H3VLwznMP6dArnFeEVG4=
X-Google-Smtp-Source: AMrXdXt3Dn4BPwUQfC4vizZF+dH/5guUjLKZpZgQakbBokwid7Ty2uKkAbJTeapTpdw/VQ1976YewQ==
X-Received: by 2002:a05:600c:1e08:b0:3da:f443:9f0f with SMTP id ay8-20020a05600c1e0800b003daf4439f0fmr3142638wmb.18.1673963332480;
        Tue, 17 Jan 2023 05:48:52 -0800 (PST)
Received: from DESKTOP-53HLT22 ([39.42.178.198])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003d974076f13sm39565130wmo.3.2023.01.17.05.48.51
        for <linux-sh@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 17 Jan 2023 05:48:51 -0800 (PST)
Message-ID: <63c6a743.050a0220.1e30f.cb35@mx.google.com>
Date:   Tue, 17 Jan 2023 05:48:51 -0800 (PST)
X-Google-Original-Date: 17 Jan 2023 08:50:27 -0500
MIME-Version: 1.0
From:   erickshelton4398@gmail.com
To:     linux-sh@vger.kernel.org
Subject: Any Drawings for Estimate?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

=0D=0AHi,=0D=0A=0D=0ADo you have any estimating projects for us=0D=0A=
=0D=0AIf you are holding a project, please send over the plans in=
 PDF format for getting a firm quote on your project.=0D=0A=0D=0A=
Let me know if you have any questions or if you would like to see=
 some samples.=0D=0A=0D=0AWe will be happy to answer any question=
s you have. Thank you=0D=0A=0D=0ARegards,=0D=0AErick Shelton=0D=0A=
Crossland Estimation, INC

