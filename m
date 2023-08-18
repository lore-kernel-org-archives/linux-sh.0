Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48321C7112B
	for <linux-sh@archiver.kernel.org>; Fri, 18 Aug 2023 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358785AbjHRIz5 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 18 Aug 2023 04:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358783AbjHRIzy (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 18 Aug 2023 04:55:54 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 01:55:50 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5800C30F5
        for <linux-sh@vger.kernel.org>; Fri, 18 Aug 2023 01:55:50 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id 8769584948; Fri, 18 Aug 2023 09:16:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346644; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=orcArxhMX1sx0IUh+rU+hd0993VdCwHlzZYnLytbI7XShjTP0NffXCf1zKpnnQays
         ge0bTZMGqmPKTRZ4lrf8EotkatvtgdnqZEGDLEAps7FFYe3XPQtBKYE6ntaAT8PUmo
         olyBLP7zbx+kzJqGNqaqvDsVIJdhMMybn+EH2Z/90fCJnCMBOJb97KdzUK32l5WxQh
         ALgtCSY1FhqxZBskRkg9WD10UnaSvnDRXslnzXOCqvQSAc9SfQNoYGzjzC/3dr3V2U
         gUsDyzKO4P697YDr5qErRD09MByMm/VsX+UEPeBUy4vtB9WopXG15VztIwtDf4cBI/
         +WmmvGnypsFlg==
Received: by mail.leachkin.pl for <linux-sh@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.curd.0.ey3hjudm0f@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-sh@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
