From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jun 2013 07:26:03 +0000
Subject: Re: [PATCH 01/15] ARM: shmobile: Per-board uImage load addresses
Message-Id: <CANqRtoTHLvZ8mTGRFb88y8G3DS=d9Sw9Um6gg_66UiwSvmorZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130605070616.13311.69049.sendpatchset@w520>
 <20130605070625.13311.17016.sendpatchset@w520>
 <9933530.s16G7h846I@wuerfel>
In-Reply-To: <9933530.s16G7h846I@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Wed, Jun 5, 2013 at 5:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 05 June 2013 16:06:25 Magnus Damm wrote:
>>
>> +__ZRELADDR     := $(shell /bin/bash -c \
>> +                    'echo $(loadaddr-y) | tr " " "\n" | sort | uniq')
>> +
>
> It's not important, but I think this can be written much simpler using
> makefile syntax as
>
> __ZRELADDR      := $(sort $(loadaddr-y))

Yes, correct. Just double checked by comparing the output. Your
proposal is much cleaner, will follow that if/when I send a V2.

Thanks,

/ magnus
