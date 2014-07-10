From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Jul 2014 10:03:12 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Lager: Correct I2C bus for VDD MPU regulator
Message-Id: <CANqRtoTu6zO60YTXBM9F-j2z-CckZebzLS3UemS=BiRzK+k=Og@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53B5F327.5040301@renesas.com>
In-Reply-To: <53B5F327.5040301@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Khiem-san,

On Thu, Jul 10, 2014 at 12:01 PM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> On 7/10/2014 6:46 PM, Magnus Damm wrote:
>> Hi Wolfram, Khiem-san, everyone,
>>
>> On Thu, Jul 10, 2014 at 11:40 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>>>
>>>> Wolfram, can you give us your opinion about this patch? Does it
>>>> improve our I2C software support on Lager?
>>>
>>> Yes, it does. Khiem-san is right, IIC3 is dedicated to DVFS, so it
>>> should be activated. From that point of view:
>>>
>>> Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>
>>
>> Good - thanks for confirming!
> @Wolfram-san: Thanks for your review.
>
> @Magnus-san, Simon-san: Then, is it OK to merge this patch ?

Yes, from my side all is fine. I believe Simon will merge it when he
has some time to spare.

Cheers,

/ magnus
