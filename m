From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Tue, 26 Jan 2016 06:12:43 +0000
Subject: Re: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <56A70E5B.6060008@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On 25.01.2016 20:24, Wolfram Sang wrote:
>
>> I've been thinking about implementing a "delay callback", which waits for
>> bit 13 on previous SoCs and for bit 14 for r8a7795.
>
> Does it make a difference for you? I thought it didn't?


Well, if the manual tells us to use CBSY (bit 14), I think it's a good 
idea to do so and not to use anything else.

Best regards

Dirk
