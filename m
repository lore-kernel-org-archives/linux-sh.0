From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 31 May 2015 23:30:01 +0000
Subject: Re: [PATCH 4/4] i2c: slave: add error messages to slave core
Message-Id: <20150531233000.GB17187@katana>
List-Id: <linux-sh.vger.kernel.org>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
 <1431607205-2316-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1431607205-2316-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Peter Huewe <peterhuewe@gmx.de>

> -	if (!client || !slave_cb)
> +	if (!client || !slave_cb) {
> +		dev_err(&client->dev, "%s: insufficent data\n", __func__);

Replaced this with WARN. Using client->dev after potential !client is bad.

