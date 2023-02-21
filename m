Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2FC636D7
	for <linux-sh@archiver.kernel.org>; Tue, 21 Feb 2023 15:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjBUPAQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 21 Feb 2023 10:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjBUPAL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 21 Feb 2023 10:00:11 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6424A2B605
        for <linux-sh@vger.kernel.org>; Tue, 21 Feb 2023 07:00:10 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id p3-20020a05600c358300b003e206711347so3283138wmq.0
        for <linux-sh@vger.kernel.org>; Tue, 21 Feb 2023 07:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8YvNBhOfpRjHTDjgku2It2uP7e9HWXGEEJXRoHvZp2s=;
        b=ppQQ5Hx0/V7r9LtSjJ5JEbD6vLdUUXrIpUDUSTsO9DeBq9zHUk1USfWoQRNx25eGMi
         AOSguOlG6r3J5HgfELCzA2RF+9bxKDvG+nODIaOLigEIn9gnrGZ1ZLi3agyxImfBnxFw
         /Qdd7T5Lz/N32sbTdOw4pP3qIiD8At3xACUO9AMLjzfPCZKDbBlVwbQRCqMbgdyaAQE6
         5H2Svz+mbT4u0mfrzq90X/uyj/oG9KN12rrQuOj2+hrU0zgWsvWW55zPjYugSHl1idza
         ijtsrUE6u/zxROMn92l5cjn9l4A7qTNCQBOdqwhZRXXonvbjzcASps5fp3QvDJMG2D3G
         CnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YvNBhOfpRjHTDjgku2It2uP7e9HWXGEEJXRoHvZp2s=;
        b=VFAkcSkqRuH3E+IV7nZPP9+5HVB7aQjVebBhle5BPaFOoTuDL3PHnTDPhclhh3mTIk
         LImyjvis+/xrg1RQQtx4qhG136a0bEqamgufCEyuaA69G5UZuEqjCqRz2J8FUwmmPQ0E
         VCWC/y3nQyVgqXZrREf7KOXbNsj3sSOn9DD8Q8BD4XPJG7Co5IxBZzhIZOkVBZFJSiL+
         wpLI58VXeUa43kdrTk2/ayQzfPByhim4W/Hg/xc8ILd4NAH4tGJx+DSjwnWhz64y3HQr
         wF/h7deM+OXSGzV1KEhR3GCYHCEg0YOGx4TpvlTdz0hcIgZh5+Q2ZE9Ed78uv0odcXHb
         bp9Q==
X-Gm-Message-State: AO0yUKW+fCYEAczWZUZVRYBs23N2MwRJWwGV8PywT46NS5cL/UwXRTY2
        p0oKpnEZQNI29ozLHx0ArjzyZurO6Xc=
X-Google-Smtp-Source: AK7set+bJj6jTqQR8cvtxys68wOdISi6fYIJIcAiwXNItpXvaF9JZTxBas2bINiqkDPOSEIiNgbtcA==
X-Received: by 2002:a05:600c:80f:b0:3dc:5d34:dbe5 with SMTP id k15-20020a05600c080f00b003dc5d34dbe5mr3193691wmp.28.1676991608708;
        Tue, 21 Feb 2023 07:00:08 -0800 (PST)
Received: from DESKTOP-L1U6HLH ([39.42.138.70])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003e21f01c426sm4247131wmn.9.2023.02.21.07.00.07
        for <linux-sh@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 21 Feb 2023 07:00:08 -0800 (PST)
Message-ID: <63f4dc78.050a0220.7e631.d5d5@mx.google.com>
Date:   Tue, 21 Feb 2023 07:00:08 -0800 (PST)
X-Google-Original-Date: 21 Feb 2023 10:00:09 -0500
MIME-Version: 1.0
From:   shelbyhildreth897@gmail.com
To:     linux-sh@vger.kernel.org
Subject: Building Estimates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi,=0D=0A=0D=0AIn case you really want take-offs for a developmen=
t project, we ought to be your consultancy of decision. Reach out=
 to us assuming that you have any undertakings for departure whic=
h could utilize our administrations.=0D=0A=0D=0ASend over the pla=
ns and notice the exact extent of work you need us to assess.=0D=0A=
We will hit you up with a statement on our administration charges=
 and turnaround time.=0D=0AIn case you endorse that individual st=
atement then we will continue further with the gauge.=0D=0A=0D=0A=
For a superior comprehension of our work, go ahead and ask us que=
stions .=0D=0A=0D=0AKind Regards=0D=0AShelby Hildreth		=0D=0ADrea=
mland Estimation, LLC

