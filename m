From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Jan 2015 17:32:31 +0000
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Message-Id: <CAMuHMdW7ETcFGSPiE9BWA2dAE93477fzoyF-+_EaiPSDT9WMWA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<20150115170209.GA6342@katana>
In-Reply-To: <20150115170209.GA6342@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Jan 15, 2015 at 6:02 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
>> @@ -18,8 +18,7 @@ adi,adt7475         +/-1C TDM Extended Temp Range I.C
>>  adi,adt7476          +/-1C TDM Extended Temp Range I.C
>>  adi,adt7490          +/-1C TDM Extended Temp Range I.C
>>  adi,adxl345          Three-Axis Digital Accelerometer
>> -adi,adxl346          Three-Axis Digital Accelerometer
>> -adi,adxl34x          Three-Axis Digital Accelerometer
>> +adi,adxl346          Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
>
> I'd rather drop 346 because there is no compatible for that one anywhere.
> No need to resend, I can fix it here...

If you drop adi,adxl346, checkpatch will start complaining if it encounters
it in a .dts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
