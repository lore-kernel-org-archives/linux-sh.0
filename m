From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 Jan 2015 19:53:30 +0000
Subject: Re: [PATCH 3/6] ARM: shmobile: kzm9g-reference dts: Add ak8975 magnetometer node
Message-Id: <CAMuHMdXpFG02W9xmBARU1joj2fpMH8xvP=FTxW5W_vscPM159A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420573329-12762-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420573329-12762-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Tue, Jan 6, 2015 at 8:51 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 01/06/2015 10:42 PM, Geert Uytterhoeven wrote:
>> Add a DT node for the AK8975 magnetometer sensor, which is connected to
>> i2c0.
>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>> Specify the device interrupt to avoid polling for end of conversion.
>
>> While at it rename the DT node to compass@c to describe the device's
>> function instead of its model.
>
>> Signed-off-by: Laurent Pinchart
>> <laurent.pinchart+renesas@ideasonboard.com>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>
>    You signed off on the patch twice?

Yep. I don't know a better way to squash other people's updates into
an earlier commit.

>> ---
>>   arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> index 02fc265332e8fb84..beabc3fd013b9ff0 100644
>> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>> @@ -189,6 +189,13 @@
>>   &i2c0 {
>>         status = "okay";
>>
>> +       compass@c {
>> +               compatible = "asahi-kasei,ak8975";
>> +               reg = <0x0c>;
>
>    Just 0xc?

Yep. This is an i2c bus.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
