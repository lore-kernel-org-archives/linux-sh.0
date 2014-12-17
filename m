From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2014 09:51:54 +0000
Subject: Re: [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
Message-Id: <CANqRtoSdn7X6FzuBMp7mkb=mC7PP9-mE5_=w4x_3Py8nbayr-g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094214.7039.68681.sendpatchset@w520>
In-Reply-To: <20141217094214.7039.68681.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Dec 17, 2014 at 6:48 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Dec 17, 2014 at 10:42 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Adjust the load address for the KZM9G DT reference case
>> to make it compatible with upcoming sh73a0 Multiplatform
>> and CONFIG_AUTO_ZRELADDR=y.
>>
>> Without the not-yet-merged sh73a0 multiplatform support
>> the KZM9G uImage can be built without any special care,
>> but once we go DTS-only then the Makefile.boot entry will
>> disappear and the Multiplatform image will be built using
>> CONFIG_AUTO_ZRELADDR=y. To generate an uImage for KZM9G
>> the following example can be followed:
>>
>> $ make ARCH=arm LOADADDR=0x48008000 uImage
>>
>> For now simply adjust the non-multiplatform KZM9G DT
>> reference implementation to be compatible with ZRELADDR.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Does this mean it now boots with reg = <0x41000000 0x1e800000>
> in the memory node, and
> [PATCH/RFC 1/2] ARM: shmobile: kzm9g dts: Declare the full 512 MiB of RAM
> http://www.spinics.net/lists/linux-sh/msg37196.html
> [PATCH/RFC 2/2] ARM: shmobile: kzm9g-reference dts: Declare the full
> 512 MiB of RAM
> http://www.spinics.net/lists/linux-sh/msg37195.html
> are not needed?

Thanks, but I believe they are not needed.

The new load address is compatible with the ZRELADDR 0xf8000000 mask
and that's all it takes.

I may be wrong though, let me know if you run into trouble.

Cheers,

/ magnus
