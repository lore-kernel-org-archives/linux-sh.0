From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 08:52:19 +0000
Subject: Re: [PATCH] gpio: em: Make use of devm functions
Message-Id: <CANqRtoSvfsVUjnN1rH83-sRNdiJYthN0C7TTjhdCsowOP5Ybtw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130313110630.30040.20743.sendpatchset@w520>
	<CACRpkdYjWOk---EwS1mQfKbSskxAvV=RbephQxJhg5r44UQQQg@mail.gmail.com>
In-Reply-To: <CACRpkdYjWOk---EwS1mQfKbSskxAvV=RbephQxJhg5r44UQQQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, horms@verge.net.au, linux-sh@vger.kernel.org

Hi Linus,

On Wed, Mar 27, 2013 at 5:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Mar 13, 2013 at 12:06 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> From: Magnus Damm <damm@opensource.se>
>>
>> Update the Emma Mobile GPIO driver to make use of devm
>> functions. This simplifies the error handling and makes
>> the code more compact.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>>  Written on top of:
>>  [PATCH] gpio: em: Add Device Tree support
>
> Patch applied, hm git am complains that the patch is broken
> on line 137, then when I use patch -p1 < magnus.patch
> everything works fine. Weird.

Yes, indeed a bit weird. I actually tested the code about an hour ago,
but I used patch then.

Thanks for your help!

/ magnus
