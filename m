From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Sun, 13 Jul 2014 23:19:06 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <53C313EA.1000502@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53B5F327.5040301@renesas.com>
In-Reply-To: <53B5F327.5040301@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dear Simon-san,

On 7/11/2014 5:45 PM, Simon Horman wrote:

>>>>>> Wolfram, can you give us your opinion about this patch? Does it
>>>>>> improve our I2C software support on Lager?

>>>>> Yes, it does. Khiem-san is right, IIC3 is dedicated to DVFS, so it
>>>>> should be activated. From that point of view:

>>>>> Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>

> 
> Thanks, I have queued this up with Wolfram's Reviewed-by tag.
>

Thanks. I got it.

-- 
Best regards,
KHIEM Nguyen
