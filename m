From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 13:36:48 +0000
Subject: Re: [PATCH 1/6] reset: Add renesas,rst DT bindings.
Message-Id: <CAMuHMdWtYw_AMbR9suJOTQpw2x8h7CQvnXUbKz9f=60NHo47Kw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441120361-1232-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441120361-1232-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Philipp,

On Wed, Sep 2, 2015 at 2:40 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Am Dienstag, den 01.09.2015, 17:12 +0200 schrieb Geert Uytterhoeven:
>> Add DT bindings for the Renesas R-Car Reset Controller
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  .../devicetree/bindings/reset/renesas,rst.txt      | 28 ++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt
>>
>> diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
>> new file mode 100644
>> index 0000000000000000..aabf8dc6bce86ffc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
>> @@ -0,0 +1,28 @@
>> +DT bindings for the Renesas R-Car Reset Controller
>> +
>> +The R-Car Reset Controller provides reset control, and implements the following
>> +functions:
>> +  - Register-based reset control for the various CPU cores,
>
> Could any of these ever be used by other device tree nodes?
> If so, the reset-controller node should contain the #reset-cells
> property.

Possibly. That would require defining a format for the reset specifier, which
we haven't done yet (one or two numbers?).
There can be multiple reset registers, handling multiple CPU cores each,
depending on the SoC.

For now we're interested in the mode monitoring feature only, for obtaining
the values of the boot mode pins.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
