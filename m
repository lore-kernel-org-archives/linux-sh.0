From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 03 Sep 2015 07:12:22 +0000
Subject: Re: [PATCH 1/2] [RFC] pinctrl: sh-pfc: r8a7795: Add pinmux data for single-function pins
Message-Id: <CAMuHMdVZBpoxRPfr817JOn18f+0emOEE3Bw4zrt-R6BErycuqg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441219910-28964-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441219910-28964-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Sep 3, 2015 at 2:10 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> +     PINMUX_DATA(AVS1_MARK, FN_AVS1),
>> +     PINMUX_DATA(AVS2_MARK, FN_AVS2),
>> +     PINMUX_DATA(HDMI0_CEC_MARK, FN_HDMI0_CEC),
>> +     PINMUX_DATA(HDMI1_CEC_MARK, FN_HDMI1_CEC),
>> +     PINMUX_DATA(MSIOF0_RXD_MARK, FN_MSIOF0_RXD),
>> +     PINMUX_DATA(MSIOF0_SCK_MARK, FN_MSIOF0_SCK),
>> +     PINMUX_DATA(MSIOF0_TXD_MARK, FN_MSIOF0_TXD),
>> +     PINMUX_DATA(SD2_CMD_MARK, FN_SD2_CMD),
>> +     PINMUX_DATA(SD3_CLK_MARK, FN_SD3_CLK),
>> +     PINMUX_DATA(SD3_CMD_MARK, FN_SD3_CMD),
>> +     PINMUX_DATA(SD3_DAT0_MARK, FN_SD3_DAT0),
>> +     PINMUX_DATA(SD3_DAT1_MARK, FN_SD3_DAT1),
>> +     PINMUX_DATA(SD3_DAT2_MARK, FN_SD3_DAT2),
>> +     PINMUX_DATA(SD3_DAT3_MARK, FN_SD3_DAT3),
>> +     PINMUX_DATA(SD3_DS_MARK, FN_SD3_DS),
>> +     PINMUX_DATA(SSI_SCK5_MARK, FN_SSI_SCK5),
>> +     PINMUX_DATA(SSI_SDATA5_MARK, FN_SSI_SDATA5),
>> +     PINMUX_DATA(SSI_WS5_MARK, FN_SSI_WS5),
>
> I think you can use PINMUX_IPSR_NOGP() for this purpose.
> And, you can find PINMUX_IPSR_NOGP() listed place in end of pinmux_data()

That macro indeed expands to the same.
But isn't PINMUX_IPSR_NOGP() intended for pins without a GPIO function?

Adding some comments to the PINMUX_*() macros would be helpful...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
