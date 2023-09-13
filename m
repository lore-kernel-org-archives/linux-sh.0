Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B2FCA5534
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbjIMKqG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjIMKqG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:46:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B52D19AC
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 03:46:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FBCC433C7;
        Wed, 13 Sep 2023 10:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694601961;
        bh=y7BI88ZGuKwwwwVYiVblv3EuRN/fOgGx/DQbWSsWFsY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DNtC1SHy0F6svrOJHPZcTGtpxV4oZ+qvJD/V0TMMsABRL0touG/DuzBctXpR9aS0o
         gfSVrvFKeUwHx2XAgyV6FbERCU/aZ2PZmiGY1ZpbPuymgkmkPdKykdVa7Axc72yRjd
         9IOpZianiSSTFoZ2sYv9YTh9zPSpV+yDuW7JQWderv1W26MHQBMPV/axXlqODY8Y9U
         S4LgrVDxXYzoLdhCsza6l2DNp9DeLbSeiUHrffWZVq6Xxhi5gYwANjnFvxHIVSxfuS
         7EXmKN9W7kB12BZgGk0Chptqyt5fMzfPAYE2RzY+wHwCXoy3sAi+nmqisPfVzYCHm9
         nHfNH2tJmhxRQ==
Message-ID: <17263ff7-f25c-9a99-4e47-afb9b5734848@kernel.org>
Date:   Wed, 13 Sep 2023 12:45:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 21/30] Documentation/devicetree: sm501fb add
 properies.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <e32063a36916d84c88dacfbaaf345418d0028d18.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <e32063a36916d84c88dacfbaaf345418d0028d18.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> SM501's OF support is not enough parameter in platform device.
> This change adds the missing parameter.
> 

NAK, nothing improved here.

Best regards,
Krzysztof

